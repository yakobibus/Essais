/*
** Trouver les tables fragmentées
**/

select dt.table_name
     , round((dt.blocks * 8), 2) "size (kb)" 
     , round((dt.num_rows * dt.avg_row_len / 1024), 2) "actual_data (kb)"
     , (round((dt.blocks * 8), 2) - round((dt.num_rows * dt.avg_row_len / 1024), 2)) "wasted_space (kb)"
  from dba_tables dt
 where (round((dt.blocks * 8), 2) > round((dt.num_rows * dt.avg_row_len / 1024), 2))
 order by 4 desc
;

select dt.owner
     , dt.table_name
     , round((dt.blocks * 8), 2) || 'kb' "Fragmented size"
     , round((dt.num_rows * dt.avg_row_len / 1024), 2) || 'kb' "Actual size"
     , round((dt.blocks * 8), 2) - round((dt.num_rows * dt.avg_row_len / 1024), 2)||'kb'
     , ((round((dt.blocks * 8), 2) - round((dt.num_rows * dt.avg_row_len / 1024), 2)) / round((dt.blocks * 8), 2)) * 100 - 10 "reclaimable space % "
  from dba_tables dt
 where dt.table_name = '&table_Name'
   AND dt.OWNER LIKE '&schema_name'
;
