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
