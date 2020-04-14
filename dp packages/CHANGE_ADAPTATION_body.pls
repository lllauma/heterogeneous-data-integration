create or replace package body change_adaptation as
  -- Change status
  CONST_NEW_CHANGE                types.tp_id%type := 'STT0000001';
  CONST_IN_PROGRESS               types.tp_id%type := 'STT0000002';
  
  -- Change adaptation type
  CONST_MANUAL                    types.tp_id%type := 'COP0000001';
  CONST_AUTOMATIC                 types.tp_id%type := 'COP0000002';
  
  -- Change integration status
  CONST_NOT_INTEGRATED            types.tp_id%type := 'CIP0000001';
  CONST_INTEGRATED                types.tp_id%type := 'CIP0000002';
  
  -- Process author
  CONST_SYSTEM_AUTHOR              author.au_id%type := 3;
    
  -- Change subtype prefix
  CONST_METADATA_PROPERTY         varchar2(50) := 'METADATA PROPERTY';
  CONST_DATA_ITEM                 varchar2(50) := 'DATA ITEM';
  CONST_DATA_HIGHWAY_LVL          varchar2(50) := 'DATA HIGHWAY LEVEL';
  CONST_DATA_SET                  varchar2(50) := 'DATA SET';
  CONST_METADATA_VAL_UPDATE       varchar2(50) := 'METADATA VALUE UPDATE';
  
  -- Scenario step condition type
  CONST_MANUAL_CONDITION          types.tp_id%type := 'CON0000002';
  CONST_AUTOMATIC_CONDITION       types.tp_id%type := 'CON0000001';
  
  
  type t_scenario_step is record (
      operation_type        types.tp_type%type,
      operation_type_id     changeadaptationoperation.cao_operationtype_id%type,
      operation_instruction changeadaptationoperation.cao_operation%type,
      operation_status      types.tp_type%type,
      operation_status_id   changeadaptationprocess.cap_statustype_id%type,
      manual_condition      changeadaptationcondition.cac_condition%type,
      automatic_condition   changeadaptationcondition.cac_condition%type
  );

---- Finds subtype from given pi_parenttype and type description prefix (description without keywords 'addition', 'deletion' at the end)-----------------------------------------------------
  function find_subtype_by_parenttype(in_parenttype in types.tp_parenttype_id%type,
                                      in_type       in varchar2) return types.tp_id%type is
   v_subtype types.tp_id%type default null;
  begin
    begin   
        select t.tp_id
          into v_subtype
          from types t
         where t.tp_parenttype_id = in_parenttype
           and UPPER(t.tp_type) like in_type||'%';
    exception
        when others then
            log_error('Subtype not found! CHANGE_PARENTTYPE_ID=' || in_parenttype || '; CHANGE_TYPE_ID=' || in_type); 
    end;
    
    return v_subtype;
  end find_subtype_by_parenttype;

---- Defines exact change type (subtype) by change record------------------------------------------------------------------------------------------------------------------------------------
  function define_change_type(in_change in change%rowtype) return types.tp_id%type is
    v_subtype_prefix varchar2(50);
    v_type types.tp_id%type default null;
  begin
    case
      when in_change.ch_metadataproperty_id is not null then
        v_subtype_prefix := CONST_METADATA_PROPERTY;
      when in_change.ch_datahighwaylevel_id is not null then
        v_subtype_prefix := CONST_DATA_HIGHWAY_LVL;
      /*when in_change.ch_attrname is not null then
        v_subtype_prefix := CONST_METADATA_VAL_UPDATE;
      when in_change.ch_metadataproperty_id is not null then
        v_subtype_prefix := CONST_METADATA_PROPERTY;
      when in_change.ch_dataitem_id is not null then
        v_subtype_prefix := CONST_DATA_ITEM;
      when in_change.ch_dataset_id is not null then
        v_subtype_prefix := CONST_DATA_SET;*/
      else
        log_error('Could not detect change type! CHANGE_ID: ' || in_change.ch_id);
    end case;
     
    if v_subtype_prefix is not null then
      v_type := find_subtype_by_parenttype(in_change.ch_changetype_id, v_subtype_prefix);
    end if;
    
    return v_type;     
     
  end define_change_type;
  
---- Insert process record with status 'Not integrated'    ----------------------------------------------------------------------------------------------------------------------------------
  procedure insert_change_adaptation_process(in_scenario_id in changeadaptationscenario.cas_id%type,
                                              in_change_id   in change.ch_id%type) is    
    v_process changeadaptationprocess%rowtype;
  begin
                                  
    v_process := null;
    v_process.cap_id := CHANGEADAPTATIONPROCESS_SQ.nextval;
    v_process.cap_scenario_id := in_scenario_id;
    v_process.cap_datetime := sysdate;
    v_process.cap_author_id := CONST_SYSTEM_AUTHOR;
    v_process.cap_statustype_id := CONST_NOT_INTEGRATED;
    v_process.cap_change_id := in_change_id;
            
    insert into changeadaptationprocess 
         values v_process;
        
  end insert_change_adaptation_process;
 
---- Update change record to 'In progress'---------------------------------------------------------------------------------------------------------------------------------------------------
  procedure update_change_in_progress(in_change_id change.ch_id%type)is
  begin
    
    update change c
       set c.ch_statustype_id = CONST_IN_PROGRESS
     where c.ch_id = in_change_id;
             
    if SQL%rowcount = 0 then 
      log_error('Could not find change record! CHANGE_ID=' || in_change_id);
    end if;
    
  end update_change_in_progress;
  
---- Creates adaptation processes for all not adapted changes--------------------------------------------------------------------------------------------------------------------------------
  procedure create_change_adaptation_processes is    
    v_change_type     types.tp_id%type;
    v_process_created boolean;
  begin
    -- loops through all new changes
    for new_change in (select *
                         from change c
                        where c.ch_statustype_id = CONST_NEW_CHANGE
                        order by c.ch_id
                    ) loop
      v_process_created := false;
      v_change_type := define_change_type(new_change);
      dbms_output.put_line(v_change_type); 
      if v_change_type is not null then
          --  for each new change finds all possible integration scenario steps              
          for scenario_step in (select cas.cas_id
                                  from changeadaptationscenario cas
                                 where cas.cas_changetype_id = v_change_type
                                 start with cas.cas_parentscenario_id is null
                               connect by prior cas.cas_id = cas_parentscenario_id
                                 order by cas.cas_operation_id) loop
                                 
            insert_change_adaptation_process(scenario_step.cas_id, new_change.ch_id);
            v_process_created := true;
            dbms_output.put_line('Process step created!');            
          end loop;
          
          if v_process_created then
            update_change_in_progress(new_change.ch_id);          
            dbms_output.put_line('Change status updated!');
          end if;
           
          dbms_output.put_line('   ');
      end if;
    end loop;
  end create_change_adaptation_processes;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  procedure add_dataset_example(in_change_id in change.ch_id%type,
                                in_data_type in types.tp_id%type,
                                in_data      in changeadaptationadditionaldata.caad_data%type) is
            
  begin
    insert into changeadaptationadditionaldata values (CHANGEADAPTATIONADDITIONALDATA_SQ.nextval, in_data_type, in_change_id, in_data);
  end add_dataset_example;
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  function dataset_example_added(in_change_id in change.ch_id%type) return boolean is
    v_added_count number;
    v_is_added boolean default false;
  begin
    select count(1)
      into v_added_count
      from changeadaptationadditionaldata caad
     where caad.caad_change_id = in_change_id;
     
    if v_added_count = 1 then
      v_is_added := true;    
    end if;
    
    return v_is_added;    
  end dataset_example_added;
  
---- Returns scenario with all conditions----------------------------------------------------------------------------------------------------------------------------------------------------
  function get_change_adaptation_scenario(in_change_id in change.ch_id%type) return sys_refcursor is
    v_scenario sys_refcursor;
  begin
    open v_scenario for
      select op_t.tp_type             operation_type, 
             cao.cao_operationtype_id operation_type_id,
             cao.cao_operation        operation_instruction, 
             pr_st.tp_type            operation_status, 
             proc.cap_statustype_id   operation_status_id, 
             proc.manual_condition    manual_condition,
             proc.automatic_condition automatic_condition
        from (select cap.cap_statustype_id, 
                     cas.*,
                     (select listagg(cac.cac_condition, '; ') within group (order by cac.cac_id)
                        from ca_conditionmapping cm
                       inner join changeadaptationcondition cac on cac.cac_id = cm.cacm_condition_id
                       where cm.cacm_scenario_id = cas.cas_id
                         and cac.cac_conditiontype_id = CONST_MANUAL_CONDITION) manual_condition,
                     (select listagg(cac.cac_condition, '; ') within group (order by cac.cac_id)
                        from ca_conditionmapping cm
                       inner join changeadaptationcondition cac on cac.cac_id = cm.cacm_condition_id
                       where cm.cacm_scenario_id = cas.cas_id
                         and cac.cac_conditiontype_id = CONST_AUTOMATIC_CONDITION) automatic_condition
                from changeadaptationprocess cap
               inner join changeadaptationscenario cas on cas.cas_id = cap.cap_scenario_id
               where cap.cap_change_id = in_change_id) proc
       inner join changeadaptationoperation cao on cao.cao_id = proc.cas_operation_id
       inner join types op_t on op_t.tp_id = cao.cao_operationtype_id
       inner join types pr_st on pr_st.tp_id = proc.cap_statustype_id
       start with proc.cas_parentscenario_id is null
     connect by prior proc.cas_operation_id = proc.cas_parentscenario_id;
   
   return v_scenario;
  exception
    when no_data_found then
      log_error('Change not found! CHANGE_ID=' || in_change_id);
  end get_change_adaptation_scenario;

---- Tries to execute adaptation scenario for specific change (only consecutive, not already adapted and automatic change scenario operations can be executed)
  procedure run_change_adaptation_scenario(in_change_id in change.ch_id%type) is
    v_change_scenario sys_refcursor;   
    v_scenario_step t_scenario_step;
  begin
    v_change_scenario := get_change_adaptation_scenario(in_change_id);
    loop
      fetch v_change_scenario into v_scenario_step;
      exit when v_change_scenario%notfound;
        
      -- processes only not integrated automatic changes in or
      if v_scenario_step.operation_status_id = CONST_NOT_INTEGRATED then
        
        if v_scenario_step.operation_type_id = CONST_AUTOMATIC then
          null;-- execute_immediate v_scenario_step.operation_instruction;
           
        else
          exit;
        end if;
          
      end if;
    end loop;
  end run_change_adaptation_scenario;  

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  procedure process_change_adaptations is
  begin
    for ch in (select c.ch_id
                     from change c
                    where c.ch_statustype_id = CONST_IN_PROGRESS) loop
                    
      run_change_adaptation_scenario(ch.ch_id);
      
    end loop;
  end process_change_adaptations;
  
---- Processes all uningtegrated changes-----------------------------------------------------------------------------------------------------------------------------------------------------
  procedure adapt_changes is    
  begin
    create_change_adaptation_processes;
    
    process_change_adaptations;
  end adapt_changes;

end change_adaptation;