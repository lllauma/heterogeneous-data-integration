create or replace package body change_adaptation as
  -- Change status
  CONST_NEW_CHANGE                types.tp_id%type := 'STT0000001';
  CONST_IN_PROGRESS               types.tp_id%type := 'STT0000002';
  
  -- Change integration status
  CONST_NOT_INTEGRATED            types.tp_id%type := 'CIP0000001';
  
  -- Process author
  CONST_SYSTEM_AUTHOR              author.au_id%type := 3;
    
  -- Change subtype prefix
  CONST_METADATA_PROPERTY         varchar2(50) := 'METADATA PROPERTY';
  CONST_DATA_ITEM                 varchar2(50) := 'DATA ITEM';
  CONST_DATA_HIGHWAY_LVL          varchar2(50) := 'DATA HIGHWAY LEVEL';
  CONST_DATA_SET                  varchar2(50) := 'DATA SET';
  CONST_METADATA_VAL_UPDATE       varchar2(50) := 'METADATA VALUE UPDATE';

  -- Finds subtype from given pi_parenttype and type description prefix (description without keywords 'addition', 'deletion' at the end)
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

  -- Defines exact change type (subtype) by change record
  function define_change_type(in_change in change%rowtype) return types.tp_id%type is
    v_subtype_prefix varchar2(50);
    v_type types.tp_id%type default null;
  begin
    case
      /*when in_change.ch_attrname is not null then
        v_subtype_prefix := CONST_METADATA_VAL_UPDATE;
      when in_change.ch_metadataproperty_id is not null then
        v_subtype_prefix := CONST_METADATA_PROPERTY;
      when in_change.ch_dataitem_id is not null then
        v_subtype_prefix := CONST_DATA_ITEM;*/
      when in_change.ch_datahighwaylevel_id is not null and in_change.ch_attrname is null then
        v_subtype_prefix := CONST_DATA_HIGHWAY_LVL;
      /*when in_change.ch_dataset_id is not null then
        v_subtype_prefix := CONST_DATA_SET;*/
      else
        log_error('Could not detect change type! CHANGE_ID: ' || in_change.ch_id);
    end case;
     
    if v_subtype_prefix is not null then
      v_type := find_subtype_by_parenttype(in_change.ch_changetype_id, v_subtype_prefix);
    end if;
    
    return v_type;     
     
  end define_change_type;
  
  -- Insert process record with status 'Not integrated'    
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
 
  -- Update change record to 'In progress'
  procedure update_change_in_progress(in_change_id change.ch_id%type)is
  begin
    
    update change c
       set c.ch_statustype_id = CONST_IN_PROGRESS
     where c.ch_id = in_change_id;
             
    if SQL%rowcount = 0 then 
      log_error('Could not find change record! CHANGE_ID=' || in_change_id);
    end if;
    
  end update_change_in_progress;
  
  -- Processes all uningtegrated changes
  procedure adapt_changes is
    v_change_type types.tp_id%type;
    
  begin
    -- loops through all new changes
    for new_change in (select *
                         from change c
                        where c.ch_statustype_id = CONST_NEW_CHANGE
                        order by c.ch_id
                    ) loop
      v_change_type := define_change_type(new_change);
      
      if v_change_type is not null then
          --  for each new change finds all possible integration scenario steps              
          for scenario_step in (select cas.cas_id
                                  from changeadaptationscenario cas
                                 where cas.cas_changetype_id = v_change_type
                                 start with cas.cas_parentscenario_id is null
                               connect by prior cas.cas_id = cas_parentscenario_id
                                 order by cas.cas_operation_id) loop
                                 
            insert_change_adaptation_process(scenario_step.cas_id, new_change.ch_id);
            
            update_change_in_progress(new_change.ch_id);
            
          end loop;
      end if;
    end loop;
    
  end adapt_changes;

end change_adaptation;