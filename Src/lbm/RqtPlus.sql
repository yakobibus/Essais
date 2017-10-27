-- Sur l'utilisation de la mémpoire pour les tris :
-- objet : produire un graphique Nombre de tris en fonction des jours de la semaine

set pages 9999
column sorts_memory  format 999,999,999
column sorts_disk    format 999,999,999
column ratio         format .99999

select to_char (snap_time, 'day')
     , avg (newmem.value - oldmem.value) sorts_memory
     , avg (newdsk.value - olddsk.value) sorts_disk  
  from perfstat.stats$sysstat  oldmem
     , perfstat.stats$sysstat  newmem
     , perfstat.stats$sysstat  olddsk
     , perfstat.stats$sysstat  sn
 where newdsk.snap_id = sn.snap_id
   and olddsk.snap_id = sn.snap_id -1
   and mewmem.snap_id = sn.snap_id
   and oldmem.snap_id = sn.snap_id -1
   and oldmem.name = 'sorts (memory)'
   and newmem.name = 'sorts (memory)'
   and olddsk.name = 'sorts (disk)'
   and newdsk.name = 'sorts (disk)'
   and newmem.value - oldmem.value > 0
group by to_char (snap_time, 'day')
;
----
-- objet : produire un graphique Nombre de tris en fonction des tranches horaires de la journée

set pages 9999
column sorts_memory  format 999,999,999
column sorts_disk    format 999,999,999
column ratio         format .99999

select to_char (snap_time, 'hh24')
     , avg (newmem.value - oldmem.value) sorts_memory)
     , avg (newdsk.value - olddsk.value) sorts_disk  
  from perfstat.stats$sysstat  oldmem
     , perfstat.stats$sysstat  newmem
     , perfstat.stats$sysstat  olddsk
     , perfstat.stats$sysstat  sn
 where newdsk.snap_id = sn.snap_id
   and olddsk.snap_id = sn.snap_id -1
   and mewmem.snap_id = sn.snap_id
   and oldmem.snap_id = sn.snap_id -1
   and oldmem.name = 'sorts (memory)'
   and newmem.name = 'sorts (memory)'
   and olddsk.name = 'sorts (disk)'
   and newdsk.name = 'sorts (disk)'
   and newmem.value - oldmem.value > 0
group by to_char (snap_time, 'hh24')
;


-----------

Et aussi ASH :
Voir V$ACTIVE_SESSION_HISTORY  ppt*.pdf pp 21/50

	Existe-t-il ce fichier sur le serveur (Simpleash.sql) ?
ASH: Top SQL
•	Returns most active SQL in the past minute
  select sql_id
       , count(1)
       , round(count(1)
         / sum(count(1)) over (), 2)pctload
   from v$active_session_history
  where sample_time > sysdate -1/24/60
    and session_type <> 'BACKGROUND'
  group by sql_id
  order by 2 desc -- count(1) desc
  ;



ASH: Top IO SQL
Returns SQL spending most time doing I/Os
Similarly, can do Top Sessions, Top Files, Top Objects
select ash.sql_id, count(1)
  from v$active_session_history ash
     , v$event_name evt
 where ash.sample_time > sysdate –1/24/60
   and ash.session_state = 'WAITING'
   and ash.event_id = evt.event_id
   and evt.wait_class = 'User I/O'
 group by sql_id
 order by count(1) desc
;

Voir DBA_HIST_ACTIVE_SESS_HISTORY
ASH : Bad SQL
select e.event
     , e.total_waits -nvl(b.total_waits,0) total_waits
     , e.time_waited -nvl(b.time_waited,0) time_waited
  from v$active_session_history b
     , v$active_session_history e
     , stats$snapshot sn
 Where snap_time > sysdate - &1 --- A fournir
   And e.event not like '%timer'
   And e.event not like '%message%'
   And e.event not like '%slave wait%'
   And e.snap_id =sn.snap_id
   And b.snap_id = e.snap_id-1
   And b.event = e.event
   And e.total_timeouts > 100
   And (e.total_waits -b.total_waits > 100
    or e.time_waited -b.time_waited > 100)
;

select sum(a.time_waited) total_time
  from v$active_session_history a
     , v$event_name b
 where a.event# = b.event# 
   and sample_time between to_date ('201710201300', 'yyyymmddhh24mi') 
                       and to_date ('201710202001', 'yyyymmddhh24mi') 
   and b.wait_class = 'User I/O'
;

select sess_id
     , username
     , program
     , wait_event
     , sess_time
     , round(100 * (sess_time / total_time),2) pct_time_waited
  from (select a.session_id sess_id
             , decode(session_type, 'background', session_type, c.username) username
             , a.program program
             , b.name wait_event
             , sum(a.time_waited) sess_time
          from sys.v_$active_session_history a
             , sys.v_$event_name b
             , sys.dba_users c
        where a.event# = b.event# 
          and a.user_id = c.user_id 
          and sample_time between to_date ('201710201300', 'yyyymmddhh24mi')  
                              and to_date ('201710202001', 'yyyymmddhh24mi') 
          and b.wait_class = 'User I/O'
         group by a.session_id
                , decode(session_type, 'background', session_type, c.username)
                , a.program
                , b.name
       )
     , (select sum(a.time_waited) total_time
          from sys.v_$active_session_history a
             , sys.v_$event_name b
        where a.event# = b.event# 
          and sample_time between to_date ('201710201300', 'yyyymmddhh24mi')  
                              and to_date ('201710202001', 'yyyymmddhh24mi') 
          and b.wait_class = 'User I/O'
        )
 order by 6 desc
;

Voir sys.v_$sys_time_model
select case db_stat_name
           when 'parse time elapsed' then 
               'soft parse time'
           else db_stat_name
       end db_stat_name
     , case db_stat_name
           when 'sql execute elapsed time' then 
               time_secs - plsql_time 
           when 'parse time elapsed' then 
               time_secs - hard_parse_time
           else time_secs
       end time_secs
     , case db_stat_name
           when 'sql execute elapsed time' then 
               round(100 * (time_secs - plsql_time) / db_time,2)
           when 'parse time elapsed' then 
               round(100 * (time_secs - hard_parse_time) / db_time,2)  
           else round(100 * time_secs / db_time,2)  
       end pct_time
  from (select stat_name db_stat_name
             , round((value / 1000000),3) time_secs
          from sys.v_$sys_time_model
         where stat_name not in('DB time'
                               ,'background elapsed time'
                               ,'background cpu time'
                               ,'DB CPU'
                               )
       )
     , (select round((value / 1000000),3) db_time 
          from sys.v_$sys_time_model 
         where stat_name = 'DB time'
       )
     , (select round((value / 1000000),3) plsql_time 
          from sys.v_$sys_time_model 
         where stat_name = 'PL/SQL execution elapsed time'
       )
    , (select round((value / 1000000),3) hard_parse_time 
         from sys.v_$sys_time_model 
        where stat_name = 'hard parse elapsed time'
      )
 order by 2 desc
;

Dire quel type de process pass  le plus de temps à faire attendre :
select to_char(a.end_time,'DD-MON-YYYY HH:MI:SS') end_time
     , b.wait_class
     , round((a.time_waited / 100),2) time_waited 
  from sys.v_$waitclassmetric_history a
     , sys.v_$system_wait_class b
 where a.wait_class# = b.wait_class# 
   and b.wait_class != 'Idle'
 order by 1,2
;

--
1.1.1	Response-Time Analysis Made Easy
Starting at the global or system level, DBAs typically want answers to these questions:
•	In general, how well is my database running? What defines efficiency?
•	What average response time are my users experiencing?
•	Which activities affect overall response time the most?
1.1.1.1	Part of the answer to how well, in general, a database is running
The query  above helps you determine if your database is currently experiencing a high percentage of waits/bottlenecks vs. smoothly running operations. The Database CPU Time Ratio is calculated by dividing the amount of CPU expended in the database by the amount of "database time," which is defined as the time spent by the database on user-level calls (with instance background process activity being excluded). High values (90-95+ percent) are good and indicate few wait/bottleneck actions, but take this threshold only as a general rule of thumb because every system is different
select metric_name,
       value
  from SYS.V_$SYSMETRIC
 where metric_name IN ( 'Database CPU Time Ratio'
                      , 'Database Wait Time Ratio'
                      ) 
   and intsize_csec = (select max(intsize_csec)
                         from SYS.V_$SYSMETRIC
                      )
;

You can also take a quick look over the last hour to see if the database has experienced any dips in overall performance by using this query:
select end_time
     , value
  from sys.v_$sysmetric_history
 where metric_name = 'Database CPU Time Ratio'
order by 1
;

And, you can get a good idea of the minimum, maximum, and average values of overall database efficiency by querying the V$SYSMETRIC_SUMMARY view with a query such as this:
select Case metric_name
            When 'SQL Service Response Time' then 'SQL Service Response Time (secs)'
            When 'Response Time Per Txn' then 'Response Time Per Txn (secs)'
            Else metric_name
       End metric_name
     , Case metric_name
            When 'SQL Service Response Time' then round((minval / 100),2)
            When 'Response Time Per Txn' then round((minval / 100),2)
            Else minval
       End mininum
     , Case metric_name
            When 'SQL Service Response Time' then round((maxval / 100),2)
            When 'Response Time Per Txn' then round((maxval / 100),2)
            Else maxval
       End maximum
     , Case metric_name
            When 'SQL Service Response Time' then round((average / 100),2)
            When 'Response Time Per Txn' then round((average / 100),2)
            Else average
       End average
  from sys.v_$sysmetric_summary 
 where metric_name in ( 'CPU Usage Per Sec'
                      , 'CPU Usage Per Txn'
                      , 'Database CPU Time Ratio'
                      , 'Database Wait Time Ratio'
                      , 'Executions Per Sec'
                      , 'Executions Per Txn'
                      , 'Response Time Per Txn'
                      , 'SQL Service Response Time'
                      , 'User Transaction Per Sec'
                      )
Order by 1
;

The query above contains more response-time metrics than simply the Database CPU and Wait Time Ratios (we'll cover those later), but you can see the benefit in being able to acquire this information. For this particular instance, the average Database CPU Time Ratio is 94, which is well within our acceptable limits.
The next question DBAs pose at the system level involves the average level of response time that their user community is experiencing. (Prior to Oracle Database 10g this type of data was difficult to capture, but not anymore.) The query shown above that interrogates the V$SYSMETRIC_SUMMARY view tells us what we need to know. If complaints of unacceptable response times are mounting from users, the DBA can check the Response Time Per Txn and SQL Service Response Time metrics to see if a database issue exists. For example, the statistics shown above report that the maximum response time per user transaction has been only .28 second, with the average response time being a blazing .08 second. Oracle certainly wouldn't be to blame in this case.
If, however, response times are longer than desired, the DBA will then want to know what types of user activities are responsible for making the database work so hard. Again, before Oracle Database 10g, this information was more difficult to acquire, but now the answer is only a query away:
select case db_stat_name
           when 'parse time elapsed' then 
               'soft parse time'
           else db_stat_name
       end db_stat_name
     , case db_stat_name
           when 'sql execute elapsed time' then 
                time_secs - plsql_time 
           when 'parse time elapsed' then 
                time_secs - hard_parse_time
           else time_secs
       end time_secs
     , case db_stat_name
           when 'sql execute elapsed time' then 
                round(100 * (time_secs - plsql_time) / db_time,2)
           when 'parse time elapsed' then 
                round(100 * (time_secs - hard_parse_time) / db_time,2)  
           else round(100 * time_secs / db_time,2)  
       end pct_time
  from (select stat_name db_stat_name
             , round((value / 1000000),3) time_secs
          from sys.v_$sys_time_model
         where stat_name not in ( 'DB time','background elapsed time'
                                , 'background cpu time','DB CPU')
       )
     , (select round((value / 1000000),3) db_time 
         from sys.v_$sys_time_model 
        where stat_name = 'DB time'
       )
     , (select round((value / 1000000),3) plsql_time 
         from sys.v_$sys_time_model 
        where stat_name = 'PL/SQL execution elapsed time'
       )
     , (select round((value / 1000000),3) hard_parse_time 
         from sys.v_$sys_time_model 
        where stat_name = 'hard parse elapsed time'
       )
 order by 2 desc
;

In addition to active time, a DBA will want to know the global wait times as well. Prior to Oracle Database 10g, a DBA had to view individual wait events to understand waits and bottlenecks, but now Oracle provides a summary/rollup mechanism for waits via wait classes:
select wait_class
     , total_waits
     , round(100 * (total_waits / sum_waits),2) pct_waits
     , round((time_waited / 100),2) time_waited_secs
     , round(100 * (time_waited / sum_time),2) pct_time
  from (select wait_class
             , total_waits
             , time_waited
          from v$system_wait_class
         where wait_class != 'Idle'
       )
     , (select sum(total_waits) sum_waits
             , sum(time_waited) sum_time
          from v$system_wait_class
         where wait_class != 'Idle'
       )
order by 5 desc
;

It''s much easier to tell now that the bulk of overall wait time is due, for example, to user I/O waits than to try to tally individual wait events to get a global picture. 
As with response-time metrics, you can also look back in time over the last hour with a query like this one:
select to_char(a.end_time,'DD-MON-YYYY HH:MI:SS') end_time
     , b.wait_class
     , round((a.time_waited / 100),2) time_waited 
  from sys.v_$waitclassmetric_history a
     , sys.v_$system_wait_class b
 where a.wait_class# = b.wait_class# 
   and b.wait_class != 'Idle'
order by 1,2
;
You can, of course, just focus on a single SID with the V$SESS_TIME_MODEL view and obtain data for all statistical areas of a session. You can also view current session wait activity using the new wait classes using the following query:
select a.sid
     , b.username
     , a.wait_class
     , a.total_waits
     , round((a.time_waited / 100),2) time_waited_secs
  from sys.v_$session_wait_class a
     , sys.v_$session b
 where b.sid = a.sid 
   and b.username is not null 
   and a.wait_class != 'Idle'
 order by 5 desc
;

After this stage, you can check the standard individual wait events as you''ve been able to do in earlier versions of Oracle with V$SESSION_WAIT and V$SESSION_EVENT. You''ll also find the new wait classes in these two modified views with Oracle Database 10g.
If you need to look back in time to discover what sessions were logged on and consuming the most resources, you can use the following query. In the example below, we''re looking at activity from midnight to 5 a.m. on November 21, 2004, that involved user I/O waits:
select sess_id
     , username
     , program
     , wait_event
     , sess_time
     , round(100 * (sess_time / total_time),2) pct_time_waited
  from (select a.session_id sess_id
             , decode(session_type, 'background', session_type, c.username) username
             , a.program program
             , b.name wait_event
             , sum(a.time_waited) sess_time
          from sys.v_$active_session_history a
             , sys.v_$event_name b
             , sys.dba_users c
         where a.event# = b.event# 
           and a.user_id = c.user_id 
           and sample_time between to_date ('201710201200' , 'yyyymmddhh24mi')  
                               and to_date ('201710201200' , 'yyyymmddhh24mi') 
           and b.wait_class = 'User I/O'
         group by a.session_id
             , decode(session_type, 'background', session_type, c.username)
             , a.program
             , b.name
        ),
       (select sum(a.time_waited) total_time
          from sys.v_$active_session_history a
             , sys.v_$event_name b
         where a.event# = b.event# 
           and sample_time between to_date ('201710201200' , 'yyyymmddhh24mi')  
                               and to_date ('201710201200' , 'yyyymmddhh24mi')  
           and b.wait_class = 'User I/O'
        )
 order by 6 desc
;

The Oracle Database 10g V$ACTIVE_SESSION_HISTORY view comes into play here to provide an insightful look back in time at session experiences for a given time period. This view gives you a lot of excellent information without the need for laborious tracing functions. We''ll see more use of it in the next section, which deals with analyzing the response times of SQL statements.
SQL Response-Time Analysis
Examining the response time of SQL statements became easier in Oracle9i, and with Oracle Database 10g, DBAs have many tools at their disposal to help them track inefficient database code.
Historically the applicable V$ view here has been V$SQLAREA. Starting with Oracle9i, Oracle added the ELAPSED_TIME and CPU_TIME columns, which have been a huge help in determining the actual end user experience of a SQL statement execution (at least, when dividing them by the EXECUTIONS column, which produces the average amount of time per execution).
In Oracle Database 10g, six new wait-related and timing columns have been added to V$SQLAREA:
•	APPLICATION_WAIT_TIME
•	CONCURRENCY_WAIT_TIME
•	CLUSTER_WAIT_TIME
•	USER_IO_WAIT_TIME
•	PLSQL_EXEC_TIME
•	JAVA_EXEC_TIME
The new columns are helpful in determining, for example, the amount of time that a procedure spends in PL/SQL code vs. standard SQL execution, and if a SQL statement has experienced any particular user I/O waits. For example, a query you could use to find the top five SQL statements with the highest user I/O waits would be:
select *
  from (select sql_text
             , sql_id
             , elapsed_time
             , cpu_time
             , user_io_wait_time
          from sys.v_$sqlarea
         order by 5 desc
       )
 where rownum < 6;

Of course, getting the SQL statements with the highest elapsed time or wait time is good, but you need more detail to get to the heart of the matterwhich is where the V$ACTIVE_SESSION_HISTORY view again comes into play. With this view, you can find out what actual wait events delayed the SQL statement along with the actual files, objects, and object blocks that caused the waits (where applicable).
For example, let's say you've found a particular SQL statement that appears to be extremely deficient in terms of user I/O wait time. You can issue the following query to get the individual wait events associated with the query along with the corresponding wait times, files, and objects that were the source of those waits:
select event,
       time_waited,
       owner,
       object_name,
       current_file#,
       current_block# 
  from sys.v_$active_session_history a,
       sys.dba_objects b 
 where sql_id = '6gvch1xu9ca3g' and
       a.current_obj# = b.object_id and
       time_waited <> 0
;


-- -----------------
1. Get an accurate description of the problem
2. Check the OS for exhausted resources
3. Gather database statistics
4. Check for the top ten most common pitfalls
5. Analyze the data gathered, focus on wait events, theorize the cause of the problem
6. Propose a series of remedial actions, then implement them
7. Measure the effect of the changes
8. Repeat any steps, as required, until performance goals are met
