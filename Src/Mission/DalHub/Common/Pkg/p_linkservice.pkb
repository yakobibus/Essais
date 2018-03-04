/*
**/


create or replace
PACKAGE BODY p_linkservice  IS

   procedure priv_storeLink( puuid in out RAW, pROLE in VARCHAR2,  pfromOt in varchar2, pfromUuid in RAW, pfromRole in varchar2, ptoOt varchar2, ptoUuid in RAW,  ptoRole in varchar2,  pupdatePrevious in integer default 1, peffectivestartdate in DATE default SYSDATE, peffectiveenddate in date default CONST_MAX_DATE)

    is

    begin
       if (puuid is null) then
            puuid:=sys_guid();
       end if;
       --update previous one
       if ( pupdatePrevious=1) then
         update R_LINKER C
           set effectiveenddate = peffectivestartdate
              where c.effectiveenddate=CONST_MAX_DATE
               and c.rolecode=prole
               and C.uuid in     (select UUID from R_LINKER_DETAIL A where
                     A.LINKED_OBJECTTYPE=pfromOt
                     and a.LINKED_UUID=pfromUuid
                     and a.LINKED_ROLEcode=pfromRole);
       end if;


       -- insert the new link
        insert into R_LINKER (UUID,ROLEcode,STATUScode,EFFECTIVESTARTDATE,EFFECTIVEENDDATE)
              values  (puuid,pROLE,'A',peffectivestartdate,peffectiveenddate);

        insert into R_LINKER_DETAIL (UUID,LNdetail,LINKED_UUID,LINKED_OBJECTTYPE,LINKED_ROLEcode)
              values  (puuid,1,pfromUuid,pfromOt,pfromRole);

        insert into R_LINKER_DETAIL (UUID,LNdetail,LINKED_UUID,LINKED_OBJECTTYPE,LINKED_ROLEcode)
              values  (puuid,2,ptoUuid,ptoOt,ptoRole);

    end;


 function storeLink(   pobjectnameorcode in varchar2 , pfromOt in varchar2, pfromUuid in RAW,  ptoOt varchar2, ptoUuid in RAW,  pupdatePrevious in integer default 1, peffectivestartdate in DATE default SYSDATE, peffectiveenddate in date default CONST_MAX_DATE) return varchar2

    is

      lobject P_OBJECTHANDLER.t_object;
      lAllowedfromObjectType varchar2(255);
      lAllowedToOnjectType varchar2(255);
      lRolefromObjectType  varchar2(32);
      lRoleToOnjectType  varchar2(32);
       bInversedLink boolean;
       luuid RAW(16);
       ret varchar2(32000);
       lobjectfrom P_OBJECTHANDLER.t_object;
      lobjectto  P_OBJECTHANDLER.t_object;
    begin

       ret:='{';
       bInversedLink:=false;
        --get the object name based on the code (ex :INS insured)
       P_OBJECTHANDLER.getObject(P_OBJECTHANDLER.TYPE_LINK,pobjectnameorcode,lobject);
       P_OBJECTHANDLER.getObject(P_OBJECTHANDLER.TYPE_ENTITY,pfromOt,lobjectfrom);

       P_OBJECTHANDLER.getObject(P_OBJECTHANDLER.TYPE_ENTITY,ptoOt,lobjectto);


       lAllowedfromObjectType := P_OBJECTHANDLER.getParameter(lobject,'from_entity','');
       lAllowedToOnjectType :=P_OBJECTHANDLER.getParameter(lobject,'to_entity','');
      if ( instr(lAllowedfromObjectType, lobjectfrom.info.code)=0) then
           if (instr(lAllowedfromObjectType, lobjectto.info.code)=0) then
              raise_application_error('-20201','SOURCE Object type object "'||pfromOt||'" is incorrect for link "'||pobjectnameorcode||'" allowed SOURCE type object is "'|| lAllowedfromObjectType||'"');
           end if;
           bInversedLink:=true;
       end if;

       if (not  bInversedLink) then
         if (  instr(lAllowedToOnjectType, lobjectto.info.code)=0) then
            raise_application_error('-20202','TARGET Object  type object "'||ptoOt||'" is incorrect for link "'||pobjectnameorcode||'" allowed TARGET type object is "'|| lAllowedToOnjectType||'"');
         end if;
       else
        if (  instr(lAllowedToOnjectType, lobjectfrom.info.code)=0) then
            raise_application_error('-20202','TARGET Object  type object "'||ptoOt||'" is incorrect for link "'||pobjectnameorcode||'" allowed TARGET type object is "'|| lAllowedToOnjectType||'"');
         end if;
      end if;
       lRolefromObjectType := P_OBJECTHANDLER.getParameter(lobject,'from_role','');
       lRoleToOnjectType :=P_OBJECTHANDLER.getParameter(lobject,'to_role','');
       if (bInversedLink) then
         priv_storeLink     ( luuid,lobject.info.code,lobjectto.info.code,ptoUuid,lRolefromObjectType,lobjectfrom.info.code,pfromUuid,lRoleToOnjectType,pupdatePrevious,peffectivestartdate,peffectiveenddate);
       else
         priv_storeLink     ( luuid,lobject.info.code,lobjectfrom.info.code,pfromUuid,lRolefromObjectType,lobjectto.info.code,ptoUuid,lRoleToOnjectType,pupdatePrevious,peffectivestartdate,peffectiveenddate);
       end if;

   ret:=ret||' "uuid":"'||luuid||'"';
   ret:=ret||'}';
   return ret;
     end;
 end;
/
show errors
