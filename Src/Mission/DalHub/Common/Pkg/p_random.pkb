/*
**/
create or replace
PACKAGE body p_random
IS
  FUNCTION getYesOrNo(
      pvalue IN INTEGER)
    RETURN VARCHAR2 is
    BEGIN
      IF(
          pvalue=1) THEN
        RETURN 'Y';
      END IF;
      RETURN 'N';
    END;
    FUNCTION priv_getString(
        pnbpair INTEGER DEFAULT 4)
      RETURN VARCHAR2
    IS
      pair INTEGER;
      name VARCHAR2(255);
    BEGIN
      name := '';
      FOR nb IN 1..pnbpair
      LOOP
        pair := 2 * floor(SYS.DBMS_RANDOM.VALUE(0,1) * (LENGTH(namest) / 2));
        name := name||SUBSTR(namest,pair, 2);
      END LOOP;
      name := REPLACE(name,'.', '');
      RETURN name;
    END;
  FUNCTION getFirstName(
      pnbpair INTEGER DEFAULT 4)
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN priv_getString( pnbpair);
  END ;
  FUNCTION getName(
      pnbpair INTEGER DEFAULT 5)
    RETURN VARCHAR2
  IS
  BEGIN
    RETURN priv_getString( pnbpair);
  END ;
  FUNCTION getBirthDate(
      pminAge IN INTEGER DEFAULT 18,
      pmaxAge IN INTEGER DEFAULT 90)
    RETURN DATE
  IS
  BEGIN
    RETURN TRUNC( sysdate - TRUNC( dbms_random.value (pminAge*365, pmaxAge*365)));
  END;
  FUNCTION getAmount(
      pmin IN REAL DEFAULT 0,
      pmax IN REAL DEFAULT 100000)
    RETURN REAL
  IS
  BEGIN
    RETURN TRUNC( dbms_random.value (pmin, pmax)*100)/100;
  END;
  PROCEDURE getCreditCard(
      pissuer OUT VARCHAR2,
      pcarnumber OUT VARCHAR2,
      pcardSN OUT VARCHAR2 ,
      pcardExpiredate OUT DATE )
  IS
    lcardissuer INTEGER;
  BEGIN
    pcardExpiredate    := TRUNC( sysdate- TRUNC(dbms_random.value (100,400)));
    lcardissuer        := TRUNC(dbms_random.value(1,100));
    pcardSN            := TO_CHAR(TRUNC(dbms_random.value(1,999),'099'));
    IF ( lcardissuer   <=60) THEN
      pissuer          :='Visa';
      pcarnumber       :='4'|| TO_CHAR(TRUNC(dbms_random.value(1,9999999999999999)),'099G9999G99999G9999');
    elsif ( lcardissuer<=80) THEN
      pissuer          :='MasterCard';
      pcarnumber       :='55'|| TO_CHAR(TRUNC(dbms_random.value(1,999999999999999)),'09G9999G99999G9999');
    elsif ( lcardissuer<=90) THEN
      pissuer          :='American Express';
      pcarnumber       :='34'|| TO_CHAR(TRUNC(dbms_random.value(1,99999999999999)),'09G9999G99999G999');
    elsif ( lcardissuer<=98) THEN
      pissuer          :='Diner''s Club';
      pcarnumber       :='3'||TO_CHAR(TRUNC(dbms_random.value(1,99999999999999)),'099G9999G99999G99');
    ELSE
      pissuer   :='Discover';
      pcarnumber:='6'|| TO_CHAR(TRUNC(dbms_random.value(1,9999999999999999)),'099G9999G99999G9999');
    END IF;
    pcarnumber:=REPLACE(pcarnumber,' ','-');
  END;

END;
/
show errors

