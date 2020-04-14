create or replace package change_adaptation as

  function define_change_type(in_change in change%rowtype) return types.tp_id%type;
  
  function get_change_adaptation_scenario(in_change_id in change.ch_id%type) return sys_refcursor;
  
  procedure adapt_changes;
  
  function dataset_example_added(in_change_id in change.ch_id%type) return boolean;

end change_adaptation;