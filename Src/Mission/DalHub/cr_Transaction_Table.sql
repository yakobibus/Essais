

/*

TABLE CREATION SCRIPT FOR : TRANSACTION ENTITY

Each entity starts with a R_<entity> table root name
A sub entity must be defined using a R_<entity>_<child1>  R_<entity>_<child1>_<child2> pattern

A root entity must be defined using at least :
- uuid &&uuid_type &&uuid_length not null,  -- universal unique identifier
- lastmodified timestamp not null ,         -- usefull for optimistic locking mechanism
- createdDate  date not null    ,           -- creation date for the entity

PROJECT : DATAHUB
DATE   :01/2018

**/


create sequence &&schema_trans..seq_transaction
/

grant select on &&schema_trans..seq_transaction to public
/


create table &&schema_trans..r_transaction 
(
  uuid &&uuid_type&&uuid_length not null         -- universal unique identifier
, lastmodified timestamp not null                -- usefull for optimistic locking mechanism
, createdDate  date not null                     -- creation date for the entity
, statusCode varchar2(32) not null               -- current status
, statusDate  date not null                      -- status date
 -- ---
, transactionIds &&schema_common..idtable_t      -- (Identifiant alternatif : id_me, id_flex_1, id_flex_2, id_flex_3, id_flex_4 )
 -- ---
, &&sa_label_column     number   default null
, constraint r_transaction_pk primary key ( uuid) 
  USING INDEX STORAGE(INITIAL 6553600 NEXT 104857600 )
  TABLESPACE &&tbs_index_transaction ENABLE
, constraint r_transaction_status check (statusCode in ('A','I','H')) -- Active , Invalid, History
)
NESTED TABLE transactionIds STORE AS r_transaction_Ids
partition by list(statusCode)
( partition p_transaction_ACTIVE  values ('A')
, partition p_transaction_HISTO   values ('H')
, partition p_transaction_INVALID values ('I')
)
/

/**
CREATE OR REPLACE TRIGGER T_INSOBJECT
BEFORE UPDATE or delete ON r_transaction FOR EACH ROW
DECLARE
     MUTATING_TABLE EXCEPTION;
    PRAGMA EXCEPTION_INIT(MUTATING_TABLE, -4091);
BEGIN
  common.p_dataservice.saveJsonEntityHisto('TRANS', :old.uuid);
   EXCEPTION
        WHEN MUTATING_TABLE THEN
            null;
END;
/
**/
show err;
alter table &&schema_trans..r_transaction modify createdDate default sysdate;
alter table &&schema_trans..r_transaction modify statusDate default sysdate;
alter table &&schema_trans..r_transaction modify statusCode default 'A';
alter table &&schema_trans..r_transaction modify lastmodified default CURRENT_TIMESTAMP;
alter table &&schema_trans..r_transaction modify transactionTypeCode default 'I';
alter table &&schema_trans..r_transaction modify transactionIds  default &&schema_common..idtable_t( &&schema_common..id_t('cardif', 'orionId',  &&schema_trans..seq_transaction.nextval)) ;

alter table &&schema_trans..r_transaction modify transactionIds  default null ;

grant select on &&schema_trans..r_transaction to public
/

grant insert,update on &&schema_trans..r_transaction to &&schema_dataservice,&&schema_common
/



create table &&schema_trans..r_transaction_address (
    uuid &&uuid_type &&uuid_length not null,
    lnaddress integer not null,
    versionaddress integer not null,
    statusCode varchar2(32) not null,
    effectiveStartDate  date not null,
    effectiveEndDate date not null,
    addressTypeCode varchar2(32),
    addressContextCode varchar2(32) ,
    line1 varchar2(255),
    line2 varchar2(255),
    line3 varchar2(255),
    line4 varchar2(255),
    locality  varchar2(255),
    region varchar2(255),
    postalcode varchar2(255),
    countrycode varchar2(3),
    &&sa_label_column     number   default null,
constraint r_transaction_address_pk   primary key ( uuid,lnaddress,versionaddress)  USING INDEX STORAGE(INITIAL 6553600 NEXT 104857600 )TABLESPACE &&tbs_index_transaction ENABLE,
constraint r_transaction_address_fk   foreign key ( uuid) references &&schema_trans..r_transaction
)
partition by reference (r_transaction_address_fk)
/

grant select on &&schema_trans..r_transaction_address to public
/
grant insert,update on &&schema_trans..r_transaction_address to &&schema_dataservice,&&schema_common
/


create table &&schema_trans..r_transaction_job (
    uuid &&uuid_type &&uuid_length not null,
    lnjob integer not null,
    versionjob  integer not null,
    statusCode varchar2(32) not null,
    effectiveStartDate  date not null,
    effectiveEndDate date not null,
    EmploymentStatusCode varchar2(32),
    EmployerName VARCHAR(32),
    GrossSalaryAmount decimal(12,2),
    NetSalaryAmount decimal(12,2),
    salaryAmountCurrencyCode varchar2(3),
    empadressline1 varchar2(255),
    empadressline2 varchar2(255),
    empadressline3 varchar2(255),
    empadressline4 varchar2(255),
    empadresslocality  varchar2(255),
    empadressregion varchar2(255),
    empadresspostalcode varchar2(255),
    empadresscountrycode varchar2(3),
    professionName varchar2(255),
    cspCode varchar2(3),
    compagnyName varchar2(255),
    &&sa_label_column     number   default null,
constraint r_transaction_job_pk   primary key ( uuid,lnjob,versionjob)  USING INDEX STORAGE(INITIAL 6553600 NEXT 104857600 )TABLESPACE &&tbs_index_transaction ENABLE,
constraint r_transaction_job_fk   foreign key ( uuid) references &&schema_trans..r_transaction)
partition by reference (r_transaction_job_fk)
/




grant select on &&schema_trans..r_transaction_job to public
/


grant insert,update on &&schema_trans..r_transaction_job to &&schema_dataservice,&&schema_common
/



-----------


R_TRANSATION

    uuid
    lastModified 

    createdDate 

    statusCode
    statusDate
    id_transaction (Identifiant alternatif)
        id_me
            Sans composante date (6 premiers caractères), cd_exercice, et cd_periode 
            Sans incrément 
        id_flex_1
        id_flex_2
        id_flex_3
        id_flex_4 

 

R_TRANSACTION_DETAIL

    uuidTransaction 

    lineTransaction 

    versionTransaction
    effectiveStartDate
    effectiveEndDate 

    id_tr 

    id_cre 

    dt_effet 

    dt_connaissance 

    dt_comptable 

    id_societe
    cd_devise
    cd_source
    cd_exercice
    cd_periode
    cd_rubrique
    cd_sens 

    mt_prime_ht_tot
    cd_type_cre 


