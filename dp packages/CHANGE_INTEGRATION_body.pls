create or replace package body change_integration as
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
        when no_data_found then
        dbms_output.put_line('Subtype not found! ' || in_parenttype || '  ' || in_type); 
    end;
    
    return v_subtype;
  end find_subtype_by_parenttype;

  -- Defines exact change type (subtype) by change record
  function define_change_type(in_change in change%rowtype) return types.tp_id%type is
    v_subtype_prefix varchar2(50);
  begin
    case
      when in_change.ch_attrname is not null then
        v_subtype_prefix := CONST_METADATA_VAL_UPDATE;
      when in_change.ch_metadataproperty_id is not null then
        v_subtype_prefix := CONST_METADATA_PROPERTY;
      when in_change.ch_dataitem_id is not null then
        v_subtype_prefix := CONST_DATA_ITEM;
      when in_change.ch_datahighwaylevel_id is not null then
        v_subtype_prefix := CONST_DATA_HIGHWAY_LVL;
      when in_change.ch_dataset_id is not null then
        v_subtype_prefix := CONST_DATA_SET;
      else
        dbms_output.put_line('Change can not be detected!');
    end case;
     
    return find_subtype_by_parenttype(in_change.ch_changetype_id, v_subtype_prefix);
     
     
  end define_change_type;
  
  -- Processes all uningtegrated changes
  procedure integrate_changes is
    v_process changeintegrationprocess%rowtype;
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
          for scenario_step in (select cis.cis_id
                                  from changeintegrationscenario cis
                                 where cis.cis_changetype_id = v_change_type
                                 start with cis.cis_parentscenario_id is null
                               connect by prior cis.cis_id = cis_parentscenario_id
                                 order by cis.cis_operation_id) loop
                                 
            -- Inserts process records with status 'Not integrated'            
            v_process := null;
            v_process.cip_id := CHANGEINTEGRATIONPROCESS_SQ.nextval;
            v_process.cip_scenario_id := scenario_step.cis_id;
            v_process.cip_datetime := sysdate;
            v_process.cip_author_id := CONST_SYSTEM_AUTHOR;
            v_process.cip_statustype_id := CONST_NOT_INTEGRATED;
            v_process.cip_change_id := new_change.ch_id;
            
            insert into changeintegrationprocess 
                 values v_process;
            
            -- updates change record to 'In progress'
            update change c
               set c.ch_statustype_id = CONST_IN_PROGRESS
             where c.ch_id = new_change.ch_id;
            
            dbms_output.put_line('Success! ('|| v_process.cip_id ||')');
          end loop;
      end if;
    end loop;
    
  end integrate_changes;

end change_integration;