/*
**/


create or replace
TYPE                  kv_t  AS OBJECT (

  key varchar2(255),
  value varchar2(4000),
  type varchar2(255),
  member function getDateTimeValue return date,
  member function getDateValue return date,
  member function getRealValue return real,
  member function getStringValue return varchar2,
  member procedure setDateTimeValue( pdate date),
  member procedure setDateValue( pdate date),
  member procedure setRealValue( preal real),
  member function isMember( pvalue  varchar2 ) return boolean ,
  constructor function kv_t(pkey varchar2, pvalue varchar2)
        RETURN SELF AS RESULT
        DETERMINISTIC ,
  constructor function kv_t(pkey varchar2, pvalue date, pisTime boolean)
        RETURN SELF AS RESULT
        DETERMINISTIC ,
 constructor function kv_t(pkey varchar2, pvalue real)
        RETURN SELF AS RESULT
        DETERMINISTIC
)
;

create or replace
TYPE body                  kv_t   is

 member function getStringValue return varchar2 is
  begin
    return self.value;
  end;


  member function getDateValue return date is
  begin
    if (self.type='date') then
       return to_date(self.value,'DD/MM/YYYY');
    end if;
    return null;
  end;

  member function getDateTimeValue return date is
  begin
    if (self.type='datetime') then
       return to_date(self.value,'DD/MM/YYYY HH24:MI:SS');
    end if;
    return null;
  end;

  member function getRealValue return real is
  begin
  if (self.type='real') then
     return TO_NUMBER(self.value);
  end if;
  return null;
  end;

  member procedure setDateValue( pdate date) is
  begin
    self.value:=to_char(pDate,'DD/MM/YYYY');
    self.type:='date';
  end;

  member procedure setDateTimeValue( pdate date) is
  begin
    self.value:=to_char(pDate,'DD/MM/YYYY HH24:MI:SS');
    self.type:='date';
  end;

  member procedure setRealValue( preal real) is
  begin
    self.value:=to_char(preal);
    self.type:='real';
  end;

  member function isMember( pvalue  varchar2 ) return boolean is
  begin
    if (pvalue is not null and self.value is not null and self.type='string') then
         return regexp_substr (self.value, pvalue||'[$,]' ,1,1) is not null;
    end if;
    return false;

  end;

  constructor function kv_t(pkey varchar2, pvalue varchar2)  RETURN SELF AS RESULT   DETERMINISTIC IS
  begin
    self.key:=pkey;
    self.value:=pvalue;
    self.type:='string';
    return ;
  end;
  constructor function kv_t(pkey varchar2, pvalue date, pisTime boolean)   RETURN SELF AS RESULT   DETERMINISTIC IS
  begin
    self.key:=pkey;
    self.value:=pvalue;
    if (pisTime) then
        self.setDateTimeValue(pvalue);
    else
        self.setDateValue(pvalue);
    end if;
     return ;
  end;
 constructor function kv_t(pkey varchar2, pvalue real)  RETURN SELF AS RESULT   DETERMINISTIC IS
  begin
    self.key:=pkey;
    self.setRealValue(pvalue);
     return ;
  end;

end;

create or replace
TYPE                  kvTable_t is TABLE OF own_07755_common.kv_t
;
