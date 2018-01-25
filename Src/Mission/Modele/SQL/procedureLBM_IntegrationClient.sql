  -----------------------------------------------------------------
  -- Procedure de purges des tables temporaires pour l'integration
  -----------------------------------------------------------------
  PROCEDURE InitTableTempo IS
    Type Tbl_VC2_200 is table of VARCHAR2(30);
    Init_Deleted_Table_List constant Tbl_VC2_200 := Tbl_VC2_200('LBM_INT_CLIENTS'
                                                               ,'LBM_CLIENTS_INTERFACE');
  
    Resultat VARCHAR(200);
  
    --pragma autonomous_transaction;
  
  BEGIN
    For curr_index in Init_Deleted_Table_List.first .. Init_Deleted_Table_List.last Loop
      BEGIN
        Resultat := 'DELETE FROM ' || Init_Deleted_Table_List(curr_index);
        EXECUTE IMMEDIATE Resultat;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de la purge de la table ' ||
                      Init_Deleted_Table_List(curr_index) || CHR(13) || SQLERRM(SQLCODE));
      END;
    End Loop;
    --- ----
    /*
    BEGIN
    
      Resultat := 'DELETE FROM LBM_INT_CLIENTS';
      EXECUTE IMMEDIATE Resultat;
    
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1, LeCodeMsg, 'Une erreur s''est produite lors de la purge de la table LBM_INT_CLIENTS' || CHR(13) || SQLERRM(SQLCODE));
    END;
    */
  
    /* BEGIN
    Resultat :='TRUNCATE TABLE  LBM_INT_CLIENTS_REJETS REUSE STORAGE';
    EXECUTE IMMEDIATE Resultat;
    
    EXCEPTION
    WHEN OTHERS THEN
    ROLLBACK;
    Ajouter_Log(1, LeCodeMsg, 'Une erreur s''est produite lors de la purge de la table LBM_INT_CLIENTS_REJETS' ||CHR(13)||
    SQLERRM(SQLCODE));
    END;
    */
    -- Ajout ERI le 29/01/2015
    /*
    BEGIN
    
      Resultat := 'DELETE FROM LBM_CLIENTS_INTERFACE';
      EXECUTE IMMEDIATE Resultat;
    
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de la purge de la table LBM_CLIENTS_INTERFACE' ||
                    CHR(13) || SQLERRM(SQLCODE));
    END;
    */
    --Fin Ajout ERI le 29/01/2015
  
    COMMIT;
  
  END InitTableTempo;
  
  /******************************************************
   * Procedure  LBM_INTEGRATIONCLIENT                   *
   * Lancement des integrations                         *
   *  - Clients                                         *
   *  - Adresses                                        *
   *  - Stats                                           *
   *  - cartes                                          *
   *  - Client-gpe-magasin                              *
   *                                                    *
   * ERI "saisir date de mise en production" Creation   *
   *                                                    *
   ******************************************************/
  
  PROCEDURE LBM_IntegrationClient IS
    LeCodeMsg         Log_Traitements.CodeMsg%TYPE;
    LockPresent       BOOLEAN;
    NbSecondes        NUMBER(4);
    NbSecondesTimeOut NUMBER(4);
    LeNbErreurs       NUMBER(10);
    ToujoursOk        BOOLEAN;
    Existe            NUMBER(1);
    --Modif ERI le 21/05/2014
    ErrorCode NUMBER;
    --Fin Modif ERI le 21/05/2014
    --FTR le 24/09/2016
    ErrorCodeDesc VARCHAR2(500);
    --Fin FTR
  
  BEGIN
    LeCodeMsg := 'BIZ-0014';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration des clients');
  
    -- Recuperation du timeout
    BEGIN
    
      NbSecondesTimeOut := 10;
      --SELECT LeTimeOut INTO NbSecondesTimeOut FROM LBM_PARAM_INTERFACE;
    EXCEPTION
      WHEN OTHERS THEN
        NbSecondesTimeOut := 600; -- TimeOut = 10 minutes par defaut
    END;
  
    NbSecondes := 0;
    ToujoursOk := TRUE;
  
    ---------------------------------------------------------
    -- 1.) Poser un lock ; en cas d'echec apres timeout, exit
    ---------------------------------------------------------
  
    WHILE TRUE LOOP
      BEGIN
        SELECT 1 INTO Existe FROM TABLE_LOCK WHERE NomTable = 'LBM_INTEGRATION_CLIENT';
        LockPresent := TRUE;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LockPresent := FALSE;
      END;
      IF LockPresent THEN
        dbms_Lock.Sleep(1); -- tempo de 1 seconde
        NbSecondes := NbSecondes + 1;
        IF NbSecondes >= NbSecondesTimeOut THEN
          ToujoursOk := FALSE;
        END IF;
      END IF;
      EXIT WHEN(NOT LockPresent) OR(NOT ToujoursOk);
    END LOOP;
  
    IF (NOT LockPresent)
       AND (ToujoursOk) THEN
      BEGIN
        INSERT INTO TABLE_LOCK
          (NOMTABLE
          ,ENREGISTREMENT
          ,NUMPOSTE
          ,CODEUTILISATEUR)
        VALUES
          ('LBM_INTEGRATION_CLIENT'
          ,'1'
          ,to_char(sysdate
                  ,'DDMMHH24MISS')
          ,-1);
        ToujoursOk := TRUE;
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          ToujoursOk := FALSE;
          --FTR le 21/05/2014
        WHEN OTHERS THEN
          ToujoursOk := FALSE;
          --Fin FTR le 21/05/2014
      END;
    ELSE
      ToujoursOk := FALSE;
    END IF;
  
    -- Echec apres timeout, exit, sinon on continue
    IF Not ToujoursOk THEN
      Ajouter_Log(1, LeCodeMsg, 'Impossible d''inserer un lock (TimeOut).');
      -- Lock Ok
    ELSE
      ---------------------------------------------------------
      -- 2.)  recuperer un nouveau codetraitement (id_batch),
      ---------------------------------------------------------
      BEGIN
        SELECT NVL(CodeMsgLog, 0) + 1
          INTO LeCodeTraitementBizTalk
          FROM LBM_PARAM_INTERFACE;
        LeCodeTraitementBizTalkNegatif := -LeCodeTraitementBizTalk;
        UPDATE LBM_PARAM_INTERFACE SET CodeMsgLog = LeCodeTraitementBizTalk;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LeCodeTraitementBizTalk := -1;
      END;
    
      ---------------------------------------------------------
      -- 3.)  mettre a jour LBM_MESSAGE_ID si id_batch est null (nouveaux clients)
      --        ou id_batch est negatif (si plantage trt precedent) avec - nouveau code traitement,
      ---------------------------------------------------------
      UPDATE LBM_MESSAGE_ID
         SET ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       WHERE ((NVL(ID_BATCH_STL, 0) = 0) OR (ID_BATCH_STL < 0))
         AND TYPEFLUX = 'CLI';
    
      ---------------------------------------------------------
      -- 4.)  vider (truncate) toutes les tables LBM_INT_xxx
      ---------------------------------------------------------
      InitTableTempo;
    
      BEGIN
        -- Maj table de suivi des batch avec nb erreurs a 0
        -- voir si maj_suivi ne fait pas un commit car msgid update alors que pb ds lbm_article !!
        MAJ_SUIVI_BATCH_INTEGRATION(LeCodeTraitementBizTalk
                                   ,NULL /*DateFin*/
                                   ,0 /*NbErreur*/
                                   ,SYSDATE
                                   ,'TABLE_INT_CLI');
        ---------------------------------------------------------
        -- 5.)  Integration dans les tables INT_xxx
        ---------------------------------------------------------
      
        PRC_LBM_CLIENT;
      
        -- 1er commit
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            ROLLBACK;
          
            UPDATE LBM_MESSAGE_ID
               SET ID_BATCH_STL = NULL
             WHERE ID_BATCH_STL < 0
               AND TYPEFLUX = 'CLI';
            COMMIT;
            IF INSTR(SQLERRM(SQLCODE)
                    ,'ORA-00060') > 0 THEN
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Erreur lors de PK_LBM.INTEGRATION_CLIENT.' || CHR(13) ||
                          SQLERRM(SQLCODE));
            
            ELSE
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Erreur lors de PK_LBM.INTEGRATION_CLIENT.' || CHR(13) ||
                          SQLERRM(SQLCODE));
            
              --BEGIN
              --LBM_SEND_MAIL_LOG('OlapAdm@lebonmarche.fr','eringuet@lebonmarche.fr','ALERTE:Erreur lors du lancement du package PK_LBM.INTEGRATION_CLIENT',SQLERRM(SQLCODE));
              --EXCEPTION WHEN OTHERS THEN
              -- Ajouter_Log(1, LeCodeMsg, 'Erreur lors de PK_LBM.INTEGRATION_CLIENT. ERREUR ENVOI DU MAIL.');
              --END;
            
            END IF;
          
            ToujoursOk := FALSE;
          
            IF INSTR(SQLERRM(SQLCODE)
                    ,'ORA-00060') > 0
               OR INSTR(SQLERRM(SQLCODE)
                       ,'ORA-01410') > 0
               OR INSTR(SQLERRM(SQLCODE)
                       ,'ORA-01013') > 0
               OR INSTR(SQLERRM(SQLCODE)
                       ,'ORA-04030') > 0 THEN
              DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'LBM_INTEGRATION_CLIENT';
              DELETE FROM LBM_CLIENTS_INTERFACE;
            END IF;
          
          END;
      END;
    
      ---------------------------------------------------------
      -- 6.)  Integration dans les tables de STORELAND
      ---------------------------------------------------------
      IF ToujoursOk THEN
        BEGIN
          -- Maj batch avec tables en cours de trt = TABLE_STL
          MAJ_SUIVI_BATCH_INTEGRATION(LeCodeTraitementBizTalk
                                     ,NULL
                                     ,0
                                     ,SYSDATE
                                     ,'TABLE_STL_CLI');
        
          PK_INterface.INIT_CODETRAITEMENT(LeCodeTraitementBizTalk);
          PK_INterface.INTEGRATION_CLIENT_LBM;
          --2eme commit
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            BEGIN
              ROLLBACK;
            
              UPDATE LBM_MESSAGE_ID
                 SET ID_BATCH_STL = NULL
               WHERE ID_BATCH_STL < 0
                 AND TYPEFLUX = 'CLI';
              COMMIT;
            
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Erreur lors de PK_Interface.INTEGRATION_CLIENT_LBM.' ||
                          CHR(13) || SQLERRM(SQLCODE));
            
              IF INSTR(SQLERRM(SQLCODE)
                      ,'ORA-00060') > 0
                 OR INSTR(SQLERRM(SQLCODE)
                         ,'ORA-01410') > 0
                 OR INSTR(SQLERRM(SQLCODE)
                         ,'ORA-01013') > 0
                 OR INSTR(SQLERRM(SQLCODE)
                         ,'ORA-04030') > 0 THEN
                DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'LBM_INTEGRATION_CLIENT';
                DELETE FROM LBM_CLIENTS_INTERFACE;
                DELETE FROM TABLE_LOCK
                 WHERE NOMTABLE = 'PK_INTERFACE'
                   AND ENREGISTREMENT = 'INTEGRATION CLIENT';
              END IF;
            
              --  BEGIN
              --  LBM_SEND_MAIL_LOG('OlapAdm@lebonmarche.fr','ftrouiller@lebonmarche.fr','ALERTE:Erreur lors du lancement du package PK_Interface INTEGRATION_CLIENT',SQLERRM(SQLCODE));
              -- EXCEPTION WHEN OTHERS THEN
              --   Ajouter_Log(1, LeCodeMsg, 'Erreur lors de PK_Interface.INTEGRATION_CLIENT_LBM. ERREUR ENVOI DU MAIL.');
              --  END;
            
              ToujoursOk := FALSE;
            
            END;
        END;
      END IF;
      ---------------------------------------------------------
      -- 7.)  Comptage des erreurs
      ---------------------------------------------------------
      IF ToujoursOk THEN
        BEGIN
          SELECT SUM(nberr)
            INTO LeNbErreurs
            FROM (Select count(*) as nberr from LBM_INT_CLIENTS_REJETS);
        
          MAJ_SUIVI_BATCH_INTEGRATION(LeCodeTraitementBizTalk
                                     ,SYSDATE
                                     ,LeNbErreurs
                                     ,NULL
                                     ,'TABLE_STL_CLI');
        
          DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'LBM_INTEGRATION_CLIENT';
          Ajouter_Log(3
                     ,LeCodeMsg
                     ,'Fin de de l''integration des clients');
        
          UPDATE LBM_MESSAGE_ID
             SET ID_BATCH_STL = -ID_BATCH_STL
           WHERE ID_BATCH_STL < 0
             AND TYPEFLUX = 'CLI';
        
        EXCEPTION
          WHEN OTHERS THEN
            ToujoursOk := FALSE;
        END;
      END IF;
      --2eme commit
      COMMIT;
    END IF;
  END;
