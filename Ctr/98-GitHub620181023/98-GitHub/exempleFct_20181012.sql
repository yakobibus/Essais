---Script d’installation
/*
** Réentrance : destruction des objets s'ils existent déjà.
** Ne pas tenir compte des erreurs résultant de leur absence :
**   ORA-00942: Table or view does not exist
**   ORA-04043: objet Tab_ContratPrev_T does not exist
**   ORA-04043: objet ContratPrev_T does not exist
** Ces ordres serviront aussi à détruire l’environnement de cet exemple
**/
 
--DROP TABLE ObjectList_T cascade constraints ;
DROP TYPE Tab_ContratPrev_T;
DROP TYPE ContratPrev_T;
 
create or replace package own_19637_common.ctrpvy_pkg is
  function f_get_ctrpvy(perimetre in varchar2 default 'GAR', date_effet in date default sysdate - 1) return SYS_REFCURSOR  ;
end ctrpvy_pkg;
/
show errors
grant execute on own_19637_common.ctrpvy_pkg to own_19637_dataservice with grant option ;
create synonym own_19637_dataservice.ctrpvy_pkg for own_19637_common.ctrpvy_pkg ;

 
 
create or replace package body own_19637_common.ctrpvy_pkg is
  function f_get_ctrpvy(perimetre in varchar2 default 'GAR', date_effet in date default sysdate - 1) return SYS_REFCURSOR  is
    my_cursor SYS_REFCURSOR;
  begin
    open my_cursor for 
        select ctr.*
             , crc.date_signature_souscription, crc.date_terme_contrat
             , cov.code_nature_couverture, cov.date_debut_couverture, cov.date_fin_couverture, cov.code_nature_couverture
             , gar.identifiant_garantie, gar.code_type_garantie_produit, gar.montant_assure_initial, gar.montant_assure_actuel, gar.montant_capitaux_sous_risque
          from own_19637_contratprev.ctrpvy_r ctr
               inner join own_19637_contratprev.ctrpvy_crc_c crc on crc.uuid = ctr.uuid
               inner join own_19637_contratprev.ctrpvy_cov_c cov on cov.uuid = ctr.uuid
               inner join own_19637_contratprev.ctrpvy_cov_gar_c gar on gar.uuid = cov.uuid and gar.lncov = cov.lncov
         where sysdate -1 between gar.effectivestartdate and gar.effectiveenddate
           and ctr.statuscode = 'A' 
           and cov.statuscode = 'A'
           and gar.statuscode = 'A'
        ;
    return  my_cursor;
  end f_get_ctrpvy;
end ctrpvy_pkg;
/
show errors
grant execute on own_19637_common.ctrpvy_pkg to own_19637_dataservice with grant option ;
create synonym own_19637_dataservice.ctrpvy_pkg for own_19637_common.ctrpvy_pkg ;
 
 
 
/*
** Création de la table et des données de l'exemple
**/

/* 
CREATE TABLE ObjectList_T AS 
  SELECT object_type, object_name, last_ddl_time
    FROM all_objects 
   WHERE rownum < 5001 
;
Alter table ObjectList_T add constraint ObjectList_pk 
      primary key (object_type, object_name) ;
*/
 
/*
** Création des types supports du résultat de la fonction
**/
 
CREATE TYPE ContratPrev_T IS OBJECT( uuid raw (16), name VARCHAR2 (2048), ddl_time DATE );
/
show errors
 
CREATE TYPE Tab_ContratPrev_T IS TABLE OF ContratPrev_T;
/
show errors
 
/*
** Création de la fonction retournant une table. Elle est portée par un package
**/
 
CREATE OR REPLACE PACKAGE ObjectList_pkg AS
   FUNCTION f_DynamicCollect (p_option NUMBER)
      RETURN Tab_ContratPrev_T;
END ObjectList_pkg;
/
show errors
 
CREATE OR REPLACE PACKAGE BODY ObjectList_pkg AS
   FUNCTION f_DynamicCollect (p_option NUMBER)
      RETURN Tab_ContratPrev_T IS
      l_sql     VARCHAR2 (1024);
      l_table   Tab_ContratPrev_T := Tab_ContratPrev_T ();
   BEGIN
      l_sql := 'SELECT ContratPrev_T (ol.object_type, ''Option ' || case p_option when 1 then 'une' when 2 then 'deux' else 'inconnue' end || ' : '' || ol.object_name, ol.last_ddl_time) FROM ObjectList_T ol' ;
      
      EXECUTE IMMEDIATE l_sql BULK COLLECT INTO l_table;
 
      RETURN l_table;
   END f_DynamicCollect ;
 
END ObjectList_pkg;
/
show errors
 
Exemples d'usages par des requêtes simples
SELECT * 
  FROM TABLE (ObjectList_pkg.f_DynamicCollect (1))
 WHERE  ROWNUM < 21
;
--
SELECT * 
  FROM TABLE (ObjectList_pkg.f_DynamicCollect (2))
 WHERE ROWNUM < 21
;
Script de désinstallation
/*
** Ces ordres serviront aussi à détruire l’environnement de cet exemple
**/
 
--DROP TABLE ObjectList_T cascade constraints ;
DROP TYPE Tab_ContratPrev_T;
DROP TYPE ContratPrev_T;
 

