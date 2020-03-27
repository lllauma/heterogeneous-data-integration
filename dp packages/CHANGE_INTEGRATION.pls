create or replace 
package change_integration as 

  CONST_NEW_CHANGE varchar2(10) := 'STT0000001';
  
  procedure integrate_changes;

end change_integration;
