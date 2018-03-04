/*
**/


create or replace
package body p_securityservice is


  procedure setCurrentContextUndefined(pcontext in varchar2)
  is
  begin
      setCurrentContext(pcontext,'undefined','undefined','undefined','P','','');
  end setCurrentContextUndefined;

  procedure setCurrentContext(pcontext in varchar2, papplication IN VARCHAR2, pfonction IN VARCHAR2, puser IN VARCHAR2, plevel IN varchar2, pcompartment in varchar2,pgroup IN VARCHAR2)
  is
  BEGIN
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_APPLICATION, papplication);
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_FONCTION, pfonction);
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_USER, puser);
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_SECURITY_LEVEL, plevel);
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_SECURITY_COMPARTMENT, pcompartment);
      DBMS_SESSION.SET_CONTEXT(pcontext, DATAHUB_SECURITY_GROUP, pgroup);
      --SA_SESSION.set_access_profile('DH_POLICY', puser);
      --SA_SESSION.SET_LABEL('DH_POLICY',nvl(plevel,'')||':'||NVL(pcompartment,'')||':'||nvl(pgroup,''));


  END setCurrentContext;

  procedure clearCurrentContext(pcontext in varchar2)
  is
  BEGIN
      --DBMS_SESSION.CLEAR_CONTEXT (pcontext);
      NULL;
  END clearCurrentContext;


  function getCurrentCompartment(pcontext in varchar2) return varchar2
  is
  begin
    return NVL(SYS_CONTEXT(pcontext, DATAHUB_SECURITY_COMPARTMENT),'undefined');
  end getCurrentCompartment;


  function hasCompartment( pcontext in varchar2,pcompartment in varchar2 ) return integer
  is
      begin
        if (instr(getCurrentCompartment(pcontext),pcompartment)>0) then
          return 1;
        end if;
        return 0;
      end hasCompartment;
end p_securityservice;
/

show errors
