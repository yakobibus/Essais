/*
** Recompilation des objets compilés en mode debug
**/

Declare
  cVc_owner constant varchar2 (30) := 'STORELAND' ;
begin
  for laChose in (select name, type
                    from all_plsql_object_settings  
                   where type in (  'PACKAGE'
	                                , 'PACKAGE BODY'
	                                , 'PROCEDURE'
	                                , 'FUNCTION'
                                  , 'TRIGGER'
	                               )
                   and owner = cVc_owner
                   and plsql_debug = 'TRUE' 
                 order by type asc, name asc
      ) loop
          begin
              case laChose.type
              when 'PACKAGE' then
                execute immediate  'alter package ' || laChose.name || ' compile' ;
              when 'PACKAGE BODY' then
                execute immediate  'alter package ' || laChose.name  || ' compile body' ;
              when 'PROCEDURE' then
                execute immediate  'alter procedure ' || laChose.name  || ' compile' ;
              when 'FUNCTION' then
                execute immediate  'alter function ' || laChose.name  || ' compile' ;
            when 'TRIGGER' then
              execute immediate  'alter trigger ' || laChose.name  || ' compile' ;
            end case;
          exception
            when others then
              dbms_output.put_line('Erreur sur [' || laChose.name || ', ' || laChose.type || '] : ' || sqlerrm);
          end;    
      end loop;
end;
/
