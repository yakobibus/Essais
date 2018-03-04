/*
**/


create or replace
PACKAGE BODY p_objecthandler  IS


   -- reload all static  definition
  procedure reloadAll is
  begin
    listAllObjectTable := null;
  end;

  --load all main entities
  procedure loadAllMain is

    cursor c1 is select * from m_info_dh_object  order by type,name ;
    lobject t_object;
    lchildobjectTable t_objecttable;
    idx integer;
    countMain integer;
  begin
    listAllObjectTable := t_objecttable();

    for r1 in c1 loop
        dbms_output.put_line( 'object '||r1.type||'.'||r1.name||' loaded');
        listAllObjectTable.extend(1);
        idx:=listAllObjectTable.count();
        mapAllObjectTable(r1.type||'.'||r1.code):=idx;
        mapAllObjectTable(r1.type||'.'||r1.name):=idx;
        listAllObjectTable(idx).info:=r1;
        listAllObjectTable(idx).root:=r1.name;
        listAllObjectTable(idx).parent:=null;
        listAllObjectTable(idx).attributes:=loadAttributes(r1.sqlschema,r1.type,r1.name,r1.sqlname);
        --listAllObjectTable(idx).sqlbaseselect:=t_selectbaseMap();
    end loop;

    -- loading child object
    countMain:=listAllObjectTable.count;
    for idx in 1..countMain loop

        lchildobjectTable := loadChild(listAllObjectTable(idx).info.sqlschema,listAllObjectTable(idx).info.type,listAllObjectTable(idx).info.name,listAllObjectTable(idx).info.sqlname);
        for idx2 in 1..lchildobjectTable.count loop
              listAllObjectTable.extend(1);
              dbms_output.put_line( 'sub object '||lchildobjectTable(idx2).info.type||'.'||lchildobjectTable(idx2).info.name||' loaded');
              mapAllObjectTable(lchildobjectTable(idx2).info.type||'.'||lchildobjectTable(idx2).info.name):=listAllObjectTable.count;
              listAllObjectTable( listAllObjectTable.count):=lchildobjectTable(idx2);
        end loop;
    end loop;
  end;

  /**

  Load all child object from a specific parent object

  */
  function  loadChild( pobjectSchema in varchar2,  pobjectType in varchar2,pobjectName in varchar2,pobjectSqlName in varchar2 ) return t_objecttable is

    llevel integer;
    lchildobjectTable t_objecttable;

     lobject t_object;
     parentObject varchar2(255) :=null;
     previousObject varchar2(255) :=null;
     idx integer :=0;
     cursor cchild  is
           select substr(table_name,3) as objectName, table_name as sqltable from all_tables tc where owner=upper(pobjectSchema) and table_name like upper(pobjectSqlName)||'\_%'  ESCAPE '\';

    begin
        llevel:=1;
        lchildobjectTable :=t_objecttable();
        for rchild in cchild loop
            parentObject:=pobjectName;
            lobject.info.name:=lower(rchild.objectName);
             if (previousObject is not null and length(previousObject) <length( lobject.info.name)) then
                if (substr(lobject.info.name,1,length(previousObject))= previousObject) then
                    parentObject := previousObject;
                    llevel:=llevel+1;
                end if;
            end if;

            lchildobjectTable.extend(1);
            lobject.info.sqlschema:=pobjectSchema;
            lobject.info.sqlname:=rchild.sqltable;
            lobject.root:=pobjectName;
            lobject.info.type:=pobjectType;
            lobject.parent:=parentObject ;
            lobject.attributes:=loadAttributes(pobjectSchema,lobject.info.type,lobject.info.name,lobject.info.sqlname);
            lchildobjectTable(lchildobjectTable.count()):=lobject;
            previousObject:=lobject.info.name;
        end loop;

     return lchildobjectTable;
    end;


  function  loadAttributes( pobjectSchema in varchar2, pobjectType in varchar2,pobjectName in varchar2 ,pSqlName in varchar2) return t_attributetable is

    cursor cattribute  is select * from v_getListAttribute where schemaname =upper(pobjectSchema) and sqlname = upper(pSqlName) ;
    lattributetable t_attributetable;
    lattribute t_attribute;
    idx integer :=0;

  begin

        lattributetable:=t_attributetable();
        for rattribute in cattribute loop
              idx:=idx+1;
              lattribute.attributeName:=lower(rattribute.ATTRIBUTENAME);
              lattribute.attributeType:=rattribute.ATTRIBUTETYPE;
              lattribute.sqLName:=rattribute.ATTRIBUTENAME;
              lattribute.sqLType:=rattribute.ATTRIBUTETYPE;
              lattribute.sqllength:=rattribute.ATTRIBUTELENGTH;
              lattribute.pkname:=rattribute.PK_CONSTRAINT_NAME;
              lattributetable.extend(1);
              lattributetable(idx) := lattribute;
        end loop;

     return lattributetable;
  end;


  /**
    Get en object handler based on the name of the object or the code ( PER, POL,CLA... or person, policy, claim)
  **/
  procedure getObject (pobjectType in varchar2,pObjectNameOrCode in varchar2,p_object out nocopy t_object)  is
    idx integer default 0;
  begin

    idx := getIdxObject(pobjectType,pObjectNameOrCode);

    p_object := listAllObjectTable(idx);

    return ;

  end;


  function getIdxObject (pobjectType in varchar2,pObjectNameOrCode in varchar2)  return integer is

  begin
    -- find the object handler in the static list
    -- but first assume to load it from db if not already done
    if (listAllObjectTable is null) then
        loadAllMain;
    end if;

    --search in map
    If (not mapAllObjectTable.EXISTS(pobjectType||'.'||pObjectNameOrCode)) then
      raise_application_error(-20003,'Object type "'||pobjectType||'.'||pObjectNameOrCode||'" does not exist in list size '||mapAllObjectTable.count);
    end if;
    return  mapAllObjectTable(pobjectType||'.'||pObjectNameOrCode);
  end;

   /**
      get the list of all direct child entities associated with a object
   **/
   procedure getChildObject( pObject in out  nocopy t_object, pobjecttable out nocopy t_objecttable ) is

   begin
    if (listAllObjectTable is null) then
        loadAllMain;
    end if;
      pobjecttable :=t_objecttable();
      for idx in 1..listAllObjectTable.count loop
         if (listAllObjectTable(idx).parent = pObject.info.name) then
            pobjecttable.extend(1);
            pobjecttable(pobjecttable.count()) := listAllObjectTable(idx);
         end if;
      end loop;
   end;

  /**
      get parameter associated with a object
  **/
  function  getParameter ( pObject  in out nocopy t_object,pKey in varchar2,pDefaultValue in varchar2 default null) return varchar2
  is
    lvalue varchar2(4000);
  begin
      for idx in 1..pObject.info.parameter.count  loop
          --find it !

          if (pObject.info.parameter(idx).key= pKey) then
             return pObject.info.parameter(idx).value;
          end if ;
     end loop;
      --not find ? return default value
      return pDefaultValue ;
  end;

  /**
      get SQLTABLE fully qualifies using schema.table model  associated with a object
  **/
  function  getSqlFullTableName(pObject  in out  nocopy t_object) return varchar2 is

  begin
      return upper(pObject.info.sqlschema)||'.'||upper(pObject.info.sqlname);
  end;

  /**
  Return SQL block command for a link
  pmaxOffset : max number of record to get , use 0 for all

  **/

  function  getSqlSpecificTable( pobject in out nocopy  t_object, specificKey in varchar2, defaultTable in varchar2 ) return varchar2 is

  sqlTable varchar2(255);
  begin
      sqlTable:= getParameter(pobject,'table_'||specificKey,'UNDEFINED');
      if ( sqlTable='UNDEFINED') then
           sqlTable:=defaultTable;
      else
        if ( sqlTable is not null) then
              sqlTable:=pobject.info.sqlschema||'.'||sqlTable;
        end if;
      end if;
      return sqlTable;
  end;


  /**

  Return SQL block command for extradata

  **/
  function getSqlBaseExtraData(pobject in out nocopy  t_object)  return varchar2 is

  BEGIN
      return ' SELECT kv.* from '||getSqlSpecificTable(pobject,SCOPE_EXTRADATA,DEFAULT_EXTRADATA_TABLE)||' e ,table(e.kvtable) kv where e.uuid=c0.uuid ';
  END;


  /**

  Return SQL block command for history

  **/
  function getSqlBaseHistory(pobject in out nocopy  t_object)  return varchar2 is

  BEGIN
      return   ' SELECT h.* from '||getSqlSpecificTable(pobject,SCOPE_HISTORY,DEFAULT_HISTORY_TABLE)||' h where h.uuid=c0.uuid ';
  END;



end;
/
show errors
