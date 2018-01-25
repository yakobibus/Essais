col COLUMN_NAME format a30

set lines 300 pages 2000 long 999999999
spool %temp%\STORELAND_IND_COLUMNS.lst

select di.owner
     , dic.column_name
     , dic.column_position
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
       inner join dba_ind_columns dic on dic.index_name = di.index_name 
 --where ut.table_name like 'LBM_CLIENT_TOP'
;
spool off
