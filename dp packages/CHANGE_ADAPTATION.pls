create or replace package change_adaptation as

  function define_change_type(in_change in change%rowtype) return types.tp_id%type;
  
  procedure adapt_changes;

end change_adaptation;