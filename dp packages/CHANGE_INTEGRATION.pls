create or replace package change_integration as

  function define_change_type(in_change in change%rowtype) return types.tp_id%type;
  
  procedure integrate_changes;

end change_integration;