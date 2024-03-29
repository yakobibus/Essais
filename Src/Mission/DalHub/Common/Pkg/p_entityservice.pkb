/*
**/

create or replace
PACKAGE BODY own_07755_common.p_entityservice  IS
    /*
      20180227 : JEB :  function existById
        Remplacement de (1) par (2). Objetif, permettre l'appel avec le seul ID
        (1) where c.scheme = :scheme
        (1) and   c.issuer = :issuer
        (2) where c.scheme = nvl( :scheme, c.scheme )
        (2) and   c.issuer = nvl( :issuer, c.issuer )
    */
-- Ptototypes des functions/procédures privées
function priv_existsIds ( pUuid in out nocopy raw
                        , pIds in out nocopy IDTABLE_T
                        , pEntity in P_OBJECTHANDLER.t_object
                        ) return boolean ;
--
function  mergeExtradata( psource1 in  kvtable_t, psource2 in kvtable_t) return kvtable_t is
   ldest kvtable_t ;
   lelem kv_t;
   idx integer;
   idx2 integer;
   idxfind integer;
   bdelete boolean;
begin

  --copy source 1 to target
  ldest:=kvtable_t();
  if (psource1 is not null) then
    for idx in 1 .. psource1.count loop
        bdelete:=false;
        for idx2 in 1 .. psource2.count loop
           if ( psource2(idx2).key = '-'||psource1(idx).key) then
              bdelete := true; 
           end if;
        end loop;
         -- key start with minus operator (-)  mean with don't want it anymore !! delete the key
        if (not bdelete and substr(psource1(idx).key,1,1) !='-') then
           ldest.extend(1);
           ldest(ldest.count) := psource1(idx);
         end if;
    end loop;
  end if;
 
  --update using the source 2
  for idx in 1 .. psource2.count loop
    lelem := psource2(idx);
    -- search
    idxfind:=0;
  
     for idx2 in 1 .. ldest.count loop
       if (ldest(idx2).key=lelem.key and substr(lelem.key,1,1) !='-') then
          idxfind :=idx2;
        end if; 
     end loop;
    if ( idxfind>0) then
       ldest(idxfind):=lelem;
    else
     if (substr(lelem.key,1,1) !='-') then
      ldest.extend(1);
      ldest(ldest.count):=lelem;
      end if;
    end if;
  end loop;
 
  return ldest;

end;

   /**
      Save the object in the history
     */
  procedure priv_saveJsonInHistory (pobjectCode in varchar2 , puuid in raw, plastmodified in   TIMESTAMP, pjsonobject in  out NOCOPY clob , pjsonHash  varchar2 default null ,noRaiseExceptionOnDuplicate integer default 0) is
  
     lobject P_OBJECTHANDLER.t_object;
     lrequest varchar2(2000);
  begin
   
     P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectCode,lobject);
    
     lrequest:='insert INTO ' ||P_OBJECTHANDLER.getSqlSpecificTable(lobject,P_OBJECTHANDLER.SCOPE_HISTORY,P_OBJECTHANDLER.DEFAULT_HISTORY_TABLE)|| ' values (
                  :lobjectCode,
                  :puuid,
                  :plastmodified,
                  :pjsonobject,
                  :pjsonHash,
                  10)';
     execute immediate lrequest using lobject.info.code,puuid,plastmodified, pjsonobject,pjsonHash ;  
     exception
       when DUP_VAL_ON_INDEX then
        if (noRaiseExceptionOnDuplicate>0) then
          return;
        end if;
        raise;
  end;
 
 
 
/**
    get a cursor to an  object by uuid
    using scope
 **/  
 procedure priv_get ( pobjectnameorcode in varchar2 ,  puuid in raw, pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL ,pcursor out SYS_REFCURSOR)
AS
  lobject  P_OBJECTHANDLER.t_object;
  lcommand  varchar2(32000);
 
  i integer;
BEGIN

  --get the object  based on the code or name (ex :PER = person
  P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectnameorcode,lobject);
 
  -- get the default base select for the object
  lcommand :=P_ENTITYHANDLER.getSqlBaseSelect( lobject.info.name,pscope);
 
  -- adjust the where clause with the uuid and open the cursor !
  if (puuid is not null ) then
      lcommand := lcommand || ' where c0.uuid=:1' ;
      OPEN pcursor FOR lcommand USING puuid;
  else
      OPEN pcursor  FOR lcommand ;
  end if;
end;



/**
   Private procedure to get a jsonObject from an object based on the UUID
**/
procedure  priv_getJson (pobjectnameorcode in varchar2 , puuid in raw, pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL, pjson in out nocopy t_json )  is
 
      lcursorObject SYS_REFCURSOR;
    
       BEGIN
          
            -- get a SQL CURSOR for the object
            priv_get(pobjectnameorcode, puuid,pscope ,lcursorObject);
           
            APEX_JSON.initialize_clob_output;
            --apex_json.open_object;
            -- DO IT !!!!! create JSON based on cursor
            APEX_JSON.write( lcursorObject );
          
           --apex_json.close_object;
            -- copy the JSON to new clob , removing fisrt and last character ([]) representing an JSON ARRAY to
            -- simplify to a JSONobject
            dbms_lob.createtemporary(pjson.jsonValue,true,dbms_lob.CALL);
            DBMS_LOB.COPY (
                  pjson.jsonValue,
                  APEX_JSON.get_clob_output,
                  DBMS_LOB.GETLENGTH(APEX_JSON.get_clob_output)-3,
                  1,
                  2);
                 
            -- calculate hash value to be sure somothing has change 
            pjson.jsonHash :=sys.dbms_crypto.hash(pjson.jsonValue,2);
   
           --apex_json.close_object;
           --free local clob
            APEX_JSON.free_output;
     
   end;
   /**
   Private procedure to get a jsonObject from an object based on the UUID
**/
procedure  priv_getJson2 (pobjectnameorcode in varchar2 , puuid in raw, pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL, pjson in out nocopy t_json )  is
 
      lcursorObject SYS_REFCURSOR;
    
       BEGIN
          
            -- get a SQL CURSOR for the object
            priv_get(pobjectnameorcode, puuid,pscope ,lcursorObject);
            
           
     
   end;
  
   /**
    get a cursor to an search object by id
    id must be provided using scheme/issuer/value pattern (for ex cardif/orion/135163)
    using scope
   **/  
   function getByIdCursor ( pobjectnameorcode in varchar2 ,id in varchar2, pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL ) return SYS_REFCURSOR
  AS
   
     lcommand  varchar2(32000);
     lobject P_OBJECTHANDLER.t_object;
     i integer;
     lcursor SYS_REFCURSOR;
  BEGIN
 
    --get the object name based on the code (ex :PER = person
    P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectnameorcode,lobject);
  
    -- get the default base select for the object
    lcommand :=P_ENTITYHANDLER.getSqlBaseSelect( lobject.info.name,pscope);
   
    -- adjust the where clause with the uuid and open the cursor !
    if (id is not null ) then
        --- JEB lcommand := lcommand || ' where ci=:1' ;
        lcommand := lcommand || ', table (c0.personids ) c99 where c99.id = :1' ;
/*
JEB : 2018 :
Résolution de l'erreur ORA-00904: "CI" : identificateur non valide
par une astuce incomplète impliquant uniquement R_PERSON
TODO : Généraliser cette correction avec une valeur dynamique pour l'ids

        (1) lcommand := lcommand || ' where ci=:1' ;
        (2) lcommand := lcommand || ', table (c0.personids ) c99 where c99.id = :1' ;
*/
--dbms_output.put_line ('coucou 98 : ['||lcommand|| '], used id = ['||id||']') ;
        OPEN lcursor FOR lcommand USING id;
    else
--dbms_output.put_line ('coucou 99 : ['||lcommand|| ']') ;
        OPEN lcursor  FOR lcommand ;
    end if;
  
   return lcursor;
  end;


 /**
    get a cursor to an search object by UUIid
    UUid must be provided USING raw FORMAT
    using scope
   **/  
  
  function getAllCursor( pobjectnameorcode in varchar2  , pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL ) return SYS_REFCURSOR   is
   my_cursor SYS_REFCURSOR;
  begin
    priv_get (pobjectnameorcode,null,pscope,my_cursor);
   RETURN my_cursor;
  end;
 
 /**
    get a cursor to an search object by UUIid
    UUid must be provided USING raw FORMAT
    using scope
   **/  
  
  function getCursor(pobjectnameorcode in varchar2  ,puuid in raw , pscope in varchar2 default P_OBJECTHANDLER.SCOPE_ALL ) return SYS_REFCURSOR   is
   my_cursor SYS_REFCURSOR;
  begin
    priv_get (pobjectnameorcode,puuid,pscope,my_cursor);
   RETURN my_cursor;
  end;
 
 
 /**
   get a json from a cache table
   here the cache use his the histoty table !
   return null if nothing in the cache (history dor demo)
 */
 procedure getJsonFromCache ( pobjectnameorcode in varchar2 ,puuid in raw,plastmodified in out  TIMESTAMP, pjsonobject in out NOCOPY clob  , pjsonHash  out varchar2 ) is
       l_request varchar2(1024);
       lobject P_OBJECTHANDLER.t_object;
  begin
 
 
   --get the object name based on the code (ex :PER = person
  P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectnameorcode,lobject);
 
  l_request:= 'select b.lastmodified,a.jsonobject,a.jsonHash
          from '||P_OBJECTHANDLER.getSqlSpecificTable(lobject,P_OBJECTHANDLER.SCOPE_HISTORY,P_OBJECTHANDLER.DEFAULT_HISTORY_TABLE)|| ' a ,'|| P_OBJECTHANDLER.getSqlFullTableName(lobject) || ' b
          where b.uuid=:puuid and
               a.uuid(+)=b.uuid and
               a.lastmodified(+)=b.lastmodified' ;
    if ( setdbms_output) then
      dbms_output.put_line('l_request='||l_request) ;
    end if; 
    execute immediate  l_request into plastmodified,pjsonobject,pjsonHash  using puuid ;
 
    exception
          when NO_DATA_FOUND then
              raise_application_error(-20013,'Object '||lobject.info.name||' with uuid '||puuid||' does not exist');
  end;
 
  
  
   /**
   save in the appropriate history table the json asscoated with
   an object, this procedure must be call each time an object has been modified
  
   NB : fire a EXCEPTION if the object record doesn't change since last history
        except if bForceSave is not equal 0
  */
  procedure  saveHistory (pobjectnameorcode in varchar2 , puuid in raw ,bForceSave in integer :=0 ) is
   l_request varchar2(32000);

   ljsonobjectsize integer;
   llastmodified   TIMESTAMP;
   lJsonHashPrevious varchar2(64);
   l_jsonobject t_json ;
   lobject P_OBJECTHANDLER.t_object;
  begin
 
      --get the object name based on the code (ex :PER = person
     P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectnameorcode,lobject);
 
 
    l_request:= 'select * from (select b.lastmodified,a.jsonHash 
          from '||P_OBJECTHANDLER.getSqlSpecificTable(lobject,P_OBJECTHANDLER.SCOPE_HISTORY,P_OBJECTHANDLER.DEFAULT_HISTORY_TABLE) || ' a ,'|| P_OBJECTHANDLER.getSqlFullTableName(lobject) || ' b 
          where b.uuid=:puuid  and
           a.uuid(+)=b.uuid
               order by a.lastmodified desc ) where rownum=1' ;
   
  
     execute immediate  l_request into llastmodified,lJsonHashPrevious  using puuid ;
  
     priv_getJson( lobject.info.name, puuid,P_OBJECTHANDLER.SCOPE_ALL,l_jsonobject);
  
    
    if (lJsonHashPrevious is null or lJsonHashPrevious<>l_jsonobject.jsonHash or bForceSave>0) then
        priv_saveJsonInHistory(lobject.info.name,puuid,llastmodified,l_jsonobject.jsonValue,l_jsonobject.jsonHash,bForceSave );
    else
        raise_application_error(-20109,'object '||lobject.info.name||' with uuid '||puuid|| ' does not change ! : '||l_jsonobject.jsonHash||'/'||lJsonHashPrevious);
    end if;
   
    DBMS_LOB.FREETEMPORARY(l_jsonobject.jsonValue);
   --  raise_application_error(-20109,'object '||lobject.info.name||' with uuid '||puuid|| ' does not change ! : '||l_jsonobject.jsonHash||'/'||lJsonHashPrevious);
     exception
          when NO_DATA_FOUND then
             raise_application_error(-20013,'Object '||lobject.info.name||' with uuid '||puuid||' does not exist');
   end;  
  
  
 
  
  /**
     Get a JSON Object based on its UUID
   **/ 
  function getJson(pobjectnameorcode in varchar2 , puuid in raw, puseCache integer  default 0,pscope varchar2 default P_OBJECTHANDLER.SCOPE_ALL) return clob  is
   pragma autonomous_transaction; 
 
     jsonHash varchar2(64);
     l_jsonobject t_json;
     l_lastmodified   TIMESTAMP;
     my_cursor SYS_REFCURSOR;
     lobject P_OBJECTHANDLER.t_object;
  begin
     
       --get the object name based on the code (ex :PER = person
       P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectnameorcode,lobject);
 
       --do we want to use cache ? (only for pscope=P_OBJECTHANDLER.SCOPE_ALL)
       if (puseCache!=0 and pscope= P_OBJECTHANDLER.SCOPE_ALL)then
            getJsonFromCache( lobject.info.name, puuid,l_lastmodified,l_jsonobject.jsonValue,l_jsonobject.jsonHash);
       end if;  
      
        --if not or if no object find in histirical, need to create JSON !
       if (nvl(dbms_lob.getlength(l_jsonobject.jsonValue),0)=0) then    
           priv_getJson( lobject.info.name,puuid,pscope,l_jsonobject);
       
        -- save the result in cache idf requested
        if (puseCache!=0 and l_lastmodified is not null  and pscope= P_OBJECTHANDLER.SCOPE_ALL)then
            priv_saveJsonInHistory ( lobject.info.name,puuid,l_lastmodified,l_jsonobject.jsonValue,l_jsonobject.jsonHash,1);
        end if;    
          
      end if;
       
         -- COMMIT mandatory !!!<--> autonomus transaction 
        commit;
        return l_jsonobject.jsonValue;
     
   end;
 
 
 
 
  /**
  do a lock on an object by updating root object
  based on UUID and lastmodified date
  */
  function dolock (pobjectname in varchar2 , puuid in raw, plastmodified  in timestamp default null) return timestamp
     is     
      lobjectowner varchar2(255);
      lrequest  varchar2(1024);
      llastmodified timestamp;
      lobject P_OBJECTHANDLER.t_object;
  begin
 
         --get the object name based on the code (ex :PER = person
         P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectname,lobject);

         llastmodified:=CURRENT_TIMESTAMP;
         lrequest:= 'update  '||P_OBJECTHANDLER.getSqlFullTableName(lobject) || ' 
            set lastmodified = :llastmodified
            where uuid = :puuid ' ;
               --raise_application_error(-20101,lrequest);
  
         if ( plastmodified is not null) then
              lrequest:= lrequest||' and lastmodified=:plastmodified';
               execute immediate  lrequest  using llastmodified,puuid ,plastmodified;
         else
               execute immediate  lrequest  using llastmodified,puuid ;
         end if;
           --raise_application_error(-20101,' rowcount=='||sql%rowcount);
         if (sql%rowcount=0) then
             raise_application_error(-20101,'Can''t lock object '||pobjectname||' using uuid '||puuid||' and lastmodified '||plastmodified);
          end if;
        return llastmodified;
     
      end ;
   
    /**
    check if an object exist
    return timestamp of lasmodifed if true
        null otherwhise
    */
    function  exist (pobjectname in varchar2 , puuid in raw ) return timestamp
    is
       llastmodified timestamp;
       lobjectowner varchar2(255);
       lrequest  varchar2(1024);
       lobject P_OBJECTHANDLER.t_object;
     begin
 
          --get the object name based on the code (ex :PER = person
         P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectname,lobject);

         lrequest:= 'select b.lastmodified 
            from '||P_OBJECTHANDLER.getSqlFullTableName(lobject)  || ' b
            where b.uuid=:puuid' ;
         execute immediate  lrequest into llastmodified  using puuid ;
        return llastmodified;
           exception
           when NO_DATA_FOUND then
              return null;
    end;
   
   
    function  existById (pobjectname in varchar2 , pid in varchar2 ) return raw
    is
       llastmodified timestamp;
       lobjectowner varchar2(255);
       lrequest  varchar2(1024);
       lobject P_OBJECTHANDLER.t_object;
       luuid raw(16);
      
       lscheme varchar2(255);
       lissuer varchar2(255);
       lid varchar2(255);
      
      
     begin
 
          --get the object name based on the code (ex :PER = person
         P_OBJECTHANDLER.getObject(p_objecthandler.TYPE_ENTITY,pobjectname,lobject);
         lscheme:=substr(pid,1,instr(pid,'.')-1);
         lissuer:=substr(pid,instr(pid,'.')+1,instr(pid,'.',1,2 )-1-instr(pid,'.'));
         lid    :=substr(pid,instr(pid,'.',1,2)+1);
       
         lrequest:= 'select distinct b.uuid 
            from '||P_OBJECTHANDLER.getSqlFullTableName(lobject)  || ' b , table (b.'||lobject.info.name||'ids) c
            where c.scheme = nvl( :scheme, c.scheme )
              and c.issuer = nvl( :issuer, c.issuer )
              and c.id = :id' ;
           
         execute immediate  lrequest into luuid  using lscheme,lissuer,lid ;
        return luuid;
           exception
           when NO_DATA_FOUND then
              return null;
           when others then
             DBMS_OUTPUT.PUT_LINE(lrequest);
             raise;
    end existById;
      /* store a link
     
      */
      procedure priv_storelink(puuid  in out raw, pobjectTypeCode in varchar2, pjo  in  OUT NOCOPY JSON_OBJECT_T ,peffectivestartdate in date, peffectiveenddate in date) is
    
        sqlCommand varchar2(32000);
     lretLink varchar2(32000);
        lroleCode varchar2(255);
        ltarget_objecttype varchar2(255);
        llinked_role varchar2(255);
        ltarget_id varchar2(255);
        ltargetlinked_role varchar2(255);
        ltarget_uuid raw(16);
        llinkuuid raw(16);
        leffectivestartdate date;
        leffectiveenddate date;
        pelement JSON_ELEMENT_T;
       
      begin
       
 
dbms_output.put_line ('Coucou 20 in priv_storelink ');                       
         if (pjo.is_Object) then
dbms_output.put_line ('Coucou 21 in priv_storelink ');                       
               llinkuuid:=sys_guid();
               lrolecode:=pjo.get_string('rolecode');              
               ltarget_objecttype:=pjo.get_string('target_objecttype');
               ltarget_uuid:=pjo.get_string('target_uuid');
               ltarget_id :=pjo.get_string('target_id');
              
               /**
               START DATE
               **/
dbms_output.put_line ('Coucou 22 in priv_storelink ');                       
               pelement:=pjo.get('effectivestartdate');
               if (pelement is not null and pelement.is_Date() ) then         
                 leffectivestartdate:=pelement.to_date();
               end if;
              
               if (leffectivestartdate is null and peffectivestartdate is not null) then
                  leffectivestartdate:= peffectivestartdate;
               end if;
           
dbms_output.put_line ('Coucou 23 in priv_storelink ');                       
               if ( leffectivestartdate is null) then
                  leffectivestartdate:=trunc(sysdate);
               end if;
               
dbms_output.put_line ('Coucou 24 in priv_storelink ');                       
              /**
                END DATE
              **/
               pelement:=pjo.get('effectiveenddate');         
              if (pelement is not null and pelement.is_Date() ) then         
                leffectiveenddate:=pelement.to_date();
              end if;
              
dbms_output.put_line ('Coucou 25 in priv_storelink ');                       
              if (leffectiveenddate is null and peffectiveenddate is not null) then
                  leffectiveenddate:= peffectiveenddate;
              end if;
             
              if ( leffectiveenddate is null) then
                  leffectiveenddate:=p_objecthandler.CONST_MAX_DATE;
               end if;
             
dbms_output.put_line ('Coucou 26 in priv_storelink ');                       
              
              if (ltarget_uuid is not null) then
                if (  p_entityservice.exist (ltarget_objecttype, ltarget_uuid )  is null) then
                  raise_application_error(-20104,'Link error : Entity '||ltarget_objecttype||'/'||ltarget_uuid||' does not exist');
                end if;
              elsif (ltarget_id is not null) then
                ltarget_uuid :=p_entityservice.existById (ltarget_objecttype, ltarget_id );
                 if ( ltarget_uuid is null) then
                    raise_application_error(-20105,'Link error : Entity (by id) '||ltarget_objecttype||'/'||ltarget_id||' does not exist');
                  end if;
               else
                   raise_application_error(-20106,'Link error : Must provided at least target uuid or target id to link object together');
               end if;
              
dbms_output.put_line ('Coucou 27 in priv_storelink ');                       
               lretLink := p_linkservice.storeLink ( lrolecode ,  pobjectTypeCode    , puuid              , ltarget_objecttype, ltarget_uuid    ,  1,  leffectivestartdate, leffectiveenddate);
             --   procedure   storeLink( puuid in out raw, pROLE in VARCHAR2,  pfromOt in varchar2, pfromUuid in RAW, pfromRole in varchar2, ptoOt varchar2    , ptoUuid in RAW,  ptoRole in varchar2,  pupdatePrevious in integer default 1, peffectivestartdate in DATE default SYSDATE, peffectiveenddate in date default CONST_MAX_DATE)
              -- storeLink( pobjectnameorcode in varchar2 , pfromOt in varchar2, pfromUuid in RAW,  ptoOt varchar2, ptoUuid in RAW,  pupdatePrevious in integer default 1, peffectivestartdate in DATE default SYSDATE, peffectiveenddate in date default CONST_MAX_DATE)
  
 
dbms_output.put_line ('Coucou 28 in priv_storelink ');                       
          end if;        
     
      end;
      /**
        Add a Value to the bind table used for SQL Command
        private , used by store Object procedure
      */
      procedure priv_addtoBind(ptableBind in out nocopy ttable_bind,  pvalue in out nocopy t_bind)
      is
        lvalue t_bind;
      begin
         ptableBind.extend(1);
         ptableBind(ptableBind.count):=pvalue;
      end;
     
      /**
         Add a RAW data (often exclusively the UUID Object) to the bind table
      **/  
      procedure priv_addRawToBind(ptableBind in out nocopy ttable_bind, pattributeName in varchar2, pvalue in varchar2)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_raw;
         lvalue.raw_value := pvalue;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
     
      /**
         Add a table od Alternative ID to the bind table
      **/  
      procedure priv_addIdsBind(ptableBind in out nocopy ttable_bind, pattributeName in varchar2, pids in out nocopy IDTABLE_T)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_ids;
         lvalue.ids_value := pids;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
      /**
         Add a date value to the bind table
      **/  
      procedure priv_addDateToBind(ptableBind in out nocopy ttable_bind, pattributeName in varchar2, pvalue in date)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_date;
         lvalue.date_value := pvalue;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
      /**
         Add a timestamp value to the bind table
      **/ 
      procedure priv_addTimestampToBind(ptableBind  in out nocopy ttable_bind, pattributeName in varchar2, pvalue in timestamp)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_timestamp;
         lvalue.timestamp_value := pvalue;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
      /**
         Add a string (varchar2) value to the bind table
      **/ 
      procedure priv_addVarcharToBind(ptableBind in out nocopy ttable_bind, pattributeName in varchar2, pvalue in varchar2)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_varchar2;
         lvalue.varchar2_value := pvalue;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
      /**
         Add a number (integer or real) value to the bind table
      **/ 
      procedure priv_addNumberToBind(ptableBind in out nocopy ttable_bind, pattributeName in varchar2, pvalue in number)
      is
        lvalue t_bind;
      begin
         lvalue.attributeName:=pattributeName;
         lvalue.kind := c_number;
         lvalue.number_value := pvalue;
         priv_addtoBind(ptableBind,lvalue);
      end;
     
   
      
        /**
           Reassign a varchar value to a id type  value
       **/
       function  priv_getIds( pjson in out nocopy JSON_ELEMENT_T  ) return IDTABLE_T
       is
      
         ljsonChild  JSON_ARRAY_T;
         ljsonObjectChild JSON_OBJECT_T;
         lid ID_T;
         lids IDTABLE_T;
        
       begin
       
         lids:=IDTABLE_T();      
       
         if (pjson is not null and pjson.is_Array()) then

              ljsonChild :=TREAT (pjson AS JSON_ARRAY_T);
              for r in 0..ljsonChild.get_size()-1 loop
                 ljsonObjectChild:=TREAT (ljsonChild.get(r) AS JSON_OBJECT_T);
                 lid:=ID_T(ljsonObjectChild.get_String('issuer'),ljsonObjectChild.get_String('scheme'),ljsonObjectChild.get_String('id'));
dbms_output.put_line ('Coucou 55 in priv_getIds : r=('||r||'), issuer=['||lid.issuer||'], scheme=['||lid.scheme||'], id=['||lid.id||']');           
           
                lids.extend(1);
                lids(lids.count) := lid;                           
           end loop;
          
         end if;
         return lids;
       end;
   
      /**
     
      PRIVATE FUNCTION FOR EXECUTING A SQL COMMAND WITH A BINDING LIST
      SQL CAN EITHER BE A SELECT / INSERT OR UPDATE COMMAND
      acccording the type of command...
     
      Select is only used for getting previous max version for a value object  -> return value if the max
      on insert/update --the return is number of record inserted or updated
      in case of an insert 0 is returned if a duplicate key has been fired.
      in case of an update 0 is return if no rows has been updated.
      **/
      function priv_do_sql( psqlCommand in varchar2, ptableBind in out nocopy ttable_bind , bfetch in boolean default false) return integer
      is
        icursor integer;
        retvalue integer;
--jea_int pls_integer ;
      begin
    
       if ( setdbms_output) then
             dbms_output.put_line ( 'SQL COMMAND :'||psqlCommand);
       end if;
       icursor := DBMS_SQL.OPEN_CURSOR;
      
       -- -----------------------
       -- 1 DO THE SQL PARSING
       -- -----------------------     
       DBMS_SQL.PARSE(icursor, psqlCommand, DBMS_SQL.NATIVE);
       
       -- Define fetching result into return value;
       -- WARN !!! must be a number ( ex select max...)
       if (bfetch) then
             DBMS_SQL.DEFINE_COLUMN(icursor, 1, retvalue);
       end if;
      
       -- -----------------------
       -- 2  DO the binding
       -- -----------------------      
setdbms_output := true ;
dbms_output.put_line ('Coucou 3 : ptableBind.count=['||ptableBind.count||']');
       for k  in 1..ptableBind.count loop
             -- binding is done only if bind variable ( ex ":lastname") is part of sql Command.. otherwise ythe bind is skipped
             if (instr(psqlCommand,':'||ptableBind(k).attributeName)) >0 then
dbms_output.put_line ('Coucou 4 : Dedans, ptableBind(k).attributeName=['|| ptableBind(k).attributeName||'], ['||ptableBind(k).kind||']');
            
                  -- acccording kind (type of variable) - do the right binding
                if (  ptableBind(k).kind = c_number) then
                    if ( setdbms_output) then
                       dbms_output.put_line (ptableBind(k).kind||' number / '||ptableBind(k).attributeName||'='||ptableBind(k).number_value)  ;     
                    end if;  
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).number_value);
                elsif (  ptableBind(k).kind = c_ids) then
                    if ( setdbms_output) then
                      dbms_output.put_line ('bind type '||ptableBind(k).kind||' ids / '||ptableBind(k).attributeName||'='||ptableBind(k).ids_value.count) ;
                    end if;
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).ids_value);
                elsif (   ptableBind(k).kind = c_timestamp ) then
                    if ( setdbms_output) then
                      dbms_output.put_line (ptableBind(k).kind||' timestamp / '||ptableBind(k).attributeName||'='||ptableBind(k).timestamp_value) ;
                    end if;
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).timestamp_value);
                elsif (  ptableBind(k).kind = c_date ) then
                    if ( setdbms_output) then
                      dbms_output.put_line (ptableBind(k).kind||' date / '||ptableBind(k).attributeName||'='||ptableBind(k).date_value) ;
                    end if;
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).date_value);
                elsif (  ptableBind(k).kind = c_raw ) then
                    if ( setdbms_output) then
                      dbms_output.put_line (ptableBind(k).kind||' raw / '||ptableBind(k).attributeName||'='||ptableBind(k).raw_value) ;
                    end if;
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).raw_value);
               else -- VARCHAR2 VALUES BY DEFAULT
                    if ( setdbms_output) then
                      dbms_output.put_line (ptableBind(k).kind||' varchar2 / '||ptableBind(k).attributeName||'='||ptableBind(k).varchar2_value) ;
                    end if;
                    SYS.DBMS_SQL.BIND_VARIABLE(icursor,ptableBind(k).attributeName,ptableBind(k).varchar2_value);
                end if;
             end if;
         end loop;
        
       -- ---------------------------
       -- 3  GO : DO EXECUTE THE SQL !
       -- ---------------------------    
        retvalue := DBMS_SQL.EXECUTE(icursor);
dbms_output.put_line ('Coucou 5 : Dedans, retvalue=['|| retvalue ||']');
       
       
       -- ----------------------------------------------------------------------------
       -- 4  FOR A SELECT COMMAND, FETCH 1 RECORD... and GET ONLY THE FIRST COLUMN !
       --    the column must be a number see previous DBMS_SQL.DEFINE_COLUMN definition
       -- -----------------------------------------------------------------------------
        if (bfetch) then     
dbms_output.put_line ('Coucou 6 : if (bfetch), DBMS_SQL.FETCH_ROWS(icursor) ');
          IF DBMS_SQL.FETCH_ROWS(icursor)>0 THEN
dbms_output.put_line ('Coucou 7 : if ()>0');
             DBMS_SQL.COLUMN_VALUE(icursor, 1, retvalue);
dbms_output.put_line ('Coucou 8 : retvalue=['||retvalue||']');
             if ( setdbms_output) then
                dbms_output.put_line ( 'fetch value   :'||retvalue);
             end if;
          end if;
        end if;
setdbms_output := false ;
       
       
       -- ----------------------------------------------------------------------------
       -- 5  CLOSE and RETUN
       -- -----------------------------------------------------------------------------
    
        DBMS_SQL.CLOSE_CURSOR(icursor);
dbms_output.put_line ('Coucou 9 avt sortie : Dedans, retvalue=['|| retvalue ||']');
        return retvalue;
       
        /*  exception
             -- duplicate key is catched tio return a 0 value
             when DUP_VAL_ON_INDEX THEN
                 DBMS_SQL.CLOSE_CURSOR(icursor);
                 return 0;*/
            
      end;
     
      function priv_existsIds ( pUuid in out nocopy raw
                              , pIds in out nocopy IDTABLE_T
                              , pEntity in P_OBJECTHANDLER.t_object
                              ) return boolean is
            /*
              objet : Trouver l'uuid rattaché à l'ids pour l'entité reçus en paramètre
              paramètres : 1. pUuid : in/out : recoit en sortie l'uuid trouvé
                          2. pIds : in/out : l'ids recherché pour trouver l'uuid
                          3. pEntity : la référence de l'entité cible de la recherche
              return : TRUE si l'uuid est trouvé
                      FALSE sinon
            */
            sqlString constant varchar2 (32000) 
                := 'select e.uuid  from ' || pEntity.info.sqlschema 
                || '.R_' || pEntity.info.name || ' e, table (e.' || pEntity.info.name 
                || 'ids) i where i.scheme = :scheme and i.issuer = :issuer and i.id = :id' ;
            curExistsIds sys_refcursor ;
            bRetValue boolean := false ;
      begin
            open curExistsIds for sqlString using pIds(1).scheme, pIds(1).issuer, pIds(1).id ;
            fetch curExistsIds into pUuid ;
                if (curExistsIds%found) then
                    bExistsUuid := true ;
                end if ;
            close curExistsIds ;
            return bExistsUuid ;
      end priv_existsIds;
     
       /**
           Reassign a varchar value to a timestamp value
       **/        
       procedure  priv_reassign(  pjson in out nocopy JSON_ELEMENT_T ,pvalue in out nocopy t_bind ,sqlType in varchar2)
       is
       begin
         if (pjson is not null) then
          if ( setdbms_output) then
            dbms_output.put_line ( 'reassign  value   :'||trim (both '"' from pjson.to_string)||' to '||sqltype);
          end if;
           if ( pjson.is_String() and substr(sqlType,1,3)='RAW') then
              pvalue.kind :=c_raw;
              pvalue.raw_value:=trim (both '"' from pjson.to_string);
           elsif (substr(sqlType,1,4)='DATE') then
              pvalue.kind :=c_date;
              pvalue.date_value:=to_date(trim (both '"' from pjson.to_string),DATETIMEFORMAT );
            elsif ( substr(sqltype,1,9)='TIMESTAMP') then
              pvalue.kind :=c_timestamp;
              pvalue.date_value:=to_date(trim (both '"' from pjson.to_string),TIMESTAMPFORMAT );
       
           elsif  (pjson.is_String()) then
              pvalue.kind :=c_varchar2;
              pvalue.varchar2_value:=trim (both '"' from pjson.to_string);
           elsif (pjson.is_Number()) then
              pvalue.kind :=c_number;
              pvalue.number_value:=pjson.to_number();
          elsif (pjson.is_Date() ) then
              pvalue.kind :=c_date;
              pvalue.date_value:=pjson.to_date();
          end if;   
       end if;
       if ( sqltype='IDTABLE_T') then
              pvalue.kind :=c_ids;
              pvalue.ids_value :=priv_getIds(pjson);
       end if;      
     end priv_reassign; 
    
     
      /**
       MAIN private procedure for inserting an objet
      
       DO THE UPDATE/INSERT OF A ENTITY BASED ON A JSON OBJECT
      
      **/
      function  priv_storeObject(  jo JSON_OBJECT_T, pobject in out nocopy P_OBJECTHANDLER.t_object, ptableBindParent in out nocopy ttable_bind, plevel integer default 0,   psaveHistory in boolean default true) return varchar2
      is
  
  
       ljson JSON_ELEMENT_T ;
       ljsonObjectChild  JSON_OBJECT_T ;
       ljsonChild  JSON_ARRAY_T;
       luuid  raw(16);
       bIsGeneratedUuid boolean := false ;
       ret varchar2(32000);
       retc varchar2(32000);
       lvalue t_bind;
       ltableBind ttable_bind;
       leffectivestartdate date;
       leffectiveenddate date;
       llastmodified timestamp;
       retnum integer;
       bvalueObject boolean;
       lobjecttable  p_objecthandler.t_objecttable;
   
       suffixEntity varchar2(255);
       lexist integer;
   
      
      
      begin
     
        ---------------------------------------------   
        -- 1 INITIALIZATION (SQL COMMAND)
        --------------------------------------------
        ret:='{'||chr(10);

        ltableBind:=ttable_bind();
        bvalueObject:=false;
        suffixEntity:=substr(pobject.info.name,instr(pobject.info.name,'_',-1)+1);
        dbms_output.put_line('Storing entity '||pobject.info.name||' ('||suffixEntity||')');
       
       
        ---------------------------------------------   
        -- 2 go through all object attribute (column)
        --------------------------------------------
        for i  in 1..pobject.attributes.count loop
                  
              ---------------------------------------------   
              -- 2.1 INIT BY COLUMN
              ---------------------------------------------
             -- initialization to null for current attribute value object
             lvalue.kind :=1;
             lvalue.date_value :=null;
             lvalue.timestamp_value :=null;
             lvalue.varchar2_value :=null;
             lvalue.number_value :=null;
             lvalue.raw_value :=null;
             lvalue.ids_value :=null;
        
             -- define current attribute
             lvalue.attributename:=pobject.attributes(i).attributeName;          
            
            
              ------------------------------------------------------------------------   
              -- 2.2 GET VALUE FROM JSON and reassign to current value according type
              ------------------------------------------------------------------------
         
             -- get value from JSON according path specification
             -- !!  THIS IS THE ONLY PLACE WHERE DATA IS RETRIEVED FROM CURRENT PARSED JSON !!
              ljson := jo.get(lvalue.attributename);
              if (ljson is not null ) then
                 DBMS_OUTPUT.PUT_LINE(lvalue.attributename||'='||ljson.to_string);
              else
                 DBMS_OUTPUT.PUT_LINE(lvalue.attributename||'= NULL');
             
              end if;
              priv_reassign(ljson,lvalue,pobject.attributes(i).sqltype);
            
             -- ---------------------------------------------------------------
             -- 2.3 SPECIFIC DATA ASSIGNEMENt REGARDING COLUMN NAME
             -- VERSION = MAX (VERSION) +1
             -- UUID= random uuid        
             -----------------------------------------------------------------
if (plevel = 0 and (bIsGeneratedUuid or luuid is null) and lvalue.kind = c_ids) then
    declare
        bIsAnIDTABLE_T boolean := false ;
        bExistsUuid boolean := false ;
        ruuid raw(16) ;
        bIsGeneratedUuid boolean := false ;
    begin
        bIsAnIDTABLE_T := true;
    
        if (priv_existsIds(pUuid => ruuid, pIds => lvalue.ids_value, pEntity => pobject)) then
          for ii in 1 .. ltableBind.count loop
             if(ltableBind(ii).kind = c_raw) then
               ret := replace(ret, luuid, ruuid) ;
               ltableBind(ii).raw_value := ruuid ;
             end if ;
          end loop ;
          luuid := ruuid ;
        end if ;
    end ;
end if ;
             
                
         
           
             -- uuid affectation if not done  ( only at rooit level not at subentity)     
             if ( pobject.attributes(i).attributename=p_objecthandler.ATTRIBUTE_NAME_UUID and plevel=0) then
                if (lvalue.raw_value is null)  then

                     lvalue.raw_value :=  sys_guid() ; 
                     bIsGeneratedUuid := true ;
                     lvalue.kind :=  c_raw;
                     if ( setdbms_output) then
                       dbms_output.PUT_LINE('generating new uuid ! :'|| lvalue.raw_value);
                     end if; 
                end if;
                luuid :=  lvalue.raw_value;
              
             -- if version is current ---  WORKING WITH VALUE OBJET RECORD ( EFFECTIVESTARTDATE + EFFECTIVEEND DATE)
             -- must define it with the max of previous
             elsif (  pobject.attributes(i).attributename =(p_objecthandler.ATTRIBUTE_NAME_VERSION||suffixEntity)) then
                 
                   --get max version+1
                   lvalue.number_value := priv_do_sql( p_entityhandler.getSqlBaseSelectMaxPrevious(pobject.info.name), ltableBind,true)+1;
                   lvalue.kind:=c_number;
                   bvalueObject:=true;
                
                       
                     
            -- efffective start date will be defined using the max VALUE ( infinite date) if not defined
            -- remember that it 's always better to define an artificial infinite value for performance rather than using a null value
             elsif ( pobject.attributes(i).attributename=p_objecthandler.ATTRIBUTE_NAME_EFFECTIVEENDDATE ) then 
                  if (lvalue.date_value is null) then
                      lvalue.kind :=c_date;
                      lvalue.date_value := p_objecthandler.CONST_MAX_DATE;
                  end if;
                   leffectiveenddate:=    lvalue.date_value;
              -- by usage  the statusccde is always defined as ACTIVE..
              -- we can't override this value.
              elsif ( pobject.attributes(i).attributename=p_objecthandler.ATTRIBUTE_NAME_STATUSCODE) then    
                    lvalue.kind := c_varchar2;
                    lvalue.varchar2_value := p_objecthandler.STATUS_ACTIVE;
              end if;
                
             -- ---------------------------------------------------------------
             --   2.5 WE MUST GET FROM PARENT DEFAULT VALUE IF STILL NOT ASSIGN
             --   AT tHIS STAGE
             -- ----------------------------------------------------------------
          
             -- if value still is null.. trying to get a default value from parent bind ( like uuid, datecreated, lnxxx, versionxxxx etc...)
             if (lvalue.kind = c_null or lvalue.kind is null) then
                -- over all parent value
               
                for k in 1..ptableBindParent.count loop
                   --find a value ? --> get it !               
                   if (ptableBindParent(k).attributeName=lvalue.attributeName ) then
                      lvalue := ptableBindParent(k);
                      continue ;
                   end if;
                end loop;
             end if;
                
            if (lvalue.attributename=p_objecthandler.ATTRIBUTE_NAME_EFFECTIVESTARTDATE) then
                if (  lvalue.date_value is null) then
                     lvalue.date_value :=trunc(sysdate);
                     lvalue.kind:=c_date;
                end if;
                leffectivestartdate:=    lvalue.date_value;       
            END IF;
               
             -- ---------------------------------------------------------------
             --   2.6 Prepare return value
             --          
             -- ------------------------------------------------------------------
  
            if (lvalue.kind!= c_null or pobject.attributes(i).PkNAME is  not null) then     
               
                  -- 2.6.1 prepare the return values of the storing by combining
                  -- the UUID + Lastmodified
                  if (lvalue.attributename=p_objecthandler.ATTRIBUTE_NAME_UUID) then
                      ret :=ret||'    "'||p_objecthandler.ATTRIBUTE_NAME_UUID||'":"'||lvalue.raw_value||'"';
                
                  elsif (lvalue.attributename=p_objecthandler.ATTRIBUTE_NAME_LASTMODIFIED) then
                      ret :=ret||','||chr(13)||'    "lastmodified":"'||lvalue.timestamp_value||'"';
                  end if;
                  
            end if;    
            priv_addtoBind(ltableBind,lvalue);
        end loop ;
      
      
        -------------------------------------------- ------------------------------------------------------------
        -- 3 finish to prepare SQL Command
        -- AND DO THE SQL !
        -- for root entity                                            --> insert and update if akready exist
        -- for child entity with Object Value mechanism (version) ,   --> update previous and insert new
        -----------------------------------------------------------------------------------------------------------
     
        lexist :=0;
        if ( not bvalueObject) then
          lexist := priv_do_sql( p_entityhandler.getSqlBaseSelectExist(pobject.info.name), ltableBind,true);
  
        end if;
       
        --- insert or update ...
        if ( lexist =0 or bvalueObject) then
             if (bvalueObject) then
                  --update previous version
                   retnum:=priv_do_sql( p_entityhandler.getSqlBaseUpdatePrevious(pobject.info.name), ltableBind);
             end if;
             retnum:= priv_do_sql( p_entityhandler.getSqlbaseInsert(pobject.info.name), ltableBind);
        else
             retnum:= priv_do_sql( p_entityhandler.getSqlbaseUpdate(pobject.info.name), ltableBind);
        end if;
       
         
        -------------------------------------------- ------------------------------------------------------------
        -- 4 NOW WE CAN GO TO CHILD ENTITY
        -----------------------------------------------------------------------------------------------------------
   
        --copy all bind values from parent to current
       /* for k  in 1..ptableBindParent.count loop
            ltableBind.extend(1);
            ltableBind(ltableBind.count):=ptableBindParent(k);
         end loop;
        */
        -- go through child subentity
        P_OBJECTHANDLER.getChildObject( pObject ,lobjecttable  ) ;
     
        for k in 1..lobjecttable.count loop
           
             ljson := jo.get(lobjecttable(k).info.name);        
             if (ljson is not null ) then
          
             --must be an array or an object
             if ( ljson.is_Object()) then              
                  retc := priv_storeObject(TREAT ( ljson  AS JSON_OBJECT_T), lobjecttable(k) ,ltableBind, plevel+1 );
           
             -- an array. is a list of object     
             elsif ( ljson.is_Array()) then
                    ljsonChild:=TREAT (ljson AS JSON_ARRAY_T);
                
                for r in 0..ljsonChild.get_size()-1 loop
                   
                    suffixEntity:=substr(lobjecttable(k).info.name,instr(lobjecttable(k).info.name,'_',-1)+1);
                    
                    -- provide lnXXXX default values (100, 200, 300,etc.)
                    priv_addNumbertoBind(ltableBind, p_objectHandler.ATTRIBUTE_NAME_LN||suffixEntity,(r+1)*100);
                   
                    -- go ! store the object
                    ljsonObjectChild:=TREAT (ljsonChild.get(r) AS JSON_OBJECT_T);                     
                    retc := priv_storeObject(ljsonObjectChild, lobjecttable(k),ltableBind,plevel+1);
                
                end loop;
            end if;
            end if;
        end loop;
dbms_output.put_line ('Coucou 12 : ');
       
        -------------------------------------------- ------------------------------------------------------------
        -- 5 let's do LINK
        -----------------------------------------------------------------------------------------------------------
        if(plevel=0) then
dbms_output.put_line ('Coucou 12.1 : ');
           
            ljson := jo.get(p_objectHandler.ATTRIBUTE_LINK);       
dbms_output.put_line ('Coucou 12.2 : ');
            if ( ljson is not null AND  ljson.is_Array() ) then
dbms_output.put_line ('Coucou 12.3 : ');
                ljsonChild:=TREAT (ljson AS JSON_ARRAY_T);
dbms_output.put_line ('Coucou 12.4 : ');
              for k in 0..ljsonChild.get_size()-1 loop    
                    -- go ! store the object
dbms_output.put_line ('Coucou 12.4.1 : ');
                    ljsonObjectChild:=TREAT (ljsonChild.get(k) AS JSON_OBJECT_T);                
dbms_output.put_line ('Coucou 12.4.2 : luuid=['||luuid||'],pobject.info.code=['||pobject.info.code||'], (ljsonObjectChild),leffectivestartdate=['||leffectivestartdate||'],leffectiveenddate=['||leffectiveenddate||']');
                    priv_storelink(luuid,pobject.info.code, ljsonObjectChild,leffectivestartdate,leffectiveenddate);
dbms_output.put_line ('Coucou 12.4.3 : ');
              end loop;
dbms_output.put_line ('Coucou 12.5 : ');
            end if;
dbms_output.put_line ('Coucou 12.6 : ');
        end if;
 
       
dbms_output.put_line ('Coucou 13 : ');
        -------------------------------------------- ------------------------------------------------------------
        -- 6 and FINALLY the HISTORY IS SAVED
        -----------------------------------------------------------------------------------------------------------
     
         if(plevel=0 and psaveHistory) then
           saveHistory ( pobject.info.name, luuid );
        end if;
        ret:=ret||chr(13)||'}';
dbms_output.put_line ('Coucou 14 : ret=['||ret||']');
        return ret;
      end priv_storeObject;  
       
    
    
      /**
      STORE AN OBJECT (or A COLLECTION of entity) IN THE DB
     
      Regardless uuid presence, the ENTITY wil be by default always created ... or updated if already exist
     
      Object type does not to be provided if it's collection
      */
      function  storeObject(jsonObject in out nocopy clob,pobjectnameorcode in varchar2  default null,psaveHistory in integer default 1) return clob
      is
  
       lretclob clob;
       lvalue t_bind;
     
        jo          JSON_OBJECT_T;
        je          JSON_ELEMENT_T;
        ja          JSON_ARRAY_T;
        keys        JSON_KEY_LIST;
        ljsonObjectChild JSON_OBJECT_T;
       
       lobject P_OBJECTHANDLER.t_object;
   
       llastmodified timestamp;
       ltableBind ttable_bind;
       lposSep integer;
       ltype varchar2(255);
       lname varchar2(255);
       lbSaveHisto boolean ;
      
      begin
     
     
        ------------------------              
         -- 1 Initialization
         -------------------------
        
       
         SAVEPOINT  start_store;
      
         ltableBind:=ttable_bind();
         if (psaveHistory>1) then
              lbSaveHisto:=true;
         else
               lbSaveHisto:=false;
         end if;
         -- clob return initialization
         dbms_lob.createtemporary(lretclob,false,dbms_lob.CALL);
        
         llastmodified:=CURRENT_TIMESTAMP; --createddate
        
          -- define created date  to lastmodified (but just the date without hour)
         priv_addDatetoBind(ltableBind,p_objectHandler.ATTRIBUTE_NAME_CREATEDDATE, llastmodified);
             -- define created date  to lastmodified (but just the date without hour)
         priv_addDatetoBind(ltableBind,'statusdate', llastmodified);
      
         -- define lastmodified (auto convert timestamp to char)
         priv_addTimestamptoBind(ltableBind,p_objectHandler.ATTRIBUTE_NAME_LASTMODIFIED, llastmodified);
        
         -- define effectivestartdate to lastmodified (but just the date without hour)
         priv_addDatetoBind(ltableBind,p_objectHandler.ATTRIBUTE_NAME_EFFECTIVESTARTDATE, trunc(llastmodified));
        
         -- define sa_label
         priv_addVarchartoBind(ltableBind,p_objectHandler.ATTRIBUTE_NAME_SA_LABEL, '');
        
        
           ------------------------              
         -- 2 Do the JSON PARSING
         -------------------------
         jo:=JSON_OBJECT_T.parse(jsonObject);
        
         keys := jo.get_keys;
         
        
         ---------------------------------------              
         -- 3 store entity .. according object !
         -- single or multiple
         -----------------------------------------
          FOR li IN 1..keys.COUNT LOOP
            
            lposSep:=instr(keys(li),'.');
          
            --only one single store
            if  (lposSep =0 and li=1) then    
                if ( pobjectnameorcode is null) then
                  raise_application_error(-20102,'Object Name (or code) must be provided for a single json Object');
                end if;
             
                --FIND THE HANDLER
                P_OBJECTHANDLER.getObject(p_objectHandler.TYPE_ENTITY,pobjectnameorcode,lobject);
               
                -- store the object
                dbms_lob.append(lretclob,priv_storeObject(jo,lobject ,ltableBind,0,lbSaveHisto));
                return lretclob;
                   
                   
            -- multiple object store (array)
            elsif lposSep!=0 then
              
               --split then name         
               je :=  jo.get(keys(li));
               ltype:=trim (both '"' from substr( keys(li),1,lposSep-1));
               lname:=trim (both '"' from substr( keys(li),lposSep+1));
     
dbms_output.put_line ('Coucou 20 : ');
               P_OBJECTHANDLER.getObject(ltype,lname,lobject);
dbms_output.put_line ('Coucou 21 : ');
               -- comma separation
                if (li >1) then
                  dbms_lob.append(lretclob,','||chr(13));
                else
                  dbms_lob.append(lretclob,'{');             
                end if; 
               dbms_lob.append(lretclob,keys(li));
               dbms_lob.append(lretclob,':[');
              
               for r in 0..je.get_size-1 loop
                      
                 -- comma separation
                  if (r >1) then
                    dbms_lob.append(lretclob,','||chr(13));
                  end if; 
                 
                  ja := TREAT (je AS JSON_ARRAY_T );
                  ljsonObjectChild:=TREAT (ja.get(r) AS JSON_OBJECT_T );
                      
                  -- insert the object    
                  dbms_lob.append(lretclob,priv_storeObject(ljsonObjectChild,lobject,ltableBind,0,lbSaveHisto ));
               end loop; 
               dbms_lob.append(lretclob,']');
             end if;
          end loop;  
          dbms_lob.append(lretclob,'}');
          return lretclob;
   
       
       
        exception
          when others then
             dbms_output.put_line('ERROR '||SQLCODE||' :'||SQLERRM);
             rollback to savepoint start_store;
             raise;
      end storeObject; 
 
      
END p_entityservice;
/
show errors
