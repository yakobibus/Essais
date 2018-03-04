/*
**/

create or replace
TYPE link_t AS OBJECT (
      linked_uuid RAW(16) ,
      linked_objecttype varchar(3),
      linked_role varchar(64)
) ;
/

create or replace
TYPE linkArray_t is VARRAY(15) OF own_07755_common.link_t ;
/


create or replace
TYPE linkTable_t is TABLE OF own_07755_common.link_t ;
/
