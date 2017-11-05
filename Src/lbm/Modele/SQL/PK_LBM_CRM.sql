create PACKAGE pk_lbm_crm AS
  TYPE v_clients_rec IS RECORD(
     applisource            CHAR(3 BYTE)
    ,codeclient             clients.codeclient%TYPE
    ,codeclientexterne      clients.codeclientexterne%TYPE
    ,civilite               clients.codetitreclient%TYPE
    ,nom                    clients.nom%TYPE
    ,prenom                 clients.prenom%TYPE
    ,nomjeunefille          clients.nomjeunefille%TYPE
    ,datenaissance          DATE
    ,complementnom          adresses_client.complementnom%TYPE
    ,adresse                VARCHAR2(40 BYTE)
    ,complementadresse      adresses_client.complementadresse%TYPE
    ,lieudit                adresses_client.lieudit%TYPE
    ,codepostal             adresses_client.codepostal%TYPE
    ,ville                  adresses_client.ville%TYPE
    ,codepays               adresses_client.codepays%TYPE
    ,telephone              clients.telephone%TYPE
    ,mobile                 clients.notelmobile%TYPE
    ,email                  clients.email%TYPE
    ,codelangue             clients.codelangue%TYPE
    ,identificationdemandee clients.identificationdemandee%TYPE
    ,qtenpai                adresses_client.qtenpai%TYPE
    ,nbechecemail           clients.nbechecemail%TYPE
    ,nbechecsms             clients.nbechecsms%TYPE
    ,datecreation           clients.datecreation%TYPE
    ,datemodification       clients.datemodification%TYPE
    ,datesuppression        clients.datesuppression%TYPE
    ,
    /* Suppression ERI le 05/05/2014: On n'envoie plus les cartes vers le RCU pour eviter les desynchros avec l'envoi des tickets
    codetypecarte            carte_fidelite_client.codetypecartefideliteclient%TYPE,
    codecarte                carte_fidelite_client.codecartefideliteclient%TYPE,
    datecreacarte            carte_fidelite_client.datecreation%TYPE,
    datesupprcarte           carte_fidelite_client.datesuppression%TYPE,
    codeetatcarte            carte_fidelite_client.codeetatcartefideliteclient%TYPE,
    Fin Suppression ERI le 05/05/2014*/codeaxestat     stats_client.codeaxestat%TYPE
    ,codeelementstat stats_client.codeelementstat%TYPE
    ,valeuraxestat   stats_client.valeuraxestatistiqueclient%TYPE
    ,origineclient   VARCHAR2(2 BYTE)
    ,univers         VARCHAR2(10 BYTE)
    ,top_rcu         INTEGER);

  TYPE o_clientstype IS REF CURSOR RETURN v_clients_rec;

  PROCEDURE lbm_getcustomersforrcu(
                                   --ptoprcu    IN       NUMBER,
                                   o_cursor OUT o_clientstype);
END pk_lbm_crm;


create PACKAGE BODY           pk_lbm_crm
AS
/******************************************************************************
   NAME:       LBM_GETCUSTOMERSFORRCU
   PURPOSE:

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        10/10/2013      ERI    1. Created this procedure.

   NOTES: Donnees relatives aux clients a envoyer vers le RCU

   Automatically available Auto Replace Keywords:
      Object Name:     LBM_GETCUSTOMERSFORRCU
      Sysdate:         10/10/2013
      Date and Time:   10/10/2013, 10:19:20, and 10/10/2013 10:19:20
      Username:         (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
   PROCEDURE lbm_getcustomersforrcu (
                                     --ptoprcu    IN       NUMBER,
                                     o_cursor OUT o_clientstype)
   IS
      vdatetop   DATE;
   --recocursor   o_cursor%ROWTYPE;
   BEGIN
     -- Suppression ERI le 28/03/2014
      --SAVEPOINT debut_transaction;
     -- Fin suppression ERI le 28/03/2014
      
      vdatetop := SYSDATE;
    --Modif ERI le 15/03/2016: optimisation du pakcage suite a des deadlock  
    INSERT INTO LBM_CLIENT_TOP_TEMP
      SELECT  codeclient
                  FROM (SELECT DENSE_RANK () OVER (ORDER BY CASE
                                   WHEN ca.codetypecartefideliteclient IN
                                                                       (1, 2)
                                      THEN 'STG'
                                   WHEN ca.codetypecartefideliteclient = 9
                                      THEN 'STS'
                                   WHEN ca.codetypecartefideliteclient = 5
                                   --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016
                                      THEN 'STL'
                                   WHEN cli.clientcompte = 1
                                      THEN 'STC'
                                   WHEN ca.codetypecartefideliteclient = 6
                                      THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                   WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015      
                                   ELSE 'STO'
                                END) AS ordre,
                               DENSE_RANK () OVER (ORDER BY CASE
                                   WHEN ca.codetypecartefideliteclient IN
                                                                       (1, 2)
                                      THEN 'STG'
                                   WHEN ca.codetypecartefideliteclient = 9
                                      THEN 'STS'
                                   WHEN ca.codetypecartefideliteclient = 5
                                   --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016
                                      THEN 'STL'
                                   WHEN cli.clientcompte = 1
                                      THEN 'STC'
                                   WHEN ca.codetypecartefideliteclient = 6
                                      THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                   WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015  
                                   ELSE 'STO'
                                END,
                                cli.codeclient) AS nb_lignes,
                               tcli.top_rcu,
                               CASE
                                  WHEN ca.codetypecartefideliteclient IN
                                                       (1, 2)
                                     THEN 'STG'
                                  WHEN ca.codetypecartefideliteclient =
                                                             9
                                     THEN 'STS'
                                  WHEN ca.codetypecartefideliteclient =
                                                             5
                                     --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016                        
                                     THEN 'STL'
                                  WHEN cli.clientcompte = 1
                                     THEN 'STC'
                                  WHEN ca.codetypecartefideliteclient =
                                                             6
                                     THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                  WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015     
                                  ELSE 'STO'
                               END AS applisource,
                               cli.codeclient
                          FROM clients cli INNER JOIN adresses_client adr
                               ON cli.codeadresseclient =
                                                         adr.codeadresseclient
                               INNER JOIN lbm_client_top tcli
                               ON cli.codeclient = tcli.codeclient
                               LEFT JOIN carte_fidelite_client ca
                               ON ca.codeclient = cli.codeclient
                             AND ca.codeetatcartefideliteclient = 'AFF'
                               LEFT JOIN carte_fidelite_client cabis
                               ON cabis.codeclient = cli.codeclient
                             AND cabis.codetypecartefideliteclient IN
                                                                    (3, 4, 7) 
-- clients qui ont une carte de type "carte Borne de paiement Hote de caisse" ou "VIP Rive Gauche" ou "VIP Franck & Fils"
                               LEFT JOIN stats_client st
                               ON st.codeclient = cli.codeclient
                         WHERE tcli.top_rcu = 0 AND cabis.codeclient IS NULL

                       ) t1
                 WHERE ordre = 1 AND nb_lignes <= 200;
        
       
      UPDATE lbm_client_top
         SET top_rcu = 2,
             date_rcu = vdatetop
       WHERE codeclient IN ( SELECT CODECLIENT FROM LBM_CLIENT_TOP_TEMP ); 
       
      DELETE FROM LBM_CLIENT_TOP_TEMP;       
      
/*
      UPDATE lbm_client_top
         SET top_rcu = 2,
             date_rcu = vdatetop
       WHERE codeclient IN (
                SELECT codeclient
                  FROM (SELECT DENSE_RANK () OVER (ORDER BY CASE
                                   WHEN ca.codetypecartefideliteclient IN
                                                                       (1, 2)
                                      THEN 'STG'
                                   WHEN ca.codetypecartefideliteclient = 9
                                      THEN 'STS'
                                   WHEN ca.codetypecartefideliteclient = 5
                                   --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016
                                      THEN 'STL'
                                   WHEN cli.clientcompte = 1
                                      THEN 'STC'
                                   WHEN ca.codetypecartefideliteclient = 6
                                      THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                   WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015      
                                   ELSE 'STO'
                                END) AS ordre,
                               DENSE_RANK () OVER (ORDER BY CASE
                                   WHEN ca.codetypecartefideliteclient IN
                                                                       (1, 2)
                                      THEN 'STG'
                                   WHEN ca.codetypecartefideliteclient = 9
                                      THEN 'STS'
                                   WHEN ca.codetypecartefideliteclient = 5
                                   --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016
                                      THEN 'STL'
                                   WHEN cli.clientcompte = 1
                                      THEN 'STC'
                                   WHEN ca.codetypecartefideliteclient = 6
                                      THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                   WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015  
                                   ELSE 'STO'
                                END,
                                cli.codeclient) AS nb_lignes,
                               tcli.top_rcu,
                               CASE
                                  WHEN ca.codetypecartefideliteclient IN
                                                       (1, 2)
                                     THEN 'STG'
                                  WHEN ca.codetypecartefideliteclient =
                                                             9
                                     THEN 'STS'
                                  WHEN ca.codetypecartefideliteclient =
                                                             5
                                     --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                                   --Fin Ajout ERI le 24/02/2016                        
                                     THEN 'STL'
                                  WHEN cli.clientcompte = 1
                                     THEN 'STC'
                                  WHEN ca.codetypecartefideliteclient =
                                                             6
                                     THEN 'STR'
                                   -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                                  WHEN ca.codetypecartefideliteclient = 10
                                      THEN 'STF'
                                   -- Fin Ajout ERI le 20/11/2015     
                                  ELSE 'STO'
                               END AS applisource,
                               cli.codeclient
                          FROM clients cli INNER JOIN adresses_client adr
                               ON cli.codeadresseclient =
                                                         adr.codeadresseclient
                               INNER JOIN lbm_client_top tcli
                               ON cli.codeclient = tcli.codeclient
                               LEFT JOIN carte_fidelite_client ca
                               ON ca.codeclient = cli.codeclient
                             AND ca.codeetatcartefideliteclient = 'AFF'
                               LEFT JOIN carte_fidelite_client cabis
                               ON cabis.codeclient = cli.codeclient
                             AND cabis.codetypecartefideliteclient IN
                                                                    (3, 4, 7) 
-- clients qui ont une carte de type "carte Borne de paiement Hote de caisse" ou "VIP Rive Gauche" ou "VIP Franck & Fils"
                               LEFT JOIN stats_client st
                               ON st.codeclient = cli.codeclient
                         WHERE tcli.top_rcu = 0 AND cabis.codeclient IS NULL
-- On exclut les clients qui ont une carte de type "carte Borne de paiement Hote de caisse" ou "VIP Rive Gauche" ou "VIP Franck & Fils"
                           /*********************************************************************************
                           a supprimer quand les demi flux vers le RCU (Client en compte et LEX )  seront deployes en PROD
                           **********************************************************************************/
/*
                                   AND CASE
                                  WHEN ca.codetypecartefideliteclient IN
                                                                       (1, 2)
                                     THEN 'STG'
                                  WHEN ca.codetypecartefideliteclient = 9
                                     THEN 'STS'
                                  WHEN ca.codetypecartefideliteclient = 5
                                     THEN 'STL'
                                  WHEN cli.clientcompte = 1
                                     THEN 'STC'
                                  WHEN ca.codetypecartefideliteclient = 6
                                     THEN 'STR'
                                  ELSE 'STO'
                               END NOT IN ('STC', 'STL')
                               */
/**********************************************************************************/
--                       ) t1
--                 WHERE ordre = 1 AND nb_lignes <= 200);
    --Fin Modif ERI le 15/03/2016             
    
      /*SELECT COUNT(*) INTO LeNombre
      FROM LBM_CLIENT_TOP
      WHERE TOP_RCU = 2;

      COMMIT;

      RETURN LeNombre;*/
      OPEN o_cursor FOR
         SELECT applisource, t1.codeclient, codeclientexterne, civilite, nom,
                prenom, nomjeunefille, datenaissance, complementnom, adresse,
                complementadresse, lieudit, codepostal, ville, codepays,
                telephone, mobile, email, codelangue, identificationdemandee,
                qtenpai, nbechecemail, nbechecsms, datecreation,
                datemodification, datesuppression,
                /* Suppression ERI le 05/05/2014: On n'envoie plus les cartes vers le RCU pour eviter les desynchros avec l'envoi des tickets
                 codetypecarte, codecarte,
                datecreacarte, datesupprcarte, codeetatcarte,
                Fin Suppression ERI le 05/05/2014*/ 
                codeaxestat,
                codeelementstat, valeuraxestat, origineclient, univers,
                t1.top_rcu
           FROM (SELECT CASE
                           WHEN ca.codetypecartefideliteclient IN
                                                       (1, 2)
                              THEN 'STG'
                           WHEN ca.codetypecartefideliteclient =
                                                             9
                              THEN 'STS'
                           WHEN ca.codetypecartefideliteclient =
                                                             5
                              --Ajout ERI le 24/02/2016 : Gestion des clients sans carte
                                   OR cli.codeclient like '993%'
                              --Fin Ajout ERI le 24/02/2016                               
                              THEN 'STL'
                           WHEN cli.clientcompte = 1
                              THEN 'STC'
                           WHEN ca.codetypecartefideliteclient =
                                                             6
                              THEN 'STR'
                          -- Ajout ERI le 20/11/2015 Gestion cartes Cercles FF, type carte = 10
                           WHEN ca.codetypecartefideliteclient = 10
                              THEN 'STF'
                          -- Fin Ajout ERI le 20/11/2015    
                           ELSE 'STO'
                        END AS applisource,
                        cli.codeclient,
                        CASE
                           WHEN cli.codeclientexterne =
                                          cli.codeclient
                              THEN NULL
                           ELSE cli.codeclientexterne
                        END AS codeclientexterne,
                        CASE
                           WHEN NVL (cli.codetitreclient, 1) = 5
                              THEN 1
                           ELSE NVL (cli.codetitreclient, 1)
                        END AS civilite,
                        TRIM (cli.nom) AS nom, TRIM (cli.prenom) AS prenom,
                        cli.nomjeunefille,
                        CASE
                           WHEN lbm_controle_date
                                         (cli.journaissance,
                                          cli.moisnaissance,
                                          cli.anneenaissance
                                         ) = '01/01/1900'
                              THEN NULL
                           ELSE lbm_controle_date (cli.journaissance,
                                                   cli.moisnaissance,
                                                   cli.anneenaissance
                                                  )
                        END AS datenaissance,
                        adr.complementnom,
                        SUBSTR (adr.libellevoie, 1, 38) AS adresse,
                        adr.complementadresse, adr.lieudit,
                        NVL (adr.codepostal, '.') AS codepostal,
                        NVL (DECODE (adr.ville, '', '.', adr.ville),
                             '.'
                            ) AS ville,
                        NVL (DECODE (adr.codepays, 'NCO', 'FR',adr.codepays),
                             'FR'
                            ) AS codepays,
                        CASE
                           WHEN LENGTH
                                  (TRIM (TRANSLATE (cli.telephone,
                                                    ' +-.0123456789',
                                                    ' '
                                                   )
                                        )
                                  ) IS NULL
                              THEN cli.telephone
                           ELSE NULL
                        END AS telephone,
                        CASE
                           WHEN LENGTH
                                  (TRIM (TRANSLATE (cli.notelmobile,
                                                    ' +-.0123456789',
                                                    ' '
                                                   )
                                        )
                                  ) IS NULL
                              THEN cli.notelmobile
                           ELSE NULL
                        END AS mobile,
                        cli.email, cli.codelangue, cli.identificationdemandee,
                        adr.qtenpai, cli.nbechecemail, cli.nbechecsms,
                        cli.datecreation, cli.datemodification,
                        cli.datesuppression,
                        /* Suppression ERI le 05/05/2014: On n'envoie plus les cartes vers le RCU pour eviter les desynchros avec l'envoi des tickets
                        CASE
                           WHEN ca.datesuppression IS NOT NULL
                              THEN NULL
                           ELSE ca.codetypecartefideliteclient
                        END AS codetypecarte,
                        CASE
                           WHEN ca.datesuppression IS NOT NULL
                              THEN NULL
                           ELSE ca.codecartefideliteclient
                        END AS codecarte,
                        CASE
                           WHEN ca.datesuppression IS NOT NULL
                              THEN NULL
                           ELSE ca.datecreation
                        END AS datecreacarte,
                        CASE
                           WHEN ca.datesuppression IS NOT NULL
                              THEN NULL
                           ELSE ca.datesuppression
                        END AS datesupprcarte,
                        CASE
                           WHEN ca.datesuppression IS NOT NULL
                              THEN NULL
                           ELSE ca.codeetatcartefideliteclient
                        END AS codeetatcarte,
                        Fin Suppression ERI le 05/05/2014*/
                        st.codeaxestat, st.codeelementstat,
                        st.valeuraxestatistiqueclient AS valeuraxestat,
                        CASE
                        --Modif ERI le 13/03/2014
                           WHEN ca.codetypecartefideliteclient = 1
                           THEN 'RG'
                           WHEN ca.codetypecartefideliteclient = 2
                           THEN 'FF'
--                           WHEN ca.codetypecartefideliteclient IN
--                                                     (1, 2)
--                              THEN 'RG'
                        --Fin modif ERI le 13/03/2014    
                           WHEN ca.codetypecartefideliteclient =
                                                           9
                              THEN 'CU'
                           WHEN ca.codetypecartefideliteclient =
                                                           5
                              THEN 'LX'
                           WHEN cli.clientcompte = 1
                              THEN 'CC'
                           WHEN cli.nofax IS NOT NULL
                              THEN 'CI'
                           ELSE 'BM'
                        END AS origineclient,
                        CASE
                           WHEN (mag.bm IS NOT NULL OR mag.segep IS NOT NULL
                                )
                           AND mag.ff IS NULL
                           AND mag.groupe_bm IS NULL
                              THEN 'BM_SEGEP'
                           WHEN mag.ff IS NOT NULL
                           AND mag.bm IS NULL
                           AND mag.segep IS NULL
                           AND mag.groupe_bm IS NULL
                              THEN 'FF'
                          --Suppression ERI le 18/03/2014   
                           /*
                           WHEN mag.groupe_bm IS NOT NULL
                           AND mag.ff IS NULL
                           AND mag.bm IS NULL
                           AND mag.segep IS NULL
                              THEN 'GROUPE_BM'
                           WHEN mag.bm IS NOT NULL
                           AND mag.segep IS NOT NULL
                           AND mag.ff IS NOT NULL
                              THEN 'GROUPE_BM'
                           */   
                          --Fin suppression ERI  le 1803/2014    
                           ELSE 'GROUPE_BM'
                        END univers,
                        tcli.top_rcu
                   FROM clients cli INNER JOIN adresses_client adr
                        ON cli.codeadresseclient = adr.codeadresseclient
                        INNER JOIN lbm_client_top tcli
                        ON cli.codeclient = tcli.codeclient
                        LEFT JOIN
                        (SELECT codeclient, codecartefideliteclient,
                                datecreation, datesuppression,
                                codetypecartefideliteclient,
                                codeetatcartefideliteclient, ordre
                           FROM (SELECT ca.codeclient,
                                        ca.codecartefideliteclient,
                                        ca.datecreation, ca.datesuppression,
                                        ca.codetypecartefideliteclient,
                                        ca.codeetatcartefideliteclient,
                                        ROW_NUMBER () OVER (PARTITION BY ca.codeclient ORDER BY ca.datecreation DESC)
                                                                     AS ordre
                                   FROM carte_fidelite_client ca) t0
                          WHERE ordre = 1) ca ON ca.codeclient =
                                                                cli.codeclient
                        LEFT JOIN stats_client st
                        ON st.codeclient = cli.codeclient
                        LEFT JOIN
                        (SELECT   mag.codeclient,
                                  mag2.codegroupemagasin AS bm,
                                  mag3.codegroupemagasin AS segep,
                                  mag4.codegroupemagasin AS ff,
                                  mag5.codegroupemagasin AS groupe_bm
                             FROM clients_gpe_magasin mag LEFT JOIN clients_gpe_magasin mag2
                                  ON mag.codeclient = mag2.codeclient
                                AND mag2.codegroupemagasin = 1
                                  --Enseigne Le Bon Marche
                                  LEFT JOIN clients_gpe_magasin mag3
                                  ON mag.codeclient = mag3.codeclient
                                AND mag3.codegroupemagasin = 2
                                  --Enseigne SEGEP
                                  LEFT JOIN clients_gpe_magasin mag4
                                  ON mag.codeclient = mag4.codeclient
                                AND mag4.codegroupemagasin = 3   --Enseigne FF
                                  LEFT JOIN clients_gpe_magasin mag5
                                  ON mag.codeclient = mag5.codeclient
                                AND mag5.codegroupemagasin = 4
                         GROUP BY mag.codeclient,
                                  mag2.codegroupemagasin,
                                  mag3.codegroupemagasin,
                                  mag4.codegroupemagasin,
                                  mag5.codegroupemagasin) mag
                        ON cli.codeclient = mag.codeclient
                        ) t1
                INNER JOIN
                lbm_client_top tcli ON t1.codeclient = tcli.codeclient
          WHERE tcli.top_rcu = 2 AND tcli.date_rcu = vdatetop
                                                             --FOR UPDATE OF tcli.top_rcu
      ;

      UPDATE lbm_client_top
         SET top_rcu = 1
       WHERE top_rcu = 2 AND date_rcu = vdatetop;
       
      
      
     
     -- Suppression ERI le 28/03/2014
   /*  
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
      WHEN OTHERS
      THEN
         -- Consider logging the error and then re-raise
         ROLLBACK TO debut_transaction;
         RAISE;
    */     
    -- Fin suppression ERI le 28/03/2014     
   END lbm_getcustomersforrcu;
END pk_lbm_crm; 