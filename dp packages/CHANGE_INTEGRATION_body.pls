create or replace package body change_integration as

  --Main procedure for changes integration
  --Processes all uningtegrated changes
  procedure integrate_changes is
  begin
    for change in (select * 
                     from change c
                    where c.ch_changetype_id = CONST_NEW_CHANGE) loop
      null;
    end loop;
    
  end integrate_changes;

  procedure integrate_addition is
  begin
    null;
  end integrate_addition;
  

end change_integration;