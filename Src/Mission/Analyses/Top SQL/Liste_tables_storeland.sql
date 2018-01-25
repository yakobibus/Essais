set lines 333 pages 2000 long 999999999
spool %temp%\STORELAND_TBL.lst

with vue_ut as (
select ut.* 
  from user_tables ut 
)
select v.tablespace_name
     , v.table_name
     , v.num_rows
     , v.blocks
     , v.empty_blocks
     , v.avg_row_len
     , v.last_analyzed
     , v.initial_extent
     , v.max_extents
     , v.next_extent
     , v.logging
     --, v.* 
  from vue_ut v
;
spool off
