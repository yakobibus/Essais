/*
**/

create or replace
TYPE id_t AS OBJECT (
  scheme varchar2(255),
  issuer varchar2(255),
  id varchar2(255)
)
;
/


create or replace
TYPE idtable_t is TABLE OF own_07755_common.id_t
;
/
