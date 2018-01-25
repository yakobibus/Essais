/*
** Recompilation des objets invalides
**/

Declare
  cVc_owner constant varchar2 (30) := 'STORELAND' ;
begin
  for laChose in (select object_name, object_type
                    from all_objects  
                   where object_type in (  'PACKAGE'
	                                       , 'PACKAGE BODY'
	                                       , 'PROCEDURE'
	                                       , 'FUNCTION'
	                                       , 'VIEW'
	                                       , 'TRIGGER'
	                                      )
                   and owner = cVc_owner
                   and status = 'INVALID'
                 order by object_type asc
  ) loop
      begin
        case laChose.object_type
          when 'PACKAGE' then
            execute immediate  'alter package ' || laChose.object_name || ' compile' ;
          when 'PACKAGE BODY' then
            execute immediate  'alter package ' || laChose.object_name  || ' compile body' ;
          when 'PROCEDURE' then
            execute immediate  'alter procedure ' || laChose.object_name  || ' compile' ;
          when 'FUNCTION' then
            execute immediate  'alter function ' || laChose.object_name  || ' compile' ;
          when 'VIEW' then
            execute immediate  'alter view ' || laChose.object_name  || ' compile' ;
        when 'TRIGGER' then
          execute immediate  'alter trigger ' || laChose.object_name  || ' compile' ;
        end case;
      exception
        when others then
          dbms_output.put_line('Erreur sur [' || laChose.object_name || ', ' || laChose.object_type || '] : ' || sqlerrm);
      end;    
  end loop;
end;
/
