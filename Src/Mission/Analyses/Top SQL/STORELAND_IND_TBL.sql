set lines 433 pages 2000 long 999999999
spool %temp%\STORELAND_IND_TBL.lst

select di.owner
     , di.table_name
     , di.index_name
     , di.index_type
     , di.uniqueness
     , di.num_rows
     , di.sample_size
     , di.last_analyzed
     , di.global_stats
     , di.initial_extent
     , di.max_extents
     , di.next_extent
  from user_tables ut
       inner join dba_indexes di on di.table_name = ut.table_name
;
spool off
