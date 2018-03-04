/*
**/

create or replace
package p_test as
  konst constant varchar2 (55) := 'Konstante' ;
  vari varchar2 (55) := 'Ajustable' ;
  entier pls_integer := 55 ;
  --
  procedure la_proc(p_v in varchar2, p_n out number);
  function  la_func(i in pls_integer) return varchar2 ;
end p_test;
/
show errors

create or replace
package body p_test as
   procedure la_proc(p_v in varchar2, p_n out number) is
   begin
     dbms_output.put_line ('Dans p_test.laproc : ' || p_v);
     p_n := entier ;
   end la_proc;
  
   function  la_func(i in pls_integer) return varchar2 is
   begin
  
     return case when i <= 10 then vari else konst end ;
   end la_func;
end p_test;
/
show errors
