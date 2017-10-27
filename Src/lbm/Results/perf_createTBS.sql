/*
** %temp%\perf_createTBS.sql
** Script de creation du tablespabe specifique pour la config de STATSPACK
** Jebana
** 20171003
**
** NB : Script executé sous un schema d'administration
**/

Create tablespace PERFTBS
    LOGGING
    DATAFILE 'E:\ORACLE\ORADATA\STOR\PERFTBS1.ora'
    SIZE 150M
    REUSE
    AUTOEXTEND ON 
    NEXT 1024K 
    MAXSIZE 750M
    EXTENT MANAGEMENT LOCAL
    UNIFORM SIZE 1024K SEGMENT SPACE
    MANAGEMENT AUTO
;
