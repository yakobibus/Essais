/*
** Réentrance : destruction des objets s'ils existent déjà.
** Ne pas tenir compte des erreurs résultant de leur absence :
**   ORA-00942: Table or view does not exist
**   ORA-04043: objet T_OBJTABLE does not exist
**   ORA-04043: objet T_OBJRECORD does not exist
** Ces ordres serviront aussi à détruire l’environnement de cet exemple
**/
 
DROP TABLE ObjectList_T cascade constraints ;
DROP TYPE t_ObjTable;
DROP TYPE t_ObjRecord;
 
 
/*
** Création de la table et des données de l'exemple
**/
 
CREATE TABLE ObjectList_T AS 
  SELECT object_type, object_name, last_ddl_time
    FROM all_objects 
   WHERE rownum < 5001 
;
Alter table ObjectList_T add constraint ObjectList_pk 
      primary key (object_type, object_name) ;
 
/*
** Création des types supports du résultat de la fonction
**/
 
CREATE TYPE t_ObjRecord IS OBJECT( kind varchar2 (1024), name VARCHAR2 (2048), ddl_time DATE );
/
show errors
 
CREATE TYPE t_ObjTable IS TABLE OF t_ObjRecord;
/
show errors

/*
** Création de la fonction retournant une table. Elle est portée par un package
**/
 
CREATE OR REPLACE PACKAGE ObjectList_pkg AS
   FUNCTION f_DynamicCollect (p_option NUMBER)
      RETURN t_ObjTable;
END ObjectList_pkg;
/
show errors
 
CREATE OR REPLACE PACKAGE BODY ObjectList_pkg AS
   FUNCTION f_DynamicCollect (p_option NUMBER)
      RETURN t_ObjTable IS
      l_sql     VARCHAR2 (1024);
      l_table   t_ObjTable := t_ObjTable ();
   BEGIN
      l_sql := 'SELECT t_ObjRecord (ol.object_type, ''Option ' || case p_option when 1 then 'une' when 2 then 'deux' else 'inconnue' end || ' : '' || ol.object_name, ol.last_ddl_time) FROM ObjectList_T ol' ;
      
      EXECUTE IMMEDIATE l_sql BULK COLLECT INTO l_table;
 
      RETURN l_table;
   END f_DynamicCollect ;
 
END ObjectList_pkg;
/
show errors
 
/*
** Exemples d'usages par des requêtes simples
**/

SELECT * 
  FROM TABLE (ObjectList_pkg.f_DynamicCollect (1))
 WHERE  ROWNUM < 21
;
--
SELECT * 
  FROM TABLE (ObjectList_pkg.f_DynamicCollect (2))
 WHERE ROWNUM < 21
;
