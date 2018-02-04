DECLARE
  l_sysguid varchar2(32);
  uuid      varchar2(36);
BEGIN
  SELECT LOWER(SYS_GUID()) into l_sysguid FROM dual;
  SELECT
    substr(l_sysguid, 1, 8)  || '-' ||
    substr(l_sysguid, 9, 4)  || '-' ||
    substr(l_sysguid, 10, 4) || '-' ||
    substr(l_sysguid, 15, 4) || '-' ||
    substr(l_sysguid, 20, 12)
  INTO uuid FROM dual;
  
  dbms_output.put_line('l_sysguid = ' || l_sysguid) ;
  dbms_output.put_line('uuid = ' || uuid) ;
END;


select regexp_replace(
    to_char(
        DBMS_RANDOM.value(0, power(2, 128)-1),
        'FM0xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'),
    '([a-f0-9]{8})([a-f0-9]{4})([a-f0-9]{4})([a-f0-9]{4})([a-f0-9]{12})',
    '\1-\2-\3-\4-\5') from DUAL;
    
create or replace FUNCTION RANDOM_GUID
    RETURN VARCHAR2 IS

    RNG    NUMBER;
    N      BINARY_INTEGER;
    CCS    VARCHAR2 (128);
    XSTR   VARCHAR2 (4000) := NULL;
  BEGIN
    CCS := '0123456789' || 'ABCDEF';
    RNG := 15;

    FOR I IN 1 .. 32 LOOP
      N := TRUNC (RNG * DBMS_RANDOM.VALUE) + 1;
      XSTR := XSTR || SUBSTR (CCS, N, 1);
    END LOOP;

    RETURN SUBSTR(XSTR, 1, 4) || '-' ||
        SUBSTR(XSTR, 5, 4)        || '-' ||
        SUBSTR(XSTR, 9, 4)        || '-' ||
        SUBSTR(XSTR, 13,4)        || '-' ||
        SUBSTR(XSTR, 17,4)        || '-' ||
        SUBSTR(XSTR, 21,4)        || '-' ||
        SUBSTR(XSTR, 24,4)        || '-' ||
        SUBSTR(XSTR, 28,4);
END RANDOM_GUID;

SET SERVEROUTPUT ON
BEGIN
FOR indx IN 1 .. 5
LOOP
DBMS_OUTPUT.put_line ( SYS_GUID );
END LOOP;
END;
/

CREATE OR REPLACE PACKAGE guid_pkg
IS
    SUBTYPE guid_t IS RAW (16);
    SUBTYPE formatted_guid_t IS VARCHAR2 (38);
    -- Example: {34DC3EA7-21E4-4C8A-BAA1-7C2F21911524}
    c_mask CONSTANT formatted_guid_t
    := '{________-____-____-____-____________}';
    FUNCTION is_formatted_guid (string_in IN VARCHAR2) RETURN BOOLEAN;
    FUNCTION formatted_guid (guid_in IN VARCHAR2) RETURN formatted_guid_t;
    FUNCTION formatted_guid RETURN formatted_guid_t;
END ;guid_pkg

CREATE OR REPLACE PACKAGE BODY guid_pkg
IS
    FUNCTION is_formatted_guid (string_in IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
       RETURN string_in LIKE c_mask;
    END is_formatted_guid;

    FUNCTION formatted_guid (guid_in IN VARCHAR2) RETURN formatted_guid_t IS
    BEGIN
        -- If not already in the 8-4-4-4-rest format, then make it so.
        IF is_formatted_guid (guid_in) THEN
            RETURN guid_in;
        -- Is it only missing those squiggly brackets?
        ELSIF is_formatted_guid ('{' || guid_in || '}') THEN
            RETURN formatted_guid ('{' || guid_in || '}');
        ELSE
            RETURN '{'
            || SUBSTR (guid_in, 1, 8)
            || '-'
            || SUBSTR (guid_in, 9, 4)
            || '-'
            || SUBSTR (guid_in, 13, 4)
            || '-'
            || SUBSTR (guid_in, 17, 4)
            || '-'
            || SUBSTR (guid_in, 21)
            || '}';
        END IF;
    END formatted_guid;

    FUNCTION formatted_guid RETURN formatted_guid_t IS
    BEGIN
        RETURN formatted_guid (SYS_GUID);
    END formatted_guid;
END guid_pkg;
/
