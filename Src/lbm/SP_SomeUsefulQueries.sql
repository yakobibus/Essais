/*
-- Some Useful Queries
**/


select NAME
     , LOG_MODE
     , CONTROLFILE_TYPE
     , CONTROLFILE_CREATED
     , CONTROLFILE_TIME
     , OPEN_RESETLOGS
     , VERSION_TIME
     , OPEN_MODE
     , PROTECTION_MODE
     , PROTECTION_LEVEL
     , REMOTE_ARCHIVE
     , DATABASE_ROLE
     , ARCHIVELOG_COMPRESSION
     , SWITCHOVER_STATUS
     , DATAGUARD_BROKER
     , GUARD_STATUS
     , FORCE_LOGGING
     , PLATFORM_ID
     , PLATFORM_NAME
     , FLASHBACK_ON
     , SUPPLEMENTAL_LOG_DATA_FK
     , SUPPLEMENTAL_LOG_DATA_ALL
     , DB_UNIQUE_NAME
  FROM v$database
;
---

select vi.INSTANCE_NUMBER
     , vi.INSTANCE_NAME
     , vi.HOST_NAME
     , vi.VERSION
     , vi.STARTUP_TIME
     , vi.STATUS
     , vi.PARALLEL
     , vi.THREAD#
     , vi.ARCHIVER
     , vi.LOG_SWITCH_WAIT
     , vi.LOGINS
     , vi.SHUTDOWN_PENDING
     , vi.DATABASE_STATUS
     , vi.INSTANCE_ROLE
     , vi.ACTIVE_STATE
     , vi.BLOCKED
  from v$instance vi
;


--Nom et taille des objets dans le Tablespace SYSAUX.
  -- Voir les objets du Tablespace SYSAUX.
  -- On interroge la vue V$SYSAUX_OCCUPANTS pour lister les objets contenu dans le Tablespace SYSAUX.
 SET LINESIZE 130
 COL occupant_desc FORMAT A52
 COL occupant_name FORMAT A21
 COL schema_name FORMAT A10
 
 SELECT occupant_desc, occupant_name, schema_name, space_usage_kbytes
   FROM v$sysaux_occupants 
  ORDER BY space_usage_kbytes DESC
 ;

 COL segment_name FORMAT A35
 SELECT ds.segment_name, ds.tablespace_name
   FROM dba_segments ds
        inner join  dba_tablespaces dt on dt.tablespace_name = ds.tablespace_name and dt.tablespace_name like 'STORELAND%'
  --WHERE ds.tablespace_name in (select tablespace_name from dba_tablespaces )
 ;
 set lines 660
 SELECT ds.segment_name, ds.tablespace_name, ds.PARTITION_NAME, ds.HEADER_BLOCK, ds.BYTES, ds.EXTENTS, ds.INITIAL_EXTENT, ds.NEXT_EXTENT
   FROM dba_segments ds
        inner join  dba_tablespaces dt on dt.tablespace_name = ds.tablespace_name and dt.tablespace_name like 'STORELAND%'
  --WHERE ds.tablespace_name in (select tablespace_name from dba_tablespaces )
 ;

--Comment voir, lister le contenu du Tablespace SYSAUX.

-- Vérifier l'architecture de stockage en mémoire pour le cas de migration => de toute façon, formater par coversion RMAN
SET ORACLE_SID=storPROD 
sqlplus /nolog 
 connect / as sysdba
 COL platform_name FORMAT A40
 COL endian_format FORMAT A20
 SELECT platform_name, endian_format
   FROM V$TRANSPORTABLE_PLATFORM 
  ORDER BY 2
 ;

 SELECT platform_name
   FROM v$database
 ;
 
 select *  from v$instance vi ;

-- Lister les objets d un tablespace 	
  REPHEADER PAGE CENTER 'LISTE DES OBJETS DANS TABLESPACE'
  SET LINESIZE 660 
  SET PAGESIZE 900 
  COL "TABLESPACE" FORMAT A22 
  COL "SCHEMA" FORMAT A15 
  COL "NOM OBJET" FORMAT A30 
  COL "TYPE OBJET" FORMAT A30 
  COL "TAILLE (Mb)" FORMAT 999,999.99 
  COL "FICHIER DE DONNEES" FORMAT A70 
  SELECT e.tablespace_name AS "TABLESPACE", e.owner AS "SCHEMA", e.segment_name AS "NOM OBJET", e.segment_type AS "TYPE OBJET", ROUND(Sum(e.bytes)/1024/1024,2) AS "TAILLE (Mb)", d.file_name AS "FICHIER DE DONNEES" 
  FROM dba_extents e INNER JOIN dba_data_files d ON ( e.file_id = d.file_id ) 
  WHERE e.tablespace_name  like 'STORELAND%' 
  GROUP BY e.tablespace_name, e.owner, e.segment_name, e.segment_type, d.file_name 
  ORDER BY 2,"TAILLE (Mb)" DESC
  ; 
  REPHEADER OFF


-- Script User Unlimited Tablespace / Quota
 

-- Script User Unlimited Tablespace Privilège et Quota.
-- Comment voir et lister les Quota et Unlimited Tablespace Privilège ?

-- Lister les Quotas par User.
-- Permet de faire un inventaire des utilisateurs qui ont des quotas , des Unlimited Tablespace ainsi que le Privilège Unlimited Tablespace.
-- A savoir que si un USER a le Privilège Unlimited Tablespace, alors tous ses Quotas et Unlimited Tablespace spécifiques à un Tablespace sont Obsolètes.
-- Par contre si le Privilège est révoqué alors les Quotas et Unlimited Tablespace spécifiques deviennent Actifs.

 	
 REPHEADER PAGE CENTER 'USER INFORMATION QUOTA et UNLIMITED TABLESPACE PRIVILEGE' 
 SET LINESIZE 100 
 SET PAGESIZE 900 
 COL USERNAME FORMAT A30 
 COL TABLESPACE_NAME FORMAT A36 
 COL "INFO QUOTA" FORMAT A77 
 SELECT USERNAME
      , TABLESPACE_NAME
      , DECODE (SIGN (MAX_BYTES), -1, 'Unlimited Tbs sur '||TABLESPACE_NAME, 'Quota de ' ||(ROUND((MAX_BYTES/1024/1024),2))||' Mo') "INFO QUOTA"
      , ROUND ((BYTES/1024/1024), 2) "IN USE EN Mo"
   FROM DBA_TS_QUOTAS 
  WHERE USERNAME NOT IN (SELECT grantee FROM DBA_SYS_PRIVS WHERE privilege = 'UNLIMITED TABLESPACE') 
 UNION 
 SELECT USERNAME
      , TABLESPACE_NAME
      , DECODE (SIGN (MAX_BYTES), -1, 'Unlimited Tbs sur '||TABLESPACE_NAME|| ' Obsolete car Unlimited Tbs Priv', 'Quota de ' || (ROUND((MAX_BYTES/1024/1024),2))||' Mo Obsolete car UNLIMITED TBS PRIV') "INFO QUOTA"
      , ROUND((BYTES/1024/1024),2) "IN USE EN Mo"
   FROM DBA_TS_QUOTAS 
  WHERE USERNAME IN (SELECT grantee FROM DBA_SYS_PRIVS WHERE privilege = 'UNLIMITED TABLESPACE') 
 UNION 
 SELECT grantee, '*', 'Unlimited Tbs Privilege', NULL
   FROM DBA_SYS_PRIVS
  WHERE privilege = 'UNLIMITED TABLESPACE' 
  ORDER BY 4 
 ; 
 REPHEADER OFF


-- Connaitre les statuts des Tablespaces. 	
 SELECT tablespace_name, status, contents, extent_management 
   FROM dba_tablespaces
 ; 
 
-- NB Voir le fichier d’initialisation de la base (initSID.ora)

-- voir les valeurs UNDO avec cette requête

 SELECT name, value, description
   FROM V$PARAMETER
  WHERE upper(name) LIKE upper('%undo%')
 ;


-- -------------------------------------------------------------------------------
-- Take a performance snapshot
   -- execute statspack.snap;

-- Get a list of snapshots
column snap_time format a21

select snap_id,to_char(snap_time,'MON dd, yyyy hh24:mm:ss') snap_time
from STATS$SNAPSHOT
;


-- Running a Performance report
   @ E:\oracle\product\10.2.0\db_1\RDBMS\ADMIN\spreport.sql


-- Locate Hard hitting SQL from Statpack Reposistory
   -- 1. Login as PERFSTAT user on database
   -- 2. Find DBID using
      select distinct dbid 
        from stats$sql_summary
      ;
      
   -- 3. Locate MIN(SNAP_ID) pBgnSnap & MAX(SNAP_ID) pEndSnap from
      select min(snap_id),max(snap_id),min(snap_time),max(snap_time) 
        from stats$snapshot
       where to_number(to_char(snap_time,'HH24')) > 9 
         and to_number(to_char(snap_time,'HH24')) < 21
      ;


/*
-- Show All SQL Stmts ordered by Logical Reads
select e.hash_value "E.HASH_VALUE"
     , e.module "Module"
     , e.buffer_gets - nvl(b.buffer_gets,0) "Buffer Gets"
     , e.executions - nvl(b.executions,0) "Executions"
     , Round( decode ((e.executions - nvl(b.executions, 0)), 0, to_number(NULL)
     , (e.buffer_gets - nvl(b.buffer_gets,0)) / (e.executions - nvl(b.executions,0))) ,3) "Gets / Execution"
     , Round(100*(e.buffer_gets - nvl(b.buffer_gets,0))/sp920.getGets(1664694911, 1, 1, 1181,'NO'),3) "Percent of Total"
     --, Round(100*(e.buffer_gets - nvl(b.buffer_gets,0))/sp920.getGets(:pDbID,:pInstNum,:pBgnSnap,:pEndSnap,'NO'),3) "Percent of Total"
     , Round((e.cpu_time - nvl(b.cpu_time,0))/1000000,3) "CPU (s)"
     , Round((e.elapsed_time - nvl(b.elapsed_time,0))/1000000,3) "Elapsed (s)"
     , Round(e.fetches - nvl(b.fetches,0)) "Fetches"
     , sp920.getSQLText ( e.hash_value , 400) "SQL Statement"
  from stats$sql_summary e, stats$sql_summary b
  where b.snap_id(+) =  1 --:pBgnSnap
    and b.dbid(+) = e.dbid
    and b.instance_number(+) = e.instance_number
    and b.hash_value(+) = e.hash_value
    and b.address(+) = e.address
    and b.text_subset(+) = e.text_subset
    and e.snap_id = 1181 -- :pEndSnap
    and e.dbid =  1664694911 -- :pDbId
    and e.instance_number = 1 -- :pInstNum
  order by 3 desc
;
*/


/*
-- Show SQL Stmts where SQL_TEXT like '%'
select e.hash_value "E.HASH_VALUE"
     , e.module "Module"
     , e.buffer_gets - nvl(b.buffer_gets,0) "Buffer Gets"
     , e.executions - nvl(b.executions,0) "Executions"
     , Round( decode ((e.executions - nvl(b.executions, 0)), 0, to_number(NULL)
     , (e.buffer_gets - nvl(b.buffer_gets,0)) / (e.executions - nvl(b.executions,0))) ,3) "Gets / Execution"
     , Round(100*(e.buffer_gets - nvl(b.buffer_gets,0))/sp920.getGets(:pDbID,:pInstNum,:pBgnSnap,:pEndSnap,'NO'),3) "Percent of Total"
     , Round((e.cpu_time - nvl(b.cpu_time,0))/1000000,3) "CPU (s)"
     , Round((e.elapsed_time - nvl(b.elapsed_time,0))/1000000,3) "Elapsed (s)"
     , Round(e.fetches - nvl(b.fetches,0)) "Fetches"
     , sp920.getSQLText ( e.hash_value , 400) "SQL Statement"
  from stats$sql_summary e, stats$sql_summary b
  where b.snap_id(+) = :pBgnSnap
    and b.dbid(+) = e.dbid
    and b.instance_number(+) = e.instance_number
    and b.hash_value(+) = e.hash_value
    and b.address(+) = e.address
    and b.text_subset(+) = e.text_subset
    and e.snap_id = :pEndSnap
    and e.dbid = 2863128100
    and e.instance_number = :pInstNum
    and sp920.getSQLText ( e.hash_value , 400) like '%ZPV_DATA%'
  order by 3 desc
;
*/

-- Creating Excel Reports from Statspack

-- 1. Run the query in SQL*Plus against the STATSPACK data.
     -- For example the following to Report IO
-- rpt_io.sql
set pages 9999;
column reads format 999,999,999,999
column writes format 999,999,999,999

select to_char(snap_time,'yyyy-mm-dd') snap_date, avg(newreads.value-oldreads.value) reads, avg(newwrites.value-oldwrites.value) writes
  from stats$sysstat oldreads, stats$sysstat newreads, stats$sysstat oldwrites, stats$sysstat newwrites, stats$snapshot sn
  where newreads.snap_id = sn.snap_id
    and newwrites.snap_id = sn.snap_id
    and oldreads.snap_id = sn.snap_id-1
    and oldwrites.snap_id = sn.snap_id-1
    and oldreads.statistic# = 40
    and newreads.statistic# = 40
    and oldwrites.statistic# = 41
    and newwrites.statistic# = 41
    and (newreads.value-oldreads.value) > 0
    and (newwrites.value-oldwrites.value) > 0
  group by to_char(snap_time,'yyyy-mm-dd')
;
---

-- 2. Cut and paste the result into the spreadsheet. Note that all of the data still resides in a single column.
-- 3. Highlight your data, choose Data and then "Text To Columns". This will separate the columns into distinct cells.. 
--    We are now guided through a wizard to column delimit the values. Next, we choose “Fixed width” in the Text to Columns Wizard. 
--    We then accept the defaults for each wizard step and the data will be placed into separate columns.
-- 4. Remove Line 2 (the one with the dashes ----- )
-- 4. Highlight all the columns and Click on Insert, and then choose a Line chart. Then Accept the defaults
-- 5. Choose Chart | Add Trendline to create a forecast line.

/*
-- Other Reports that can help:
**/

-- 
-- rpt_vmstat.sql  (Check CPU % Used per Day)


/*
set pages 9999;
set feedback off;
set verify off;
column my_date heading 'date' format a20
column c2 heading runq format 999
column c3 heading pg_in format 999
column c4 heading pg_ot format 999
column c5 heading usr format 999
column c6 heading sys format 999
column c7 heading idl format 999
column c8 heading wt format 999

select to_char(start_date,'yyyy-mm-dd') my_date
     , avg(user_cpu + system_cpu) c5
     , avg(wait_cpu) c8
-- , avg(runque_waits) c2
-- , avg(page_in) c3
-- , avg(page_out) c4
-- , avg(system_cpu) c6
-- , avg(idle_cpu) c7
  from stats$vmstat
--  where server_name = 'MARCELLO'
 group BY to_char(start_date,'yyyy-mm-dd')
 order by to_char(start_date,'yyyy-mm-dd')
;
*/


--rpt_vmstat_hr.sql (Check CPU % Used per Hour)
 connect perfstat/perf0Stat;
/*
set pages 9999;
set feedback off;
set verify off;
column my_date heading 'date' format a20
column c2 heading runq format 999
column c3 heading pg_in format 999
column c4 heading pg_ot format 999
column c5 heading usr format 999
column c6 heading sys format 999
column c7 heading idl format 999
column c8 heading wt format 999

select to_char(start_date,'HH24') my_date
     , avg(user_cpu + system_cpu) c5
-- , avg(runque_waits) c2
-- , avg(page_in) c3
-- , avg(page_out) c4
-- , avg(system_cpu) c6
-- , avg(idle_cpu) c7
-- , avg(wait_cpu) c8
  from stats$vmstat
 group BY to_char(start_date,'HH24')
 order by to_char(start_date,'HH24')
;
*/
-----

Il faudrait qu’en préambule tu décrives l’environnement OS et Rdbms en donnant le versioning.
Il faut également que tu donnes le délai de rétention des rapports statpack.
Il faudra aussi que 
-  Le client te fournisse le plan de production afin que tu puisses faire le lien entre les activités constatées dans les statpacks et l’activité de production. Cela te permettra d’identifier des traitements gourmands.
-  Tu fasses un tour d’horizon du paramétrage des bases de données et de la configuration network
--------
Jobs sur le schéma STORELAND : 
LBM_JOB_ALERTE_OSCC
OWNER	STORELAND
JOB_NAME	LBM_JOB_ALERTE_OSCC
JOB_CLASS	DEFAULT_JOB_CLASS
COMMENTS	
ENABLED	TRUE
PROGRAM_NAME	
JOB_TYPE	STORED_PROCEDURE
JOB_ACTION	STORELAND.LBM_TMP_SEND_ALERTE_OSCC
NUMBER_OF_ARGUMENTS	0
SCHEDULE_NAME	
SCHEDULE_TYPE	CALENDAR
START_DATE	08/09/15 08:00:00,000000000 +02:00
REPEAT_INTERVAL	FREQ=DAILY;INTERVAL=1
END_DATE	
EVENT_QUEUE_NAME	
EVENT_CONDITION	

Propriété du job :
AUTO_DROP	FALSE
INSTANCE_STICKINESS	TRUE
JOB_PRIORITY	3
JOB_WEIGHT	1
LOGGING_LEVEL	RUNS
MAX_FAILURES	
MAX_RUN_DURATION	
MAX_RUNS	
RAISE_EVENTS	
RESTARTABLE	FALSE
RUN_COUNT	760
SCHEDULE_LIMIT	
STATE	SCHEDULED
STOP_ON_WINDOW_CLOSE	FALSE

--

SQL> select owner , job_name , job_type , job_action , start_date , repeat_interval , state , run_count  from dba_scheduler_jobs where owner = 'STORELAND' ;

OWNER                          JOB_NAME                       JOB_TYPE
------------------------------ ------------------------------ ----------------
JOB_ACTION
----------------------------------------------------------------------------------------------------
START_DATE
---------------------------------------------------------------------------
REPEAT_INTERVAL
----------------------------------------------------------------------------------------------------
STATE            RUN_COUNT
--------------- ----------
STORELAND                      LBM_JOB_ALERTE_OSCC            STORED_PROCEDURE
STORELAND.LBM_TMP_SEND_ALERTE_OSCC
08-SEP-15 08.00.00.000000 AM +02:00
FREQ=DAILY;INTERVAL=1
SCHEDULED              760

SQL> set lines 960
SQL> /

OWNER                          JOB_NAME                       JOB_TYPE
------------------------------ ------------------------------ ----------------
JOB_ACTION
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
START_DATE
---------------------------------------------------------------------------
REPEAT_INTERVAL
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
STATE            RUN_COUNT
--------------- ----------
STORELAND                      LBM_JOB_ALERTE_OSCC            STORED_PROCEDURE
STORELAND.LBM_TMP_SEND_ALERTE_OSCC
08-SEP-15 08.00.00.000000 AM +02:00
FREQ=DAILY;INTERVAL=1
SCHEDULED              760


create or replace PROCEDURE           lbm_tmp_send_alerte_OSCC
IS


    V_CAS_TROUVE INTEGER :=0;

BEGIN 

    select count(*) INTO V_CAS_TROUVE from (
                                            select CodeOscc, Codeclient, DateOscc, NumTicketUtil, DateModification, Montant, MntUtilise
                                            from histo_oscc
                                            where typestatusoscc = '1' 
                                            and typeoscc = '4'
                                            and MntUtilise < Montant
                                          );
                        
    IF V_CAS_TROUVE >= 1 THEN
    
        LBM_SEND_MAIL ('tma.lbm@cylande.com','tma.lbm@cylande.com','TMA LBM : MANTIS 5534','OSCC desactivee a tort');
                                        
    END if;
    
END; 

create or replace PROCEDURE           lbm_send_mail (
   v_from        VARCHAR2,-- nom de l'expediteur du mail
   v_msg_to        VARCHAR2,-- Adresse mail du destinaire du mail
   v_msg_subject   VARCHAR2,-- Objet du mail
   v_msg_text      VARCHAR2-- Sorp du mail
)
IS

/***********************************************************************
Envoi de mail

ERI 14/01/2013 Creation de la procédure stockee 

************************************************************************/
   v_mail_conn   UTL_SMTP.connection;
   v_mail_host   VARCHAR2 (30)       := 'mail.lebonmarche.fr'; -- nom serveur SMTP
   crlf        VARCHAR2(2)  := chr(13)||chr(10);
   
BEGIN
   v_mail_conn := UTL_SMTP.open_connection (v_mail_host, 25);
   UTL_SMTP.helo (v_mail_conn, v_mail_host);
   UTL_SMTP.mail (v_mail_conn, v_from);
   UTL_SMTP.rcpt (v_mail_conn, v_msg_to);
   UTL_SMTP.DATA (v_mail_conn,
                     'Date: '
                  || TO_CHAR (SYSDATE, 'Dy, DD Mon YYYY hh24:mi:ss')
                  || crlf
                  || 'From: '
                  || v_from
                  || crlf
                  || 'Subject: '
                  || v_msg_subject
                  || crlf
                  || 'To: '
                  || v_msg_to
                  || crlf
                  || crlf
                  || v_msg_text
                  || crlf                                      -- Message body
                 );
   UTL_SMTP.quit (v_mail_conn);
EXCEPTION
   WHEN UTL_SMTP.transient_error OR UTL_SMTP.permanent_error
   THEN
      raise_application_error (-20000, 'Unable to send mail: ' || SQLERRM);
END; 
 
 
-----

Existance de procédure et packages compilés en debug_mode en production

SQL> select count (1), debuginfo from sys.ALL_PROBE_OBJECTS group by debuginfo ;

  COUNT(1) D
---------- -
       129 T
     52257 F

SQL> col PLSQL_DEBUG format a22
SQL> select count (1) , PLSQL_DEBUG  from ALL_PLSQL_OBJECT_SETTINGS group by PLSQL_DEBUG ;

  COUNT(1) PLSQL_DEBUG
---------- ----------------------
        67
       129 TRUE
      4776 FALSE


col OWNER format A30
col NAME  format A30
col TYPE format A30
col PLSQL_DEBUG format a22
col PLSQL_CODE_TYPE format A30
col TYPE  format 999
col PLSQL_WARNINGS format a33
col NLS_LENGTH_SEMANTICS format a55
col PLSQL_CCFLAGS format a55

select * from ALL_PLSQL_OBJECT_SETTINGS where PLSQL_DEBUG = 'TRUE' ;
	  

USER_PLSQL_OBJECT_SETTINGS -- PLSQL_DEBUG 

DBA_PLSQL_OBJECT_SETTINGS


select * FROM   SYS.ALL_PROBE_OBJECTS WHERE DEBUGINFO = 'T'
;

--

Liste des objets invalides sur la base storePRod :
select count (1) , owner, object_type from all_objects where status != 'VALID' group by owner, object_type ;
select * from all_objects where status != 'VALID' ;

----
Tx de remplissage des tablespaces :

SQL> select    a.TABLESPACE_NAME TABLESPACE,
  2      a.BYTES/1024/1024 MO_UTILISES,
  3      b.BYTES/1024/1024 MO_LIBRES,
  4      b.largest/1024/1024 PLUS_LARGE,
  5      round(((a.BYTES-b.BYTES)/a.BYTES)*100,2) POURCENTAGE_UTILISES
  6  from
  7      (
  8          select    TABLESPACE_NAME,
  9              sum(BYTES) BYTES
 10          from    dba_data_files
 11          group    by TABLESPACE_NAME
 12      )
 13      a,
 14      (
 15          select    TABLESPACE_NAME,
 16              sum(BYTES) BYTES ,
 17              max(BYTES) largest
 18          from    dba_free_space
 19          group    by TABLESPACE_NAME
 20      )
 21      b
 22  where     a.TABLESPACE_NAME=b.TABLESPACE_NAME
 23  order     by ((a.BYTES-b.BYTES)/a.BYTES) desc
 24  ;

TABLESPACE             MO_UTILISES  MO_LIBRES PLUS_LARGE POURCENTAGE_UTILISES
---------------------- ----------- ---------- ---------- --------------------
STORELAND_DATA               62304 14644.8125  1223.9375                76.49
STORELAND_IDX                35960 13822.3125       2594                61.56
SYSTEM                        1024        475   473.9375                53.61
SYSAUX                        1024    492.375   487.9375                51.92
USERS                            5     4.9375     4.9375                 1.25
UNDOTBS1                32877.9844 32660.3125       3968                  .66
SQL>


-- Autre point de vue (dba_extents)
SQL>
SQL> SELECT  OWNER                       AS "SCHEMA",
  2          TABLESPACE_NAME             AS "TABLESPACE",
  3          SEGMENT_TYPE                AS "TYPE OBJET",
  4          Sum(BYTES) / 1024 / 1024    AS "TAILLE (Mb)"
  5  FROM    DBA_EXTENTS
  6  GROUP BY OWNER, TABLESPACE_NAME, SEGMENT_TYPE
  7  ORDER BY OWNER, TABLESPACE_NAME;

SCHEMA          TABLESPACE             TYPE OBJET                     TAILLE (Mb)
--------------- ---------------------- ------------------------------ -----------
DBSNMP          SYSAUX                 INDEX                                  .63
DBSNMP          SYSAUX                 TABLE                                 1.13
EXFSYS          SYSAUX                 INDEX                                 2.25
EXFSYS          SYSAUX                 LOBINDEX                               .13
EXFSYS          SYSAUX                 LOBSEGMENT                             .13
EXFSYS          SYSAUX                 TABLE                                 1.13
MDSYS           SYSAUX                 INDEX                                 3.31
MDSYS           SYSAUX                 LOBINDEX                              1.00
MDSYS           SYSAUX                 LOBSEGMENT                            9.94
MDSYS           SYSAUX                 TABLE                                 7.56
OLAPSYS         SYSAUX                 INDEX                                 8.44
OLAPSYS         SYSAUX                 TABLE                                 7.13
ORDSYS          SYSAUX                 INDEX                                  .25
ORDSYS          SYSAUX                 TABLE                                  .25
OUTLN           SYSTEM                 INDEX                                  .25
OUTLN           SYSTEM                 LOBINDEX                               .06
OUTLN           SYSTEM                 LOBSEGMENT                             .06
OUTLN           SYSTEM                 TABLE                                  .19
PERFSTAT        PERFTBS                INDEX                                96.00
PERFSTAT        PERFTBS                TABLE                               104.00
STORELAND       STORELAND_DATA         CLUSTER                           1,704.00
STORELAND       STORELAND_DATA         INDEX                             9,709.69
STORELAND       STORELAND_DATA         LOBINDEX                               .06
STORELAND       STORELAND_DATA         LOBSEGMENT                            4.00
STORELAND       STORELAND_DATA         TABLE                            36,104.69
STORELAND       STORELAND_IDX          INDEX                            22,137.31
SYS             SYSAUX                 INDEX                               124.88
SYS             SYSAUX                 INDEX PARTITION                      33.50
SYS             SYSAUX                 LOB PARTITION                          .06
SYS             SYSAUX                 LOBINDEX                              2.50
SYS             SYSAUX                 LOBSEGMENT                           44.00
SYS             SYSAUX                 NESTED TABLE                           .06
SYS             SYSAUX                 TABLE                               110.94
SYS             SYSAUX                 TABLE PARTITION                      60.00
SYS             SYSTEM                 CLUSTER                              45.31
SYS             SYSTEM                 INDEX                               149.19
SYS             SYSTEM                 LOBINDEX                              4.31
SYS             SYSTEM                 LOBSEGMENT                            8.00
SYS             SYSTEM                 NESTED TABLE                           .38
SYS             SYSTEM                 ROLLBACK                               .38
SYS             SYSTEM                 TABLE                               325.00
SYS             UNDOTBS1               TYPE2 UNDO                          226.50
SYSMAN          SYSAUX                 INDEX                                26.00
SYSMAN          SYSAUX                 LOBINDEX                              1.75
SYSMAN          SYSAUX                 LOBSEGMENT                            1.75
SYSMAN          SYSAUX                 NESTED TABLE                           .13
SYSMAN          SYSAUX                 TABLE                                20.50
SYSTEM          SYSAUX                 INDEX                                  .88
SYSTEM          SYSAUX                 INDEX PARTITION                       2.06
SYSTEM          SYSAUX                 LOBINDEX                               .44
SYSTEM          SYSAUX                 LOBSEGMENT                             .44
SYSTEM          SYSAUX                 TABLE                                 1.38
SYSTEM          SYSAUX                 TABLE PARTITION                       1.69
SYSTEM          SYSTEM                 INDEX                                 8.06
SYSTEM          SYSTEM                 LOBINDEX                              1.06
SYSTEM          SYSTEM                 LOBSEGMENT                            1.06
SYSTEM          SYSTEM                 TABLE                                 5.63
TRIG            STORELAND_DATA         INDEX                                40.00
TRIG            STORELAND_DATA         TABLE                                96.00
TSMSYS          SYSAUX                 INDEX                                  .06
TSMSYS          SYSAUX                 LOBINDEX                               .06
TSMSYS          SYSAUX                 LOBSEGMENT                             .06
TSMSYS          SYSAUX                 TABLE                                  .06
WMSYS           SYSAUX                 INDEX                                 3.69
WMSYS           SYSAUX                 LOBINDEX                               .50
WMSYS           SYSAUX                 LOBSEGMENT                             .50
WMSYS           SYSAUX                 NESTED TABLE                           .13
WMSYS           SYSAUX                 TABLE                                 2.31
XDB             SYSAUX                 INDEX                                 3.13
XDB             SYSAUX                 LOBINDEX                             20.88
XDB             SYSAUX                 LOBSEGMENT                           20.88
XDB             SYSAUX                 TABLE                                 3.13
SQL> 

---

Taille de la base 
SQL> l
  1  SELECT TABLESPACE_NAME
  2          ,STATUS
  3          ,FILE_NAME
  4      FROM DBA_DATA_FILES
  5* ORDER BY FILE_ID
SQL> /

TABLESPACE_NAME                      STATUS    FILE_NAME
------------------------------------ --------- ----------------------------------------------------------------------
SYSTEM                               AVAILABLE E:\ORACLE\ORADATA\STOR\SYSTEM01.DBF
UNDOTBS1                             AVAILABLE E:\ORACLE\ORADATA\STOR\UNDOTBS01.DBF
SYSAUX                               AVAILABLE E:\ORACLE\ORADATA\STOR\SYSAUX01.DBF
USERS                                AVAILABLE E:\ORACLE\ORADATA\STOR\USERS01.DBF
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA01.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA02.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA03.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA04.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA05.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX01.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX02.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX03.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX04.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX05.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA06.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA07.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA08.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA09.ORA
UNDOTBS1                             AVAILABLE E:\ORACLE\ORADATA\STOR\UNDOTBS02.DBF
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA10.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA11.ORA
STORELAND_DATA                       AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_DATA12.ORA
STORELAND_IDX                        AVAILABLE E:\ORACLE\ORADATA\STOR\STORELAND_IDX06.ORA
PERFTBS                              AVAILABLE E:\ORACLE\ORADATA\STOR\PERFTBS1.ORA

 Répertoire de E:\ORACLE\ORADATA\STOR

03/10/2017  17:28    <REP>          .
03/10/2017  17:28    <REP>          ..
06/10/2017  16:01         7 553 024 CONTROL01.CTL
06/10/2017  16:01         7 553 024 CONTROL02.CTL
06/10/2017  16:01         7 553 024 CONTROL03.CTL
06/10/2017  16:01       210 771 968 PERFTBS1.ORA
19/06/2017  09:37       104 858 112 REDO01_STOR.LOG
19/06/2017  09:37       104 858 112 REDO02_STOR.LOG
19/06/2017  09:38       104 858 112 REDO03_STOR.LOG
19/06/2017  09:38     5 444 214 784 STORELAND_DATA01.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA02.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA03.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA04.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA05.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA06.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA07.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA08.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA09.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA10.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA11.ORA
19/06/2017  09:38     5 444 214 784 STORELAND_DATA12.ORA
17/08/2017  19:14     5 444 214 784 STORELAND_IDX01.ORA
17/08/2017  19:14     5 444 214 784 STORELAND_IDX02.ORA
17/08/2017  19:14     5 444 214 784 STORELAND_IDX03.ORA
17/08/2017  19:14     5 444 214 784 STORELAND_IDX04.ORA
17/08/2017  19:14     5 444 214 784 STORELAND_IDX05.ORA
17/08/2017  19:14    10 485 768 192 STORELAND_IDX06.ORA
06/10/2017  16:00     1 073 750 016 SYSAUX01.DBF
19/06/2017  09:38     1 073 750 016 SYSTEM01.DBF
06/10/2017  10:39     6 578 774 016 TEMP01.DBF
06/10/2017  16:03     2 147 491 840 TEMP02.DBF
19/06/2017  09:38    34 359 730 176 UNDOTBS01.DBF
19/06/2017  09:38       115 351 552 UNDOTBS02.DBF
19/06/2017  09:38         5 251 072 USERS01.DBF
              32 fichier(s)   148 939 523 584 octets
               2 Rép(s)  38 809 673 728 octets libres

SQL>

select count(1), substr (table_name, 1, 1) as "Initiale"  from all_tables where owner = 'STORELAND' group by substr (table_name, 1, 1) order by 2;

set serveroutput on size 1000000
<tbl_sz>
DECLARE
     nbLignes NUMBER := 0;
 BEGIN
  
     FOR C1 IN (
         select owner
		      , TABLE_NAME 
           from all_tables
		  where owner like 'STORELAND'
		    and table_name between 'H' and 'L'
     ) LOOP
      
	 begin
       EXECUTE IMMEDIATE 'SELECT COUNT(1) FROM ' || C1.owner || '.' || C1.TABLE_NAME INTO nbLignes;      
       DBMS_OUTPUT.PUT_LINE(C1.TABLE_NAME || ': ' || nbLignes);
	 exception
	   when others then 
	   dbms_output.put_line ( C1.owner || '.' || C1.TABLE_NAME || ' - Err : ' || sqlerrm) ;
	 end ;
              
     END LOOP;
 END tbl_sz;
 /

