/
**/


create or replace
PACKAGE BODY p_entityhandler  IS


  /**
  Return SQL block command for a link
  pmaxOffset : max number of record to get , use 0 for all

  **/
  function getSqlBaseLink(pmaxOffset integer default 30, plevel integer default 0)  return varchar2 is

     lcommand  varchar2(32000);
  BEGIN

      lcommand := ' SELECT link.* from v_linker link where link.source_uuid=c'||plevel||'.uuid ';

      -- block maximum number
      if (pmaxOffset>0) then
         lcommand :=lcommand||' and rownum<='|| pmaxOffset ;
      end if;
      return lcommand;
  END ;


  /**
    get a sql base request according scope
  */

   function  priv_getSqlBaseSelect    (  pobjectName in varchar2  , pScope in varchar2 default SCOPE_ALL, plevel in integer default 0, pObjectParent  in out nocopy p_objecthandler.t_object) return varchar2   is

    lcommand  varchar2(32000);
    lcommandChild varchar2(32000);

    lattribute   p_objecthandler.t_attribute;
    pobject      p_objecthandler.t_object;
    lchildobject p_objecthandler.t_object;
    lchildobjectTable p_objecthandler.t_objecttable;
    i integer;
    j integer;
    idx integer;
    lobjectRoot p_objecthandler.t_object;
    limitToActive boolean;
    lidxObject integer;
    suffixEntity varchar2(255);
  BEGIN

    -- get object
     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);

    if ( not p_objecthandler.listAllObjectTable(lidxObject).sqlBaseSelect.EXISTS(pScope)) then
      dbms_output.put_line('Creating select command for Entity '||pobjectName);

      pobject:=p_objecthandler.listAllObjectTable(lidxObject);
      suffixEntity:=substr(pobject.info.name,instr(pobject.info.name,'_',-1)+1);
      -- find child object
      p_objecthandler.getChildObject(pobject,lchildobjectTable);
     lcommand :='SELECT ';

      -- no attribute N? ( like for a view) --> select *
      if (pobject.attributes.COUNT=0) then
        lcommand := lcommand ||'*';
      end if;

      limitToActive:=false;

      -- first : column attribute
      idx:=plevel+1;
      for i in (plevel+1)..pobject.attributes.COUNT  loop
        lattribute :=pobject.attributes(i);

        -- never get lastmodified value
        if (lattribute.attributeName <> p_objecthandler.ATTRIBUTE_NAME_LASTMODIFIED  and lattribute.attributeName <> (p_objecthandler.ATTRIBUTE_NAME_VERSION||suffixEntity) and lattribute.attributeName <> p_objecthandler.ATTRIBUTE_NAME_SA_LABEL ) then
            if (plevel>0 or (pScope is null  or  instr(pScope,SCOPE_ALL)>0 or  instr(pScope,SCOPE_ROOT)>0 ) or (lattribute.sqLName='UUID' or lattribute.sqLName='LASTMODIFIED')) then
               if (idx>plevel+1) then
                  lcommand :=lcommand||', ';
               end if;

              if (lattribute.attributeName =  p_objecthandler.ATTRIBUTE_NAME_STATUSCODE) then
                 limitToActive :=true;
              end if;
              idx:=idx+1;
              if (lattribute.sqltype ='IDTABLE_T') then
                 lcommand :=lcommand||'CURSOR (SELECT * FROM TABLE( c'||plevel||'.'||lattribute.sqLName||')) as "'||lower(lattribute.sqLName)||'"';
              else
                 lcommand :=lcommand||' c'||plevel||'.'||lattribute.sqLName||' as "'||lower(lattribute.sqLName)||'"';
              end if;
            end if;
        end if;
      end loop;


       --second : sub list object
       for i in 1..lchildobjectTable.COUNT  loop
          lchildobject :=lchildobjectTable(i);
          if (pScope is null  or  instr(pScope,SCOPE_ALL)>0 or instr(pScope,lchildobject.info.Name)>0 ) then
             lcommand :=lcommand||', CURSOR ( ';
             lcommandChild := priv_getSqlBaseSelect(lchildobject.info.name,pscope,plevel+1,pObject);
             lcommand :=lcommand||lcommandChild;
            lcommand :=lcommand||' ) as '||lchildobject.info.Name;
            end if;
      end loop;

      if (instr(pScope,SCOPE_LINK)>0 and plevel=0 ) then
        lcommand := lcommand||', CURSOR ('|| getSqlBaseLink() ||') as link ';
      end if;
      if (instr(pScope,SCOPE_EXTRADATA)>0 and plevel=0 ) then
        lcommand := lcommand||', CURSOR ('|| p_objecthandler.getSqlBaseExtraData(pObject) ||') as extradata ';
      end if;
       if (instr(pScope,SCOPE_HISTORY)>0 and plevel=0 ) then
        lcommand := lcommand||', CURSOR ('|| p_objecthandler.getSqlBaseHistory(pObject) ||') as history ';
      end if;
      lcommand := lcommand||' FROM '||p_objecthandler.getSqlFullTableName(pObject)||' c'||plevel;

      if ( pObject.info.type=p_objecthandler.TYPE_LINK and plevel=0) then
        lcommand := lcommand||' WHERE C0.ROLE='''||pObject.info.code||'''';
      end if;

       --join parent with child
       if ( plevel>0) then
           lcommand :=lcommand||' WHERE ';
           if (limitToActive) then
              lcommand :=lcommand||' c'||plevel||'.STATUSCODE='''||p_objecthandler.STATUS_ACTIVE ||'''';
           else
             lcommand :=lcommand||' 1=1 ';
           end if;
            for j in 1..pObjectParent.attributes.count loop
               if (pObjectParent.attributes(j).pkname is not null) then
                  lcommand :=lcommand||' AND ';

                    lattribute :=pObjectParent.attributes(j);
                    lcommand :=lcommand||' c'||(plevel)||'.'||lattribute.sqLName||'=c'||(plevel-1)||'.'||lattribute.sqLName;

              end if;
            end loop;

       end if;
       p_objecthandler.listAllObjectTable(lidxObject).sqlBaseSelect(pScope):= lcommand;
    end if;

    return  p_objecthandler.listAllObjectTable(lidxObject).sqlBaseSelect(pScope);
   end;

  function  getSqlBaseSelect    ( pobjectName in varchar2  , pScope in varchar2 default SCOPE_ALL ) return varchar2   is

    lObjectParentnull p_objecthandler.t_object;
  begin

    return priv_getSqlBaseSelect(pobjectName,pScope,0,lObjectParentnull);
  end;
  /**
    get a sql base insert for an object
  */
   function getSqlBaseInsert  ( pobjectName in varchar2 ) return varchar2 is

    lcommand  varchar2(32000);
    lcommandColumn  varchar2(32000);
    lcommandValue varchar2(32000);
    lattributetable p_objecthandler.t_attributetable;
    lattribute p_objecthandler.t_attribute;

    lidxObject integer;


  BEGIN

    -- get object
     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);

    if ( p_objecthandler.listAllObjectTable(lidxObject).sqlbaseInsert is null) then
      dbms_output.put_line('Creating insert command for Entity '||pobjectName);
      lattributetable := p_objecthandler.listAllObjectTable(lidxObject).attributes;
      lcommandColumn :='INSERT INTO '||p_objecthandler.getSqlFullTableName(p_objecthandler.listAllObjectTable(lidxObject))||' (';
      lcommandValue :='VALUES (';
      -- first :column attribute
      for i in 1..lattributetable.COUNT  loop

          lattribute :=lattributetable(i);
          if (i>1) then
                lcommandColumn :=lcommandColumn||', ';
                lcommandValue :=lcommandValue||', ';
          end if;
          lcommandColumn :=lcommandColumn||lattribute.sqLName;
          lcommandValue := lcommandValue||' :'||lattribute.attributename;
      end loop;

       lcommandColumn :=lcommandColumn||') ';
       lcommandValue := lcommandValue||')';
       p_objecthandler.listAllObjectTable(lidxObject).sqlbaseInsert := lcommandColumn|| lcommandValue;
     end if;
    return  p_objecthandler.listAllObjectTable(lidxObject).sqlbaseInsert;
  end;

  /**
    get a sql base update for an object
  */
   function getSqlBaseUpdate  (pobjectName in varchar2 ) return varchar2 is

    lcommand  varchar2(32000);
    lcommandColumn  varchar2(32000);
    lcommandWhere varchar2(32000);
    lattributetable p_objecthandler.t_attributetable;
    lattribute p_objecthandler.t_attribute;
    lobject p_objecthandler.t_object;
    idx integer;
    lidxObject integer;
    limitToActive boolean :=false;


  BEGIN

     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);

    if ( p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdate is null) then
      dbms_output.put_line('Creating update command for Entity '||pobjectName);

      -- get object
      p_objecthandler.getObject(p_objecthandler.TYPE_ENTITY,pObjectName,lobject);
      lattributetable := lobject.attributes;
      lcommandColumn :='UPDATE '||p_objecthandler.getSqlFullTableName(lobject)||' set ';
      lcommandWhere :='';
      idx :=0;
      -- first :column attribute
      for i in 1..lattributetable.COUNT  loop
           lattribute :=lattributetable(i);
            if (lattribute.attributeName =  p_objecthandler.ATTRIBUTE_NAME_STATUSCODE) then
               limitToActive :=true;
            end if;
           if (lattribute.pkname is null) then
               idx :=idx+1;
               if (idx>1) then
                    lcommandColumn :=lcommandColumn||', ';
               end if;
               lcommandColumn :=lcommandColumn||lattribute.sqLName||'=:'||lattribute.attributename;
           else

               lcommandWhere:=lcommandWhere||' AND '||lattribute.sqLName||'=:'||lattribute.attributename;
           end if;
      end loop;
      if (limitToActive) then
          lcommandWhere :=lcommandWhere ||' AND STATUSCODE='''|| p_objecthandler.STATUS_ACTIVE||'''';
      end if;
      p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdate := lcommandColumn||' WHERE 1=1 '||lcommandWhere;
    end if;
    return  p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdate ;
  end;

  function getSqlBaseUpdatePrevious  (pobjectName in varchar2 ) return varchar2 is

    lcommand  varchar2(32000);
    lcommandColumn  varchar2(32000);
    lcommandWhere varchar2(32000);
    lattributetable p_objecthandler.t_attributetable;
    lattribute p_objecthandler.t_attribute;
    lobject p_objecthandler.t_object;
    lidxObject integer;
    suffixEntity varchar2(255);
    limitToActive boolean :=false;

  BEGIN

     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);
    -- get object

    if ( p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdatePrevious is null) then
      dbms_output.put_line('Creating update previous command for Entity '||pobjectName);

      -- get object
      p_objecthandler.getObject(p_objecthandler.TYPE_ENTITY,pObjectName,lobject);

      suffixEntity:=substr(lobject.info.name,instr(lobject.info.name,'_',-1)+1);
      lattributetable := lobject.attributes;
      lcommandColumn :='UPDATE '||p_objecthandler.getSqlFullTableName(lobject)||' set effectiveenddate = GREATEST( effectivestartdate,:effectivestartdate ), statuscode= decode(sign(:effectivestartdate- effectivestartdate),1,statuscode, '''||p_objecthandler.STATUS_INVALID ||''') ';

      lcommandWhere :='';

      -- first :column attribute
      for i in 1..lattributetable.COUNT  loop
           lattribute :=lattributetable(i);
            if (lattribute.attributeName =  p_objecthandler.ATTRIBUTE_NAME_STATUSCODE) then
               limitToActive :=true;
            end if;

           if (lattribute.pkname is not null and lattribute.attributename  !=(p_objecthandler.ATTRIBUTE_NAME_VERSION||suffixEntity)) then

              lcommandWhere:=lcommandWhere||' AND ' || lattribute.sqLName||'=:'||lattribute.attributename;
           end if;
      end loop;

       if (limitToActive) then
          lcommandWhere :=lcommandWhere ||' AND STATUSCODE='''|| p_objecthandler.STATUS_ACTIVE||'''';
      end if;
      p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdatePrevious := lcommandColumn||' WHERE 1=1 '||lcommandWhere;
    end if;
    return  p_objecthandler.listAllObjectTable(lidxObject).sqlbaseUpdatePrevious;
  end;


  function getSqlBaseSelectExist  (pobjectName in varchar2 ) return varchar2 is


    lcommandColumn  varchar2(32000);
    lcommandWhere varchar2(32000);
    lattributetable p_objecthandler.t_attributetable;
    lattribute p_objecthandler.t_attribute;
    lobject p_objecthandler.t_object;
    lidxObject integer;
    suffixEntity varchar2(255);

  BEGIN
     -- get object
     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);


     if ( p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectExist is null) then
       dbms_output.put_line('Creating select exist command for Entity'||pobjectName);


       -- get object
      p_objecthandler.getObject(p_objecthandler.TYPE_ENTITY,pObjectName,lobject);

       suffixEntity:=substr(lobject.info.name,instr(lobject.info.name,'_',-1)+1);

       lattributetable := lobject.attributes;
       lcommandColumn :='SELECT count(1) FROM '||p_objecthandler.getSqlFullTableName(lobject);
       lcommandWhere :='';

      -- first :column attribute
      for i in 1..lattributetable.COUNT  loop
           lattribute :=lattributetable(i);
           if (lattribute.pkname is not null and lattribute.attributename !=(p_objecthandler.ATTRIBUTE_NAME_VERSION||suffixEntity)) then
              lcommandWhere:=lcommandWhere||' AND '||lattribute.sqLName||'=:'||lattribute.attributename;
           end if;
      end loop;
      p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectExist := lcommandColumn||' WHERE 1=1 '|| lcommandWhere;
    end if;
dbms_output.put_line ('Coucou 1 : ['||p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectExist||']');
    return  p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectExist;
  end;


function getSqlBaseSelectMaxPrevious  (pobjectName in varchar2 ) return varchar2 is


    lcommandColumn  varchar2(32000);
    lcommandWhere varchar2(32000);
    lattributetable p_objecthandler.t_attributetable;
    lattribute p_objecthandler.t_attribute;
    lobject p_objecthandler.t_object;
    lidxObject integer;
    suffixEntity varchar2(255);

  BEGIN
     -- get object
     lidxObject := p_objecthandler.getIdxObject(p_objecthandler.TYPE_ENTITY,pObjectName);


     if ( p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectMaxPrevious is null) then
       dbms_output.put_line('Creating select max previous command for Entity '||pobjectName);


       -- get object
       p_objecthandler.getObject(p_objecthandler.TYPE_ENTITY,pObjectName,lobject);

       suffixEntity:=substr(lobject.info.name,instr(lobject.info.name,'_',-1)+1);

       lattributetable := lobject.attributes;
       lcommandColumn :='SELECT NVL(MAX(VERSION'||substr(pobjectName,instr(pobjectName,'_',-1)+1) || ' ),0) AS VERSION FROM '||p_objecthandler.getSqlFullTableName(lobject);
       lcommandWhere :='';

      -- first :column attribute
      for i in 1..lattributetable.COUNT  loop
           lattribute :=lattributetable(i);
           if (lattribute.pkname is not null and lattribute.attributename !=(p_objecthandler.ATTRIBUTE_NAME_VERSION||suffixEntity)) then
              lcommandWhere:=lcommandWhere||' AND '||lattribute.sqLName||'=:'||lattribute.attributename;
           end if;
      end loop;
      p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectMaxPrevious := lcommandColumn||' WHERE 1=1 '|| lcommandWhere;
    end if;
    return  p_objecthandler.listAllObjectTable(lidxObject).sqlbaseSelectMaxPrevious;
  end;
end p_entityhandler;
/
show errors
