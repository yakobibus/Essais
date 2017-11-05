create PACKAGE Pk_Lbm_dla AS

  /**************************************************************************************************************/
  /*                                    PACKAGE SPECIFIQUE LE BON MARCHE                                        */
  /*  Permet d'alimenter les tables tampon storeland depuis les tables specifiques BizTalk pour integration     */
  /*  dans Storeland via le package standard PK_INTERFACE                                                       */
  /*                                                                                                            */
  /*  SM 06/11/2006 #20104 Creation                                                                             */
  /*  PB 12/06/2007 MAJ Client en  Compte  #21574                                                               */
  /*                                                                                                            */
  /*                                                                                                            */
  /**************************************************************************************************************/

  TYPE TRecProduit IS RECORD(
     CODEPRODUIT               PRODUITS.CODEPRODUIT%TYPE
    ,NOMPRODUIT                PRODUITS.NOMPRODUIT%TYPE
    ,LIBPRODUIT                PRODUITS.LIBPRODUIT%TYPE
    ,CODESAISON                PRODUITS.CODESAISON%TYPE
    ,CODECLASSPROD3            PRODUITS.CODECLASSPROD3%TYPE
    ,CODEGRILLETAILLE          PRODUITS.CODEGRILLETAILLE%TYPE
    ,CODETYPEETIQUETTE         PRODUITS.CODETYPEETIQUETTE%TYPE
    ,CODEDOUANIER              PRODUITS.CODEDOUANIER%TYPE
    ,CODETYPESTOCKAGE          PRODUITS.CODETYPESTOCKAGE%TYPE
    ,POIDSPRODUIT              PRODUITS.POIDSPRODUIT%TYPE
    ,VOLUMEPRODUIT             PRODUITS.VOLUMEPRODUIT%TYPE
    ,EPAISSEURPRODUIT          PRODUITS.EPAISSEURPRODUIT%TYPE
    ,OBSERVATIONS              PRODUITS.OBSERVATIONS%TYPE
    ,CODEUTILISATEUR           PRODUITS.CODEUTILISATEUR%TYPE
    ,DATECREATION              PRODUITS.DATECREATION%TYPE
    ,DATEMODIFICATION          PRODUITS.DATEMODIFICATION%TYPE
    ,CODEGRILLEVARIANTE        PRODUITS.CODEGRILLEVARIANTE%TYPE
    ,DATESUPPRESSION           PRODUITS.DATESUPPRESSION%TYPE
    ,CODECOLORISSEL            PRODUITS.CODECOLORISSEL%TYPE
    ,PRODUITGRATUIT            PRODUITS.PRODUITGRATUIT%TYPE
    ,AUCATALOGUEWEB            PRODUITS.AUCATALOGUEWEB%TYPE
    ,DATEFINVIE                PRODUITS.DATEFINVIE%TYPE
    ,POIDS                     PRODUITS.POIDS%TYPE
    ,JAUGE                     PRODUITS.JAUGE%TYPE
    ,UNITELOGISTIQUE           PRODUITS.UNITELOGISTIQUE%TYPE
    ,TYPEPRODUIT               PRODUITS.TYPEPRODUIT%TYPE
    ,CODETYPEREASSORT          PRODUITS.CODETYPEREASSORT%TYPE
    ,CODEPAYSORIGINE           PRODUITS.CODEPAYSORIGINE%TYPE
    ,OBSERVATIONSSURBC         PRODUITS.OBSERVATIONSSURBC%TYPE
    ,CODEPAYSORIGINEMATIERE    PRODUITS.CODEPAYSORIGINEMATIERE%TYPE
    ,LONGUEURPRODUIT           PRODUITS.LONGUEURPRODUIT%TYPE
    ,HAUTEURPRODUIT            PRODUITS.HAUTEURPRODUIT%TYPE
    ,CODETYPEEMBALLAGE         PRODUITS.CODETYPEEMBALLAGE%TYPE
    ,DELAIREASSORT             PRODUITS.DELAIREASSORT%TYPE
    ,DUREEDEVIE                PRODUITS.DUREEDEVIE%TYPE
    ,CODETYPEMETHODEREASSORT   PRODUITS.CODETYPEMETHODEREASSORT%TYPE
    ,ZONEDEDOUTE               PRODUITS.ZONEDEDOUTE%TYPE
    ,DATEFINCDEDIRECTE         PRODUITS.DATEFINCDEDIRECTE%TYPE
    ,CODEUNITEPRESENTATION     PRODUITS.CODEUNITEPRESENTATION%TYPE
    ,NBPIECEPARUNITEPRESENT    PRODUITS.NBPIECEPARUNITEPRESENT%TYPE
    ,DATEMODIFICATIONASSORT    PRODUITS.DATEMODIFICATIONASSORT%TYPE
    ,EXCLUSIONFIDELITE         PRODUITS.EXCLUSIONFIDELITE%TYPE
    ,CODEDOUANIER2             PRODUITS.CODEDOUANIER2%TYPE
    ,CODEUNITEGESTIONVENTE     PRODUITS.CODEUNITEGESTIONVENTE%TYPE
    ,CODEUNITEGESTIONSTOCK     PRODUITS.CODEUNITEGESTIONSTOCK%TYPE
    ,CODEUNITEGESTIONACHAT     PRODUITS.CODEUNITEGESTIONACHAT%TYPE
    ,INDICETAILLEBASE          PRODUITS.INDICETAILLEBASE%TYPE
    ,DATEMODIFICATIONTFJ       PRODUITS.DATEMODIFICATIONTFJ%TYPE
    ,NBPIECESPARUNITERANGEMENT PRODUITS.NBPIECESPARUNITERANGEMENT%TYPE);

  TYPE TRecProduitColoris IS RECORD(
     CODEPRODUIT                PRODUITS_COLORIS.CODEPRODUIT%TYPE
    ,CODECOLORIS                PRODUITS_COLORIS.CODECOLORIS%TYPE
    ,LIBCOLORISMODIFIE          PRODUITS_COLORIS.LIBCOLORISMODIFIE%TYPE
    ,CODECOURBEDEVIE            PRODUITS_COLORIS.CODECOURBEDEVIE%TYPE
    ,CODEETAT                   PRODUITS_COLORIS.CODEETAT%TYPE
    ,DATECREATION               PRODUITS_COLORIS.DATECREATION%TYPE
    ,DATEMODIFICATION           PRODUITS_COLORIS.DATEMODIFICATION%TYPE
    ,CODESAISONGESTION          PRODUITS_COLORIS.CODESAISONGESTION%TYPE
    ,DATESUPPRESSION            PRODUITS_COLORIS.DATESUPPRESSION%TYPE
    ,CODECIBLEIMPLANTATION      PRODUITS_COLORIS.CODECIBLEIMPLANTATION%TYPE
    ,DATEMODIFCIBLEIMPLANTATION PRODUITS_COLORIS.DATEMODIFCIBLEIMPLANTATION%TYPE
    ,DATEDEBUTSAISONGESTION     PRODUITS_COLORIS.DATEDEBUTSAISONGESTION%TYPE
    ,DATEIMPLANTATIONPREVUE     PRODUITS_COLORIS.DATEIMPLANTATIONPREVUE%TYPE
    ,AREIMPLANTER               PRODUITS_COLORIS.AREIMPLANTER%TYPE
    ,CODEETATIMPLANTATION       PRODUITS_COLORIS.CODEETATIMPLANTATION%TYPE
    ,CODEETATPOURPALMARES       PRODUITS_COLORIS.CODEETATPOURPALMARES%TYPE);

  TYPE TRecArticle IS RECORD(
     CODEINTERNEARTICLE ARTICLES.CODEINTERNEARTICLE%TYPE
    ,CODEPRODUIT ARTICLES.CODEPRODUIT%TYPE
    ,CODECOLORIS ARTICLES.CODECOLORIS%TYPE
    ,CODEGRILLETAILLE ARTICLES.CODEGRILLETAILLE%TYPE
    ,INDICE ARTICLES.INDICE%TYPE
    ,CODEBARRES ARTICLES.CODEBARRES%TYPE
    ,QTETOTALEACHETEE ARTICLES.QTETOTALEACHETEE%TYPE
    ,QTEACHETEEREINIT ARTICLES.QTEACHETEEREINIT%TYPE
    ,VALTOTALEACHATHT ARTICLES.VALTOTALEACHATHT%TYPE
    ,VALACHATHTREINIT ARTICLES.VALACHATHTREINIT%TYPE
    ,CODEDEVISE ARTICLES.CODEDEVISE%TYPE
    ,CODEETAT ARTICLES.CODEETAT%TYPE
    ,ARRETREASSORT ARTICLES.ARRETREASSORT%TYPE
    ,DATECREATION ARTICLES.DATECREATION%TYPE
    ,DATEMODIFICATION ARTICLES.DATEMODIFICATION%TYPE
    ,CODEGRILLEVARIANTE ARTICLES.CODEGRILLEVARIANTE%TYPE
    ,INDICEVARIANTE ARTICLES.INDICEVARIANTE%TYPE
    ,GEREENSTOCK ARTICLES.GEREENSTOCK%TYPE
    ,NONREMISE ARTICLES.NONREMISE%TYPE
    ,STKOPTIMALMINI ARTICLES.STKOPTIMALMINI%TYPE
    ,STKOPTIMALMAXI ARTICLES.STKOPTIMALMAXI%TYPE
    ,ARTICLECENTRALE ARTICLES.ARTICLECENTRALE%TYPE
    ,PRIXREVIENTIND ARTICLES.PRIXREVIENTIND%TYPE
    ,PCB ARTICLES.PCB%TYPE
    ,DATESUPPRESSION ARTICLES.DATESUPPRESSION%TYPE
    ,"		CODENATURE 		   ARTICLES.CODENATURE%TYPE");

  TYPE TRecTVAProduitPays IS RECORD(
     CODEPAYS    TVA_PRODUIT_PAYS.CODEPAYS%TYPE
    ,CODEPRODUIT TVA_PRODUIT_PAYS.CODEPRODUIT%TYPE
    ,CODETVA     TVA_PRODUIT_PAYS.CODETVA%TYPE);

  TYPE TRecEAN IS RECORD(
     CODEFOURNISSEUR     HISTO_CB_FRN.CODEFOURNISSEUR%TYPE
    ,CODEINTERNEARTICLE  HISTO_CB_FRN.CODEINTERNEARTICLE%TYPE
    ,DATEFINAPPLICATION  HISTO_CB_FRN.DATEFINAPPLICATION%TYPE
    ,CODEBARRES          HISTO_CB_FRN.CODEBARRES%TYPE
    ,REFFOURNISSEUR      HISTO_CB_FRN.REFFOURNISSEUR%TYPE
    ,COLORISFOURNISSEUR  HISTO_CB_FRN.COLORISFOURNISSEUR%TYPE
    ,TAILLEFOURNISSEUR   HISTO_CB_FRN.TAILLEFOURNISSEUR%TYPE
    ,VARIANTEFOURNISSEUR HISTO_CB_FRN.VARIANTEFOURNISSEUR%TYPE
    ,DATECREATION        HISTO_CB_FRN.DATECREATION%TYPE);

  TYPE TRecTarif IS RECORD(
     CODEPAYS           TARIFS.CODEPAYS%TYPE
    ,CODEINTERNEARTICLE TARIFS.CODEINTERNEARTICLE%TYPE
    ,DATEDEBUT          TARIFS.DATEDEBUT%TYPE
    ,DATEFIN            TARIFS.DATEFIN%TYPE
    ,CODETYPETARIF      TARIFS.CODETYPETARIF%TYPE
    ,PVTTC              TARIFS.PVTTC%TYPE
    ,CODEOPECOMM        TARIFS.CODEOPECOMM%TYPE
    ,DATECREATION       TARIFS.DATECREATION%TYPE
    ,DATEMODIFICATION   TARIFS.DATEMODIFICATION%TYPE
    ,PVEURO             TARIFS.PVEURO%TYPE);

  TYPE TRecTarifFutur IS RECORD(
     CODEPAYS           INT_TARIFS_FUTURS.CODEPAYS%TYPE
    ,CODEINTERNEARTICLE INT_TARIFS_FUTURS.CODEINTERNEARTICLE%TYPE
    ,CODETYPETARIF      INT_TARIFS_FUTURS.CODETYPETARIF%TYPE
    ,DATEDEBUT          INT_TARIFS_FUTURS.DATEDEBUT%TYPE
    ,DATEFIN            INT_TARIFS_FUTURS.DATEFIN%TYPE
    ,PVTTC              INT_TARIFS_FUTURS.PVTTC%TYPE
    ,DATECREATION       INT_TARIFS_FUTURS.DATECREATION%TYPE
    ,DATEMODIFICATION   INT_TARIFS_FUTURS.DATEMODIFICATION%TYPE
    ,PVEURO             INT_TARIFS_FUTURS.PVEURO%TYPE
    ,DATEENVOI          INT_TARIFS_FUTURS.DATEENVOI%TYPE
    ,CODEGROUPEMAGASIN  INT_TARIFS_FUTURS.CODEGROUPEMAGASIN%TYPE);

  TYPE TRecTarifGroupeMag IS RECORD(
     CODEGROUPEMAGASIN    TARIFS_GROUPE_MAGASIN.CODEGROUPEMAGASIN%TYPE
    ,CODEINTERNEARTICLE   TARIFS_GROUPE_MAGASIN.CODEINTERNEARTICLE%TYPE
    ,DATEDEBUT            TARIFS_GROUPE_MAGASIN.DATEDEBUT%TYPE
    ,DATEFIN              TARIFS_GROUPE_MAGASIN.DATEFIN%TYPE
    ,CODETYPETARIF        TARIFS_GROUPE_MAGASIN.CODETYPETARIF%TYPE
    ,PVTTC                TARIFS_GROUPE_MAGASIN.PVTTC%TYPE
    ,CODEOPECOMM          TARIFS_GROUPE_MAGASIN.CODEOPECOMM%TYPE
    ,DATECREATION         TARIFS_GROUPE_MAGASIN.DATECREATION%TYPE
    ,DATEMODIFICATION     TARIFS_GROUPE_MAGASIN.DATEMODIFICATION%TYPE
    ,PVEURO               TARIFS_GROUPE_MAGASIN.PVEURO%TYPE
    ,TRANSFERTVERSMAGASIN TARIFS_GROUPE_MAGASIN.TRANSFERTVERSMAGASIN%TYPE
    ,TAUXREMISE           TARIFS_GROUPE_MAGASIN.TAUXREMISE%TYPE);
  --DLA le 01/03/2007 : la recherche se fait sur le libelle (le code n'est pas descendu), ceuli ci est UNIQUE
  "	   TYPE TTabCodesOpeComm IS TABLE OF OPERATIONS_COMMERCIALES.LibOpeComm%TYPE INDEX BY BINARY_INTEGER;"
  --TYPE TTabCodesOpeComm IS TABLE OF OPERATIONS_COMMERCIALES.CodeOpeComm%TYPE INDEX BY BINARY_INTEGER;
  
  TYPE TRecHierarchieProd IS RECORD(CODECLASSPROD CLASSPROD3.CODECLASSPROD3%TYPE
                                   ,LIBCLASSPROD CLASSPROD3.LIBCLASSPROD3%TYPE
                                   ,CODEPERE CLASSPROD3.CODECLASSPROD2%TYPE
                                   ,DATECREATION CLASSPROD3.DATECREATION%TYPE
                                   ,DATEMODIFICATION CLASSPROD3.DATEMODIFICATION%TYPE
                                   ,ELEMENTNIV LBM_HIERARCHIE.ELEMENTNIV%TYPE);

  TYPE TRecLBMVenteEntete IS RECORD(
     STECAISSE        LBM_VENTE_ENTETE.STECAISSE%TYPE
    ,DATEHTRANS       LBM_VENTE_ENTETE.DATEHTRANS%TYPE
    ,NUMCAISSE        LBM_VENTE_ENTETE.NUMCAISSE%TYPE
    ,NUMCAISSIERTRANS LBM_VENTE_ENTETE.NUMCAISSIERTRANS%TYPE
    ,NUMTICKET        LBM_VENTE_ENTETE.NUMTICKET%TYPE
    ,EXPORT           LBM_VENTE_ENTETE.EXPORT%TYPE
    ,NUMCLT           LBM_VENTE_ENTETE.NUMCLT%TYPE
    ,CANETTTC         LBM_VENTE_ENTETE.CANETTTC%TYPE
    ,ESCPT            LBM_VENTE_ENTETE.ESCPT%TYPE
    ,NUMCARTEPRIV     LBM_VENTE_ENTETE.NUMCARTEPRIV%TYPE
    ,DATEHTOPCA       LBM_VENTE_ENTETE.DATEHTOPCA%TYPE
    ,DATEMAJ          LBM_VENTE_ENTETE.DATEMAJ%TYPE);

  TYPE TRecLBMVentePoste IS RECORD(
     STECAISSE                                              LBM_VENTE_POSTE.STECAISSE%TYPE
    ,DATEHTRANS                                             LBM_VENTE_POSTE.DATEHTRANS%TYPE
    ,NUMCAISSE                                              LBM_VENTE_POSTE.NUMCAISSE%TYPE
    ,NUMTICKET                                              LBM_VENTE_POSTE.NUMTICKET%TYPE
    ,NUMLIGNE                                               LBM_VENTE_POSTE.NUMLIGNE%TYPE
    ,CODEVEND                                               LBM_VENTE_POSTE.CODEVEND%TYPE
    ,EANSAISIE                                              LBM_VENTE_POSTE.EANSAISIE%TYPE
    ,"		DEPARTEMENT		  LBM_VENTE_POSTE.DEPARTEMENT%TYPE,"   CP LBM_VENTE_POSTE.CP%TYPE
    ,PRIXTTCART                                             LBM_VENTE_POSTE.PRIXTTCART%TYPE
    ,PRIXHTART                                              LBM_VENTE_POSTE.PRIXTTCART%TYPE
    ,CANETLIGNE                                             LBM_VENTE_POSTE.CANETLIGNE%TYPE
    ,"		CANETLIGNEHT      LBM_VENTE_POSTE.CANETLIGNE%TYPE," APPL LBM_VENTE_POSTE.APPL%TYPE
    ,TYPEGEST                                               LBM_VENTE_POSTE.TYPEGEST%TYPE
    ,NUMCDECLT                                              LBM_VENTE_POSTE.NUMCDECLT%TYPE
    ,TOTREMRED                                              LBM_VENTE_POSTE.TOTREMRED%TYPE
    ,"		TOTREMREDHT       LBM_VENTE_POSTE.TOTREMRED%TYPE,"  TVATAUX LBM_VENTE_POSTE.TVATAUX%TYPE
    ,TVAMONT                                                LBM_VENTE_POSTE.TVAMONT%TYPE
    ,QTE                                                    LBM_VENTE_POSTE.QTE%TYPE
    ,PR                                                     LBM_VENTE_POSTE.PR%TYPE
    ,REDUCTOTAL                                             LBM_VENTE_POSTE.REDUCTOTAL%TYPE
    ,ESCMONT                                                LBM_VENTE_POSTE.ESCMONT%TYPE
    ,
    --DLA le 13/03/2007
    "		EXPMONT           LBM_VENTE_POSTE.EXPMONT%TYPE," "		MONTACTMARK		  LBM_VENTE_POSTE.MONTACTMARK%TYPE," "MONTACTMARKHT	  LBM_VENTE_POSTE.MONTACTMARK%TYPE," "		REDUCTYPE         LBM_VENTE_POSTE.REDUCTYPE%TYPE," REMISETYPE LBM_VENTE_POSTE.REMISETYPE%TYPE
    ,REMMANUELLE                                         LBM_VENTE_POSTE.REMMANUELLE%TYPE
    ,NUMPLAN                                             LBM_VENTE_POSTE.NUMPLAN%TYPE
    ,HCA                                                 LBM_VENTE_POSTE.HCA%TYPE
    ,ACTMARKLIBREDUIT                                    LBM_VENTE_POSTE.ACTMARKLIBREDUIT%TYPE
    ,ACTMARKCODEDUTYPE                                   LBM_VENTE_POSTE.ACTMARKCODEDUTYPE%TYPE
    ,DATHTOPGU                                           LBM_VENTE_POSTE.DATHTOPGU%TYPE
    ,TOPARCH                                             LBM_VENTE_POSTE.TOPARCH%TYPE
    ,DATEMAJ                                             LBM_VENTE_POSTE.DATEMAJ%TYPE
    ,"		EXPART			  LBM_VENTE_POSTE.EXPART%TYPE,"         "		EXPREMISE		  LBM_VENTE_POSTE.EXPREMISE%TYPE," "		MOTIFRETOUR		  LBM_VENTE_POSTE.MOTIFRETOUR%TYPE");

  TYPE TabLigneVente IS TABLE OF TRecLBMVentePoste INDEX BY BINARY_INTEGER;

  TYPE TRecLBMVenteReglement IS RECORD(
     STECAISSE        LBM_VENTE_REGLEMENT.STECAISSE%TYPE
    ,DATEHTRANSAC     LBM_VENTE_REGLEMENT.DATEHTRANSAC%TYPE
    ,NUMCAISSE        LBM_VENTE_REGLEMENT.NUMCAISSE%TYPE
    ,NUMCAISSIERTRANS LBM_VENTE_REGLEMENT.NUMCAISSIERTRANS%TYPE
    ,NUMTICKET        LBM_VENTE_REGLEMENT.NUMTICKET%TYPE
    ,NUMLIGPAIE       LBM_VENTE_REGLEMENT.NUMLIGPAIE%TYPE
    ,NUMCERTIFCHQ     LBM_VENTE_REGLEMENT.NUMCERTIFCHQ%TYPE
    ,NUMAUTOCB        LBM_VENTE_REGLEMENT.NUMAUTOCB%TYPE
    ,PAIEMODE         LBM_VENTE_REGLEMENT.PAIEMODE%TYPE
    ,PAIEMONTDEV      LBM_VENTE_REGLEMENT.PAIEMONTDEV%TYPE
    ,DEV              LBM_VENTE_REGLEMENT.DEV%TYPE
    ,PAIEMONTDEVSTE   LBM_VENTE_REGLEMENT.PAIEMONTDEVSTE%TYPE
    ,NUMIDMOYPAIE     LBM_VENTE_REGLEMENT.NUMIDMOYPAIE%TYPE
    ,DATEMAJ          LBM_VENTE_REGLEMENT.DATEMAJ%TYPE);

  TYPE TTabLigneReglement IS TABLE OF TRecLBMVenteReglement INDEX BY BINARY_INTEGER;

  TYPE TRecLBMTypeRemise IS RECORD(
     REMISETYPE LBM_TYPE_REMISE.REMISETYPE%TYPE
    ,REMISELIB  LBM_TYPE_REMISE.REMISELIB%TYPE
    ,DATEMAJ    LBM_TYPE_REMISE.DATEMAJ%TYPE);

  TYPE TRecLBMActionMarketing IS RECORD(
     ACTMARKCODETYPE  LBM_ACTION_MARKETING.ACTMARKCODETYPE%TYPE
    ,ACTMARKLIBDUTYPE LBM_ACTION_MARKETING.ACTMARKLIBDUTYPE%TYPE
    ,DATEMAJ          LBM_ACTION_MARKETING.DATEMAJ%TYPE);

  PROCEDURE LBM_IntegrationReferencement;
  PROCEDURE LBM_Extractions;
END Pk_Lbm_dla;

create PACKAGE BODY PK_LBM_dla IS
  LeCodeTraitementBizTalk VARCHAR(50);

  /*******************************************************************/
  /*                                                                 */
  /* Procedure Ajouter_Log                                           */
  /*                                                                 */
  /* Ajout de logs dans la table Log_Traitements                     */
  /*                                                                 */
  /*  LeCodeNiveauMsg:                                               */
  /*     0: Erreur critique                                          */
  /*     1: Erreur                                                   */
  /*     2: Avertissement                                            */
  /*     3: Message                                                  */
  /*                                                                 */
  /*  SM 06/11/2006 #20104 Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE Ajouter_Log(LeCodeNiveauMsg NUMBER
                       ,LeCodeMsg       VARCHAR2
                       ,LeLibMsg        VARCHAR2) IS
  BEGIN
    Ajouter_Log_Traitement(0
                          ,LeCodeNiveauMsg
                          ,SYSDATE
                          ,LeCodeMsg
                          ,LeLibMsg
                          ,0
                          ,''
                          ,LeCodeTraitementBizTalk
                          ,'');
  END;

  FUNCTION TEST_CodeSaisie(Valeur VARCHAR2) RETURN NUMBER IS
    Tampon NUMBER;
  BEGIN
    "	   BEGIN" "	     Tampon := TO_NUMBER(Valeur);" EXCEPTION WHEN others THEN
      RETURN 99999999;
    "	   END;"
      RETURN Tampon;
  END;

  /*******************************************************************/
  /*                                                                 */
  /* FUNCTION TEST_TICKET                                            */
  /*                                                                 */
  /* Permet de verifier la coherence du ticket avant le commit       */
  /*                                                                 */
  /*  DLA le 22/06/2007                                              */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE TEST_TICKET(LaSteCaisse   VARCHAR2
                       ,LeNumCaisse   NUMBER
                       ,LeNumTicket   NUMBER
                       ,LaDateHtTrans DATE) IS
    Resultat                                                                                                              NUMBER;
    "	BEGIN"                                                                                                              BEGIN
      SELECT count(*)
        INTO Resultat
        FROM lbm_vente_entete a "WHERE a.Numticket	= LeNumTicket" "and   a.numcaisse	= LeNumCaisse" "and   a.stecaisse	= LaSteCaisse" "and   a.datehtrans	= LaDateHtTrans"
       GROUP BY a.stecaisse
               ,a.numcaisse
               ,a.numticket
               ,a.datehtrans
      HAVING "	     sum(CANETTTC) =" "	(" "	SELECT sum(paiemontdevste)" "	FROM  lbm_vente_reglement b" "	WHERE a.datehtrans = b.datehtransac" "	AND	  a.numcaisse = b.numcaisse" "	AND	  a.stecaisse = b.stecaisse" "	AND	  a.numticket = b.numticket" "	)" AND "	sum(CANETTTC) =" "	(" "	SELECT sum(canetligne)" "	FROM  LBM_VENTE_POSTE c" "	WHERE a.datehtrans = c.datehtrans" "	AND	  a.numcaisse = c.numcaisse" "	AND	  a.stecaisse = c.stecaisse" "	AND	  a.numticket = c.numticket" "	)" "	;" IF Resultat = 1 THEN --LE TICKET EXISTE ET EST EQUILIBRE
      "		  COMMIT;" ELSE -- LE TICKET EST DESEQUILIBRE OU N'EXISTE PAS
      ROLLBACK;
  
    "	  Ajouter_Log(1, 'BIZ-0005', 'Erreur : ticket incoherent : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);" "		  END IF;" "	EXCEPTION" "	  WHEN OTHERS THEN" "		ROLLBACK;" "	Ajouter_Log(1, 'BIZ-0005', 'Erreur : pendant le controle du ticket : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);" "	END;" END;
  
    --
    --   BEGIN
    --     BEGIN
    --       SELECT count(*) INTO Resultat
    "--       FROM"
    --         (SELECT a.stecaisse, a.numcaisse, a.datehtrans, a.numticket , sum(a.CANETTTC) E,
    --            (SELECT sum(paiemontdevste)
    --             FROM  lbm_vente_reglement b
    --             WHERE a.datehtrans = b.datehtransac
    "--             AND   a.numcaisse = b.numcaisse" "--             AND   a.stecaisse = b.stecaisse" "--             AND   a.numticket = b.numticket"
    --            ) P,
    --            (SELECT sum(CANETLIGNE)
    --             from  LBM_VENTE_POSTE c
    --             where a.datehtrans = c.datehtrans
    "--             AND   a.numcaisse = c.numcaisse" "--             AND   a.stecaisse = c.stecaisse" "--             AND   a.numticket = c.numticket"
    --             ) L
    --          FROM lbm_vente_entete a
    "--          WHERE a.Numticket    = LeNumTicket" "--          and   a.numcaisse      = LeNumCaisse" "--          and   a.stecaisse      = LaSteCaisse" "--          and   a.datehtrans   = LaDateHtTrans"
    --          GROUP BY a.stecaisse, a.numcaisse, a.numticket, a.datehtrans
    --          HAVING
    "--          sum(CANETTTC) <>" "--             (" "--             SELECT sum(paiemontdevste)" "--             FROM  lbm_vente_reglement b" "--             WHERE a.datehtrans = b.datehtransac" "--             AND   a.numcaisse = b.numcaisse" "--             AND   a.stecaisse = b.stecaisse" "--             AND   a.numticket = b.numticket" "--             )"
    --             OR
    "--             (" "--             SELECT sum(paiemontdevste)" "--             FROM  lbm_vente_reglement b" "--             WHERE a.datehtrans = b.datehtransac" "--             AND   a.numcaisse = b.numcaisse" "--             AND   a.stecaisse = b.stecaisse" "--             AND   a.numticket = b.numticket" "--             ) IS NULL"
    --             OR
    "--             sum(CANETTTC) <>" "--             (" "--             SELECT sum(canetligne)" "--             FROM  LBM_VENTE_POSTE c" "--             WHERE a.datehtrans = c.datehtrans" "--             AND   a.numcaisse = c.numcaisse" "--             AND   a.stecaisse = c.stecaisse" "--             AND   a.numticket = c.numticket" "--             )"
    --             OR
    "--             (" "--             SELECT sum(canetligne)" "--             FROM  LBM_VENTE_POSTE c" "--             WHERE a.datehtrans = c.datehtrans" "--             AND      a.numcaisse = c.numcaisse" "--             AND   a.stecaisse = c.stecaisse" "--             AND   a.numticket = c.numticket" "--             ) IS NULL"
    --         );
    --       IF Resultat <> 0 then
    "--       ROLLBACK;" "--       Ajouter_Log(1, 'BIZ-0005', 'Erreur : ticket incoherent : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);"
    --       ELSE
    "--     COMMIT;"
    --       END IF;
    "--   EXCEPTION" "--     WHEN OTHERS THEN" "--       ROLLBACK;" "--       Ajouter_Log(1, 'BIZ-0005', 'Erreur : pendant le controle du ticket : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);" "--   END;"
    --   END;
    
    /*******************************************************************/
    /*                                                                 */
    /* Procedure Ajouter_Log_LBM                                       */
    /*                                                                 */
    /* Ajout de logs dans la table Log_LBM                             */
    /*                                                                 */
    /*  DLA 02/01/2007 Creation                                        */
    /*                                                                 */
    /*******************************************************************/
    
    PROCEDURE Ajouter_Log_LBM(LeTypeFlux VARCHAR2
                             ,LeIdMessage VARCHAR2
                             ,LaPhase NUMBER
                             ,LeMsgErreur VARCHAR2
                             ,LeIdEnregistrement NUMBER) IS pragma autonomous_transaction;
  BEGIN
    BEGIN
      INSERT INTO LBM_LOGS
        (TYPE_FLUX
        ,ID_MESSAGE
        ,PHASE
        ,MSGERREUR
        ,ID_ENREGISTREMENT)
      VALUES
        (LeTypeFlux
        ,LeIdMessage
        ,LaPhase
        ,LeMsgErreur
        ,LeIdEnregistrement);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        BEGIN
          NULL;
        END;
      WHEN OTHERS THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20001
                               ,'Erreur lors de l''ecriture dans la table LBM_LOGS.' || CHR(13) || SQLERRM(SQLCODE));
    END;
    commit;
  END;

  /*******************************************************************/
  /*                                                                 */
  /* Procedure PRC_LBM_EAN_FINALISE                                  */
  /*                                                                 */
  /* Principe : on recoit tous les EAN des articles que l'on integre */
  /* Il faut donc  Mettre DateFinApplication pour les EAN present    */
  /* dans STL et absent dans tampon                                  */
  /* Ainsi, on va mettre a jour proprement les EAN en creation ou    */
  /* suppression                                                     */
  /*                                                                 */
  /*  DLA 02/01/2007 Creation                                        */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_EAN_FINALISE IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0011';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de la gestion des EANs a supprimer');
    BEGIN
      -- On rappelle ici que dans le cadre des interfaces LBM, les tables INT sont VIDEES
      -- a chaque fin de traitement; donc, on a QUE les articles du traotements en cours;
      -- Or, dans un traitement d'intergation LBM, quand on recoit un article, on recoit
      -- tous ses EANs et ses tarifs; c'est pourquoi une selection sur INT_Articles permet
      -- bien de reperer les articles en cours de traitements pour les EANs
      FOR Ligne in (SELECT * FROM INT_ARTICLES) LOOP
        BEGIN
          -- Pour chaque articles en cours de traitement EAN, on va repere les EANs present dans
          -- Storeland et absent dans INT_Histo_CB_Frn; si on ne recoit pas ces EANs, alors, c'est
          -- qu'ils doivent etre supprimes;
          FOR LigneEAN in (SELECT CODEFOURNISSEUR
                                 ,CODEINTERNEARTICLE
                                 ,CODEBARRES
                             from HISTO_CB_FRN
                            WHERE CODEINTERNEARTICLE = Ligne.CodeInterneArticle
                              AND CodeFournisseur = 1
                           MINUS
                           SELECT CODEFOURNISSEUR
                                 ,CODEINTERNEARTICLE
                                 ,CODEBARRES
                             from INT_HISTO_CB_FRN
                            WHERE CODEINTERNEARTICLE = Ligne.CodeInterneArticle
                              AND CodeFournisseur = 1) LOOP
            -- Et pour les supprimer, on va inserer dans la table tampon, une ligne avec la date de
            -- suppression ) SYSDATE; ainsi, lors du traitement d'integration standard PK_Interface,
            -- cette date sera mis a jour sur la ligne.
            BEGIN
              INSERT INTO INT_HISTO_CB_FRN
                (CODEFOURNISSEUR
                ,CODEINTERNEARTICLE
                ,DATEFINAPPLICATION
                ,CODEBARRES
                ,REFFOURNISSEUR
                ,COLORISFOURNISSEUR
                ,TAILLEFOURNISSEUR
                ,VARIANTEFOURNISSEUR
                ,DATECREATION)
              VALUES
                (LigneEAN.CODEFOURNISSEUR
                ,LigneEAN.CODEINTERNEARTICLE
                ,Trunc(SYSDATE)
                ,LigneEAN.CODEBARRES
                ,NULL
                ,NULL
                ,NULL
                ,NULL
                ,NULL);
            EXCEPTION
              WHEN OTHERS THEN
                ROLLBACK;
                RAISE_APPLICATION_ERROR(-20001
                                       ,'Erreur pendant la procedure PRC_LBM_EAN_FINALISE.' || CHR(13) || SQLERRM(SQLCODE));
            END;
            commit;
          END LOOP;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur pendant la procedure PRC_LBM_EAN_FINALISE.' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    END;
  END;

  /*******************************************************************/
  /*  Procedure PRC_TRAITE_REJET                                     */
  /*                                                                 */
  /*  Les lignes non integrees des tables INT_* sont extraites       */
  /*  et inserees dans la tables LOGS_LBM pour etre prise en         */
  /*  dans la gestion des rejets de BizTalk                          */
  /*  DLA 02/01/2007 Creation                                        */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_TRAITE_REJET(CodeTraitement NUMBER) IS
    LeCodeMsg    Log_Traitements.CodeMsg%TYPE;
    LeNomProduit Produits.NomProduit%Type;
    Continu      Number;
  BEGIN
    LeCodeMsg := 'BIZ-0010';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''ecriture des rejets dans LBM_LOGS');
    -- Traitement du rejet du flux Article, comprenant les articles, les tarifs et les EAN
    BEGIN
      -- Traitement du rejets des articles
      FOR Ligne IN (SELECT * FROM INT_PRODUITS) LOOP
        BEGIN
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,Ligne.NomProduit);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    
      FOR Ligne IN (SELECT * FROM INT_PRODUITS_COLORIS) LOOP
        BEGIN
          BEGIN
            SELECT NomProduit INTO LeNomProduit from INT_PRODUITS WHERE codeProduit = Ligne.CodeProduit;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                SELECT NomProduit INTO LeNomProduit from PRODUITS WHERE codeProduit = Ligne.CodeProduit;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,LeNomProduit);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    
      FOR Ligne IN (SELECT * FROM INT_ARTICLES) LOOP
        BEGIN
          BEGIN
            SELECT p.NomProduit
              INTO LeNomProduit
              from INT_PRODUITS p
                  ,INT_ARTICLES a
             WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
               AND p.codeProduit = a.CodeProduit;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                SELECT p.NomProduit
                  INTO LeNomProduit
                  from PRODUITS p
                      ,ARTICLES a
                 WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
                   AND p.codeProduit = a.CodeProduit;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,LeNomProduit);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    
      -- Traitement du rejets des Tarifs
      FOR Ligne IN (SELECT * FROM INT_TARIFS) LOOP
        BEGIN
          BEGIN
            --     SELECT  p.NomProduit INTO LeNomProduit from INT_PRODUITS p, INT_TARIFS a
            --           WHERE  a.CodeInterneArticle = Ligne.CodeInterneArticle
            --     AND   p.codeProduit = a.CodeProduit;
            NULL;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                --           SELECT  p.NomProduit INTO LeNomProduit from PRODUITS p, TARIFS a
                --                WHERE    a.CodeInterneArticle = Ligne.CodeInterneArticle
                --          AND   p.codeProduit = a.CodeProduit;
                NULL;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
        
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,LeNomProduit);
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
      -- Traitement du rejets des EANs
      FOR Ligne IN (SELECT * FROM INT_HISTO_CB_FRN) LOOP
        BEGIN
          SELECT p.NomProduit
            INTO LeNomProduit
            from INT_PRODUITS p
                ,INT_ARTICLES a
           WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
             AND a.codeProduit = p.CodeProduit;
        
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,LeNomProduit);
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
      -- Traitement du rejets des TVA / produits / Pays
      FOR Ligne IN (SELECT * FROM INT_TVA_PRODUIT_PAYS) LOOP
        BEGIN
          SELECT NomProduit INTO LeNomProduit from INT_PRODUITS WHERE codeProduit = Ligne.CodeProduit;
        
          Ajouter_Log_LBM('Article'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,LeNomProduit);
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NULL;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    END;
    -- FIN du Traitement du rejet du flux Article, comprenant les articles, les tarifs et les EAN
  
    -- Traitement du rejet du flux hierarchie,
    BEGIN
      -- Traitement du rejets des CLASSPROD3
      FOR Ligne IN (SELECT * FROM INT_CLASSPROD3) LOOP
        BEGIN
          Ajouter_Log_LBM('hierarchie'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,Ligne.CodeClassProd3);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NUll;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    
      -- Traitement du rejets des CLASSPROD2
      FOR Ligne IN (SELECT * FROM INT_CLASSPROD2) LOOP
        BEGIN
          Ajouter_Log_LBM('hierarchie'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,Ligne.CodeClassProd2);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NUll;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
      -- Traitement du rejets des CLASSPROD1
      FOR Ligne IN (SELECT * FROM INT_CLASSPROD1) LOOP
        BEGIN
          Ajouter_Log_LBM('hierarchie'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,Ligne.CodeClassProd1);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NUll;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
      -- Traitement du rejets des CLASSPROD0
      FOR Ligne IN (SELECT * FROM INT_CLASSPROD0) LOOP
        BEGIN
          Ajouter_Log_LBM('hierarchie'
                         ,CodeTraitement
                         ,2
                         ,NULL
                         ,Ligne.CodeClassProd0);
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            NUll;
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''ecriture des rejets dans LBM_LOGS' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    END;
    -- FIN du Traitement du rejet du flux hierarchie
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''ecriture des rejets dans LBM_LOGS');
  END;

  /*******************************************************************/
  /*  Procedure PRC_PURGE_INT                                        */
  /*                                                                 */
  /*  La gestion des rejets est fait par LBM via BizTalk             */
  /*  Donc, a la fin de chaque traitement                            */
  /*  on vide les tables concernees                                  */
  /*                                                                 */
  /*  DLA 02/01/2007 Creation                                        */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_PURGE_INT IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0009';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de la purge des tables INT*');
    BEGIN
      DELETE from INT_PRODUITS;
      DELETE from INT_PRODUITS_COLORIS;
      DELETE from INT_ARTICLES;
      DELETE from INT_TVA_PRODUIT_PAYS;
      DELETE from INT_DESCRIPTIONS_PRODUIT_WEB;
      DELETE from INT_STATS_PRODUIT_COLORIS;
      DELETE from INT_TARIFS;
      DELETE from INT_TARIFS_GROUPE_MAGASIN;
      DELETE from INT_TARIFS_FUTURS;
      DELETE from INT_HISTO_CB_FRN;
      DELETE from INT_CLASSPROD0;
      DELETE from INT_CLASSPROD1;
      DELETE from INT_CLASSPROD2;
      DELETE from INT_CLASSPROD3;
      DELETE from INT_DATES_OPE_COMM;
      DELETE from INT_OPERATIONS_COMMERCIALES;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de la purge des tables INT*' || CHR(13) || SQLERRM(SQLCODE));
    END;
    commit;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la purge des tables INT*');
  END;

  /******************************************************************/
  /*  Procedure PRC_LBM_CP                                           */
  /*                                                                 */
  /*  Historisation de la table LBM_CP                               */
  /*  DLA 02/01/2007 Creation                                        */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_CP(CodeTraitement VARCHAR2) IS
  BEGIN
    FOR Ligne IN (SELECT * FROM LBM_CP where MESSAGEID = CodeTraitement) LOOP
      BEGIN
        INSERT INTO LBM_CP_HISTO
          (CP
          ,CPLIB
          ,HCA
          ,APPL
          ,TYPEGEST
          ,DATEMAJ)
        VALUES
          (Ligne.CP
          ,Ligne.CPLIB
          ,Ligne.HCA
          ,Ligne.APPL
          ,Ligne.TYPEGEST
          ,Ligne.DATEMAJ);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          BEGIN
            UPDATE LBM_CP_HISTO
               SET CPLIB    = Ligne.CPLIB
                  ,HCA      = Ligne.HCA
                  ,APPL     = Ligne.APPL
                  ,TYPEGEST = Ligne.TYPEGEST
                  ,DATEMAJ  = Ligne.DATEMAJ
             WHERE CP = Ligne.CP;
          END;
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de l''integration du CP ' || Ligne.CP || CHR(13) || SQLERRM(SQLCODE));
      END;
      commit;
    END LOOP;
  END;

  /******************************************************************/
  /*  Procedure PRC_LBM_HIERARCHIE                                   */
  /*                                                                 */
  /*  Integration des ClassProd                                      */
  /*    depuis la table LBM_HIERARCHIE                               */
  /*                                                                 */
  /*  PB 06/11/2006 #20104 Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_HIERARCHIE(CodeTraitement VARCHAR2) IS
    LeCodeMsg   Log_Traitements.CodeMsg%TYPE;
    LHIERARCHIE TRecHierarchieProd;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock TTabLock;
  
    PROCEDURE TRAITEMENT_CLASSPROD0 IS
    BEGIN
      BEGIN
        SELECT DATECREATION INTO LHIERARCHIE.DATECREATION FROM CLASSPROD0 WHERE CODECLASSPROD0 = LHIERARCHIE.CODECLASSPROD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          BEGIN
            SELECT DATECREATION INTO LHIERARCHIE.DATECREATION FROM INT_CLASSPROD0 WHERE CODECLASSPROD0 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LHIERARCHIE.DATECREATION := TRUNC(SYSDATE);
          END;
        
      END;
    
      BEGIN
        INSERT INTO INT_CLASSPROD0
          (CODECLASSPROD0
          ,ACCESSOIRES
          ,AUPLANDASSORTIMENT
          ,DATECREATION
          ,DATEFINVALIDITE
          ,DATEMODIFICATION
          ,LIBCLASSPROD0)
        VALUES
          (LHIERARCHIE.CODECLASSPROD
          ,0
          ,NULL
          ,LHIERARCHIE.DATECREATION
          ,NULL
          ,LHIERARCHIE.DATEMODIFICATION
          ,LHIERARCHIE.LIBCLASSPROD);
      
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          BEGIN
            UPDATE INT_CLASSPROD0
               SET --ACCESSOIRES = 0,
                   --  AUPLANDASSORTIMENT = NULL,
                   DATECREATION = LHIERARCHIE.DATECREATION
                  ,
                   --  DATEFINVALIDITE = NULL,
                   DATEMODIFICATION = LHIERARCHIE.DATEMODIFICATION
                  ,LIBCLASSPROD0    = LHIERARCHIE.LIBCLASSPROD
             WHERE CODECLASSPROD0 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''integration du' || PK_site.RetourneParametreSiteVarchar('LIBCLASSPROD0') || CHR(13) || SQLERRM(SQLCODE));
          END;
      END;
    END;
  
    PROCEDURE TRAITEMENT_CLASSPROD1 IS
    BEGIN
      BEGIN
        SELECT DateCREATION INTO LHIERARCHIE.DATECREATION FROM CLASSPROD1 WHERE CODECLASSPROD1 = LHIERARCHIE.CODECLASSPROD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          BEGIN
            SELECT DATECREATION INTO LHIERARCHIE.DATECREATION FROM INT_CLASSPROD1 WHERE CODECLASSPROD1 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LHIERARCHIE.DATECREATION := TRUNC(SYSDATE);
          END;
      END;
    
      BEGIN
        INSERT INTO INT_CLASSPROD1
          (CODECLASSPROD1
          ,ACCESSOIRES
          ,AUCATALOGUEWEB
          ,AUPLANDASSORTIMENT
          ,CODECLASSPROD0
          ,DATECREATION
          ,DATEFINVALIDITE
          ,DATEMODIFICATION
          ,LIBCLASSPROD1)
        VALUES
          (LHIERARCHIE.CODECLASSPROD
          ,0
          ,0
          ,0
          ,LHIERARCHIE.CODEPERE
          ,LHIERARCHIE.DATECREATION
          ,NULL
          ,LHIERARCHIE.DATEMODIFICATION
          ,LHIERARCHIE.LIBCLASSPROD);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          BEGIN
            BEGIN
              UPDATE INT_CLASSPROD1
                 SET ACCESSOIRES = 0
                    ,
                     --   AUCATALOGUEWEB = 0,
                     --   AUPLANDASSORTIMENT = 0,
                     CODECLASSPROD0 = LHIERARCHIE.CODEPERE
                    ,DATECREATION   = LHIERARCHIE.DATECREATION
                    ,
                     --   DATEFINVALIDITE = NULL,
                     DATEMODIFICATION = LHIERARCHIE.DATEMODIFICATION
                    ,LIBCLASSPROD1    = LHIERARCHIE.LIBCLASSPROD
               WHERE CODECLASSPROD1 = LHIERARCHIE.CODECLASSPROD;
            EXCEPTION
              WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001
                                       ,'Erreur lors de l''integration du' || PK_site.RetourneParametreSiteVarchar('LIBCLASSPROD1') || CHR(13) || SQLERRM(SQLCODE));
            END;
          END;
      END;
    END;
  
    PROCEDURE TRAITEMENT_CLASSPROD2 IS
    BEGIN
      BEGIN
        SELECT DateCREATION INTO LHIERARCHIE.DATECREATION FROM CLASSPROD2 WHERE CODECLASSPROD2 = LHIERARCHIE.CODECLASSPROD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          BEGIN
            SELECT DATECREATION INTO LHIERARCHIE.DATECREATION FROM INT_CLASSPROD2 WHERE CODECLASSPROD2 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LHIERARCHIE.DATECREATION := TRUNC(SYSDATE);
          END;
      END;
      BEGIN
        INSERT INTO INT_CLASSPROD2
          (CODECLASSPROD2
          ,CODECLASSPROD1
          ,DATECREATION
          ,DATEFINVALIDITE
          ,DATEMODIFICATION
          ,LIBCLASSPROD2)
        VALUES
          (LHIERARCHIE.CODECLASSPROD
          ,LHIERARCHIE.CODEPERE
          ,LHIERARCHIE.DATECREATION
          ,NULL
          ,LHIERARCHIE.DATEMODIFICATION
          ,LHIERARCHIE.LIBCLASSPROD);
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          BEGIN
            BEGIN
              UPDATE INT_CLASSPROD2
                 SET CODECLASSPROD1 = LHIERARCHIE.CODEPERE
                    ,DATECREATION   = LHIERARCHIE.DATECREATION
                    ,
                     --                DATEFINVALIDITE = NULL,
                     DATEMODIFICATION = LHIERARCHIE.DATEMODIFICATION
                    ,LIBCLASSPROD2    = LHIERARCHIE.LIBCLASSPROD
               WHERE CODECLASSPROD2 = LHIERARCHIE.CODECLASSPROD;
            EXCEPTION
              WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001
                                       ,'Erreur lors de l''integration du' || PK_site.RetourneParametreSiteVarchar('LIBCLASSPROD2') || CHR(13) || SQLERRM(SQLCODE));
              
            END;
          END;
      END;
    END;
  
    PROCEDURE TRAITEMENT_CLASSPROD3 IS
    BEGIN
      BEGIN
        SELECT DateCreation INTO LHIERARCHIE.DateCreation FROM CLASSPROD2 WHERE CODECLASSPROD2 = LHIERARCHIE.CODECLASSPROD;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          BEGIN
            SELECT DATECREATION INTO LHIERARCHIE.DATECREATION FROM INT_CLASSPROD2 WHERE CODECLASSPROD2 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LHIERARCHIE.DATECREATION := TRUNC(SYSDATE);
          END;
      END;
      BEGIN
        INSERT INTO INT_CLASSPROD3
          (CODECLASSPROD3
          ,CODECLASSPROD2
          ,CODETYPEETIQUETTE
          ,CODETYPEMETHODEREASSORT
          ,CODETYPEPRODUIT
          ,CODETYPEREASSORT
          ,CODETYPESTOCKAGE
          ,CODEUNITEGESTIONACHAT
          ,CODEUNITEGESTIONSTOCK
          ,CODEUNITEGESTIONVENTE
          ,COEF
          ,DATECREATION
          ,DATEFINVALIDITE
          ,DATEMODIFICATION
          ,DUREEDEVIE
          ,GESTIONENSTOCK
          ,GESTIONPARUNITEGESTION
          ,LIBCLASSPROD3
          ,NBDIMPRODUIT
          ,PCBCOLORIS
          ,SAISIEJAUGE
          ,SAISIEPOIDS
          ,SEUILREASSORTLOTPIECE
          ,SEUILREASSORTUNITEGEST
          ,TAUXMARGEMAXI
          ,TAUXMARGEMINI)
        VALUES
          (LHIERARCHIE.CODECLASSPROD
          ,LHIERARCHIE.CODEPERE
          ,1
          ,0
          ,1
          ,1
          ,1
          ,
           --         'PCE',
           --         'PCE',
           --         'PCE',
           '0'
          ,'0'
          ,'0'
          ,0
          ,LHIERARCHIE.DATECREATION
          ,NULL
          ,LHIERARCHIE.DATEMODIFICATION
          ,0
          ,1
          ,1
          ,LHIERARCHIE.LIBCLASSPROD
          ,2
          ,0
          ,0
          ,0
          ,0
          ,0
          ,0
          ,0);
      
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          BEGIN
            UPDATE INT_CLASSPROD3
               SET CODECLASSPROD2   = LHIERARCHIE.CODEPERE
                  ,DATECREATION     = LHIERARCHIE.DATECREATION
                  ,LIBCLASSPROD3    = LHIERARCHIE.LIBCLASSPROD
                  ,DATEMODIFICATION = LHIERARCHIE.DATEMODIFICATION
            
            /*              CODETYPEETIQUETTE = :LeCODETYPEETIQUETTE,
            CODETYPEMETHODEREASSORT = :LeCODETYPEMETHODEREASSORT,
            CODETYPEPRODUIT = :LeCODETYPEPRODUIT,
            CODETYPEREASSORT = :LeCODETYPEREASSORT,
            CODETYPESTOCKAGE = :LeCODETYPESTOCKAGE,
            CODEUNITEGESTIONACHAT = :LeCODEUNITEGESTIONACHAT,
            CODEUNITEGESTIONSTOCK = :LeCODEUNITEGESTIONSTOCK,
            CODEUNITEGESTIONVENTE = :LeCODEUNITEGESTIONVENTE,
            COEF = :LeCOEF,
            DATEFINVALIDITE = :LeDATEFINVALIDITE,
            DUREEDEVIE = :LeDUREEDEVIE,
            GESTIONENSTOCK = :LeGESTIONENSTOCK,
            GESTIONPARUNITEGESTION = :LeGESTIONPARUNITEGESTION,
            NBDIMPRODUIT = :LeNBDIMPRODUIT,
            PCBCOLORIS = :LePCBCOLORIS,
            SAISIEJAUGE = :LeSAISIEJAUGE,
            SAISIEPOIDS = :LeSAISIEPOIDS,
            SEUILREASSORTLOTPIECE = :LeSEUILREASSORTLOTPIECE,
            SEUILREASSORTUNITEGEST = :LeSEUILREASSORTUNITEGEST,
            TAUXMARGEMAXI = :LeTAUXMARGEMAXI,
            TAUXMARGEMINI = :LeTAUXMARGEMINI*/
             WHERE CODECLASSPROD3 = LHIERARCHIE.CODECLASSPROD;
          EXCEPTION
            WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''integration du' || PK_site.RetourneParametreSiteVarchar('LIBCLASSPROD3') || CHR(13) || SQLERRM(SQLCODE));
          END;
      END;
    END;
  BEGIN
    LeCodeMsg := 'BIZ-0003';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de l''integration des articles par LBM_HIERARCHIE');
  
    select ELEMENTCODE BULK COLLECT INTO TabLock from LBM_HIERARCHIE where messageid = CodeTraitement for update;
  
    FOR Ligne IN (SELECT * FROM LBM_HIERARCHIE where MESSAGEID = CodeTraitement order by elementniv) LOOP
      BEGIN
        IF Ligne.ELEMENTCODE IS NOT NULL THEN
          LHIERARCHIE.CODECLASSPROD    := Ligne.ElementCode;
          LHIERARCHIE.LIBCLASSPROD     := Ligne.ElementLib;
          LHIERARCHIE.CODEPERE         := Ligne.PereCode;
          LHIERARCHIE.ELEMENTNIV       := Ligne.ElementNiv;
          LHIERARCHIE.DATEMODIFICATION := TRUNC(SYSDATE);
          IF Ligne.ElementNiv = 0 THEN
            TRAITEMENT_CLASSPROD0;
          ELSIF Ligne.ElementNiv = 1 THEN
            TRAITEMENT_CLASSPROD1;
          ELSIF Ligne.ElementNiv = 2 THEN
            TRAITEMENT_CLASSPROD2;
          ELSIF Ligne.ElementNiv = 3 THEN
            TRAITEMENT_CLASSPROD3;
          ELSE
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Code niveau element non valide (' || Ligne.ElementNiv || ').');
          END IF;
          COMMIT;
        ELSE
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Le champ ELEMENTCODE n''est pas renseigne.');
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Erreur lors de l''insertion de l''element de hierarchie ' || Ligne.ElementCode || '(' || Ligne.PereCode || ') de niveau ' || Ligne.ElementNiv || ' :' || CHR(13) || SQLERRM(SQLCODE));
          Ajouter_Log_LBM('Hierarchie'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,SQLERRM(SQLCODE)
                         ,Ligne.ElementCode);
      END;
    END LOOP;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des articles par LBM_HIERARCHIE');
  END;

  /*******************************************************************/
  /*  Procedure LBM_Article                                          */
  /*                                                                 */
  /*  Integratrion des ARTICLES, PRODUITS, PRODUITS_COLORIS          */
  /*    depuis la table LBM_ARTICLES                                 */
  /*                                                                 */
  /*  SM 06/11/2006 #20104 Creation                                  */
  /*  DL 24/11/2006 #20104 Modification : ajout de la description    */
  /*                                      web du produit             */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_Article(CodeTraitement VARCHAR2) IS
    LeCodeMsg                    Log_Traitements.CodeMsg%TYPE;
    LeProduitExiste              NUMBER(1);
    LeProduitExisteDansTableTemp NUMBER(1);
    LeProduit                    TRecProduit;
    LeProduitColoris             TRecProduitColoris;
    LeArticle                    TRecArticle;
    LeTvaProduitPays             TRecTVAProduitPays;
    LeLockLigne                  VARCHAR2(50);
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock      TTabLock;
    Enseigne     NUMBER(6);
    LaxeEnseigne NUMBER(3);
  
  BEGIN
    LeCodeMsg := 'BIZ-0001';
  
    LaxeEnseigne := PK_SITE.RETOURNEPARAMETRESITENUMBER('AXESTATMARQUE');
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de l''integration des articles par LBM_ARTICLE');
  
    FOR Ligne IN (SELECT * FROM LBM_ARTICLE where MESSAGEID = CodeTraitement) LOOP
    
      -- On verifie si le produit existe deja dans les tables PRODUITS et INT_PRODUITS
      LeProduitExiste := 0;
    
      select ARTCODE BULK COLLECT
        INTO TabLock
        from LBM_ARTICLE
       where messageid = CodeTraitement
         and ArtCode = Ligne.ArtCode
         for update;
    
      BEGIN
        SELECT ProduitExiste
              ,CodeProduit
              ,DateCreation
          INTO LeProduitExiste
              ,LeProduit.CodeProduit
              ,LeProduit.DateCreation
          FROM (SELECT ProduitExiste
                      ,CodeProduit
                      ,DateCreation
                  FROM (SELECT 1 ProduitExiste
                              ,CodeProduit
                              ,DateCreation
                          FROM INT_PRODUITS
                         WHERE NomProduit = Ligne.ArtCode
                        UNION ALL
                        SELECT 1 ProduitExiste
                              ,CodeProduit
                              ,DateCreation
                          FROM PRODUITS
                         WHERE NomProduit = Ligne.ArtCode)
                 ORDER BY ProduitExiste DESC)
         WHERE RowNum = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LeProduitExiste := 0;
      END;
    
      BEGIN
        -- Recuperation des donnees BizTalk
        LeProduit.NomProduit     := Ligne.ArtCode;
        LeProduit.LibProduit     := replace(Ligne.ArtDes
                                           ,'|'
                                           ,' ');
        LeProduit.CodeClassProd3 := Ligne.CP;
        IF Ligne.UniteVt = 'PCE' THEN
          LeProduit.CodeUniteGestionVente := '0';
          LeProduit.CodeUniteGestionStock := '0';
          LeProduit.CodeUniteGestionAchat := '0';
        END IF;
      
        IF Ligne.UniteVt = 'CT' THEN
          LeProduit.CodeUniteGestionVente := '1';
          LeProduit.CodeUniteGestionStock := '1';
          LeProduit.CodeUniteGestionAchat := '1';
        END IF;
      
        IF Ligne.UniteVt = 'KG' THEN
          LeProduit.CodeUniteGestionVente := '2';
          LeProduit.CodeUniteGestionStock := '2';
          LeProduit.CodeUniteGestionAchat := '2';
        END IF;
      
        IF Ligne.UniteVt = 'L' THEN
          LeProduit.CodeUniteGestionVente := '3';
          LeProduit.CodeUniteGestionStock := '3';
          LeProduit.CodeUniteGestionAchat := '3';
        END IF;
      
        IF Ligne.UniteVt = 'MTR' THEN
          LeProduit.CodeUniteGestionVente := '4';
          LeProduit.CodeUniteGestionStock := '4';
          LeProduit.CodeUniteGestionAchat := '4';
        END IF;
      
        --   IF Ligne.ArtType = 'ZSER' THEN
        --           LeProduit.TypeProduit           := 6;
        --   ELSE
        --           LeProduit.TypeProduit           := 1;
        --   END IF;
        LeProduit.TypeProduit := 1;
      
        LeTvaProduitPays.CodeTVA := Ligne.CodeTVA;
      
        -- Positionnement des valeurs par defaut pour les champs non alimentes
        -- PRODUITS
        IF LeProduitExiste = 0 THEN
          -- Si le produit n'existe pas, on recupere un nouveau code produit depuis REF_CII
          LeProduit.CodeProduit  := RETOURNE_CODESUIVANT('PRODUITS'
                                                        ,NULL);
          LeProduit.DateCreation := TRUNC(SYSDATE);
        END IF;
        LeProduit.CodeSaison         := 'PERM';
        LeProduit.CodeGrilleTaille   := 1;
        LeProduit.CodeTypeEtiquette  := 1;
        LeProduit.CodeDouanier       := NULL;
        LeProduit.CodeTypeStockage   := 1;
        LeProduit.PoidsProduit       := 0;
        LeProduit.VolumeProduit      := 0;
        LeProduit.EpaisseurProduit   := 0;
        LeProduit.Observations       := NULL;
        LeProduit.CodeUtilisateur    := 0;
        LeProduit.DateModification   := TRUNC(SYSDATE);
        LeProduit.CodeGrilleVariante := 0;
        IF Ligne.CodeMaj = 3 THEN
          -- Suppression de l'article
          LeProduit.DateSuppression := TRUNC(SYSDATE);
        ELSE
          LeProduit.DateSuppression := NULL;
        END IF;
        LeProduit.CodeColorisSel            := 1;
        LeProduit.ProduitGratuit            := 0;
        LeProduit.AuCatalogueWeb            := 0;
        LeProduit.DateFinVie                := NULL;
        LeProduit.Poids                     := 0;
        LeProduit.Jauge                     := 0;
        LeProduit.UniteLogistique           := 1;
        LeProduit.CodeTypeReassort          := 1;
        LeProduit.CodePaysOrigine           := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
        LeProduit.ObservationsSurBC         := NULL;
        LeProduit.CodePaysOrigineMatiere    := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
        LeProduit.LongueurProduit           := 0;
        LeProduit.HauteurProduit            := 0;
        LeProduit.CodeTypeEmballage         := 0;
        LeProduit.DelaiReassort             := NULL;
        LeProduit.DureeDeVie                := NULL;
        LeProduit.CodeTypeMethodeReassort   := NULL;
        LeProduit.ZoneDeDoute               := NULL;
        LeProduit.DateFinCdeDirecte         := NULL;
        LeProduit.CodeUnitePresentation     := NULL;
        LeProduit.NbPieceParUnitePresent    := 0;
        LeProduit.DateModificationAssort    := NULL;
        LeProduit.ExclusionFidelite         := 0;
        LeProduit.CodeDouanier2             := NULL;
        LeProduit.IndiceTailleBase          := 1;
        LeProduit.DateModificationTfj       := SYSDATE;
        LeProduit.NbPiecesParUniteRangement := 0;
      
        -- PRODUITSQ_COLORIS
        LeProduitColoris.CodeProduit       := LeProduit.CodeProduit;
        LeProduitColoris.CodeColoris       := 1;
        LeProduitColoris.LibColorisModifie := NULL;
        LeProduitColoris.CodeCourbeDeVie   := NULL;
        LeProduitColoris.CodeEtat          := 3;
        IF LeProduitExiste = 0 THEN
          LeProduitColoris.DateCreation := TRUNC(SYSDATE);
        ELSE
          LeProduitColoris.DateCreation := LeProduit.DateCreation;
        END IF;
        LeProduitColoris.DateModification  := TRUNC(SYSDATE);
        LeProduitColoris.CodeSaisonGestion := 'PERM';
        --DLA le 13/03/2007 : gestion de la suppression
        IF Ligne.CodeMaj = 3 THEN
          LeProduitColoris.CodeEtat        := 9;
          LeProduitColoris.DateSuppression := TRUNC(SYSDATE);
        ELSE
          LeProduitColoris.DateSuppression := NULL;
        END IF;
        --DLA le 13/03/2007 : FIN gestion de la suppression
        LeProduitColoris.CodeCibleImplantation      := 99;
        LeProduitColoris.DateModifCibleImplantation := TRUNC(SYSDATE);
        LeProduitColoris.DateDebutSaisonGestion     := TRUNC(SYSDATE);
        LeProduitColoris.DateImplantationPrevue     := TRUNC(SYSDATE);
        LeProduitColoris.AReimplanter               := 0;
        LeProduitColoris.CodeEtatImplantation       := NULL;
        LeProduitColoris.CodeEtatPourPalmares       := NULL;
      
        -- ARTICLES
        IF LeProduitExiste = 0 THEN
          -- Si l'article n'existe pas, on recupere un nouveau code interne article depuis REF_CII
          LeArticle.CodeInterneArticle := RETOURNE_CODESUIVANT('ARTICLES'
                                                              ,NULL);
        ELSE
          -- Sinon on recherche le COdeInterneArticle correspondant au CodeProduit
          BEGIN
            SELECT CodeInterneArticle
              INTO LeArticle.CodeInterneArticle
              FROM (SELECT CodeInterneArticle
                      FROM INT_ARTICLES
                     WHERE CodeProduit = LeProduit.CodeProduit
                    UNION ALL
                    SELECT CodeInterneArticle FROM ARTICLES WHERE CodeProduit = LeProduit.CodeProduit)
             WHERE ROWNUM = 1;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LeArticle.CodeInterneArticle := RETOURNE_CODESUIVANT('ARTICLES'
                                                                  ,NULL);
              LeProduitExiste              := 0;
          END;
        END IF;
        LeArticle.CodeProduit        := LeProduit.CodeProduit;
        LeArticle.CodeColoris        := 1;
        LeArticle.CodeGrilleTaille   := 1;
        LeArticle.Indice             := 1;
        LeArticle.CodeGrilleVariante := 0;
        LeArticle.IndiceVariante     := 0;
        LeArticle.CodeBarres         := CONSTRUIRE_CODEBARRES_ARTICLE(LeArticle.CodeProduit
                                                                     ,LeArticle.CodeColoris
                                                                     ,LeArticle.CodeInterneArticle
                                                                     ,LeArticle.CodeGrilleTaille
                                                                     ,LeArticle.Indice
                                                                     ,LeArticle.IndiceVariante);
        LeArticle.QteTotaleAchetee   := 0;
        LeArticle.QteAcheteeReinit   := 0;
        LeArticle.ValTotaleAchatHt   := 0;
        LeArticle.ValAchatHtReinit   := 0;
        LeArticle.CodeDevise         := NULL;
        --DLA le 05/03/2007
        IF Ligne.ArtType = 'ZILL' THEN
          LeArticle.CodeEtat := 99;
        ELSE
          LeArticle.CodeEtat := 3;
        END IF;
        --        LeArticle.CodeEtat           := 3;
        LeArticle.ArretReassort := 0;
        IF LeProduitExiste = 0 THEN
          LeArticle.DateCreation := TRUNC(SYSDATE);
        ELSE
          LeArticle.DateCreation := LeProduit.DateCreation;
        END IF;
        LeArticle.DateModification := TRUNC(SYSDATE);
        LeArticle.DateSuppression  := NULL;
        LeArticle.GereEnStock      := 1;
        LeArticle.NonRemise        := 0;
        LeArticle.StkOptimalMini   := 0;
        LeArticle.StkOptimalMaxi   := 0;
        LeArticle.ArticleCentrale  := 0;
        LeArticle.PrixRevientInd   := 0;
        --DLA le 28/12/2006 : ajout de la nature
        IF Ligne.PR = 'PR' then
          LeArticle.CodeNature := 1;
        ELSE
          LeArticle.CodeNature := NULL;
        END IF;
        --DLA le 28/12/2006 : FIN ajout de la nature
        --DLA le 13/03/2007 : gestion de la suppression
        IF Ligne.CodeMaj = 3 THEN
          LeArticle.DateSuppression := Trunc(SYSDATE);
          LeArticle.CodeEtat        := 9;
          LeArticle.ArretReassort   := 1;
        END IF;
        --DLA le 13/03/2007 : FIN gestion de la suppression
      
        -- TVA_PRODUIT_PAYS
        LeTvaProduitPays.CODEPAYS    := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
        LeTvaProduitPays.CODEPRODUIT := LeProduit.CodeProduit;
        LeTvaProduitPays.CODETVA     := Ligne.CodeTVA;
      
        -- Insertion des donnees dans les tables tampon STORELAND
        IF LeProduitExiste = 1 THEN
          BEGIN
            SELECT 1 INTO LeProduitExisteDansTableTemp FROM INT_PRODUITS WHERE NomProduit = Ligne.ArtCode;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LeProduitExisteDansTableTemp := 0;
          END;
        ELSE
          LeProduitExisteDansTableTemp := 0;
        END IF;
      
        IF LeProduitExisteDansTableTemp = 0 THEN
          -- Insertion
          BEGIN
            INSERT INTO INT_PRODUITS
              (CODEPRODUIT
              ,NOMPRODUIT
              ,LIBPRODUIT
              ,CODESAISON
              ,CODECLASSPROD3
              ,CODEGRILLETAILLE
              ,CODETYPEETIQUETTE
              ,CODEDOUANIER
              ,CODETYPESTOCKAGE
              ,POIDSPRODUIT
              ,VOLUMEPRODUIT
              ,EPAISSEURPRODUIT
              ,OBSERVATIONS
              ,CODEUTILISATEUR
              ,DATECREATION
              ,DATEMODIFICATION
              ,CODEGRILLEVARIANTE
              ,DATESUPPRESSION
              ,CODECOLORISSEL
              ,PRODUITGRATUIT
              ,AUCATALOGUEWEB
              ,DATEFINVIE
              ,POIDS
              ,JAUGE
              ,UNITELOGISTIQUE
              ,TYPEPRODUIT
              ,CODETYPEREASSORT
              ,CODEPAYSORIGINE
              ,OBSERVATIONSSURBC
              ,CODEPAYSORIGINEMATIERE
              ,LONGUEURPRODUIT
              ,HAUTEURPRODUIT
              ,CODETYPEEMBALLAGE
              ,DELAIREASSORT
              ,DUREEDEVIE
              ,CODETYPEMETHODEREASSORT
              ,ZONEDEDOUTE
              ,DATEFINCDEDIRECTE
              ,CODEUNITEPRESENTATION
              ,NBPIECEPARUNITEPRESENT
              ,DATEMODIFICATIONASSORT
              ,EXCLUSIONFIDELITE
              ,CODEDOUANIER2
              ,CODEUNITEGESTIONVENTE
              ,CODEUNITEGESTIONSTOCK
              ,CODEUNITEGESTIONACHAT
              ,INDICETAILLEBASE
              ,DATEMODIFICATIONTFJ
              ,NBPIECESPARUNITERANGEMENT)
            VALUES
              (LeProduit.CodeProduit
              ,LeProduit.NomProduit
              ,LeProduit.LibProduit
              ,LeProduit.CodeSaison
              ,LeProduit.CodeClassProd3
              ,LeProduit.CodeGrilleTaille
              ,LeProduit.CodeTypeEtiquette
              ,LeProduit.CodeDouanier
              ,LeProduit.CodeTypeStockage
              ,LeProduit.PoidsProduit
              ,LeProduit.VolumeProduit
              ,LeProduit.EpaisseurProduit
              ,LeProduit.Observations
              ,LeProduit.CodeUtilisateur
              ,LeProduit.DateCreation
              ,LeProduit.DateModification
              ,LeProduit.CodeGrilleVariante
              ,LeProduit.DateSuppression
              ,LeProduit.CodeColorisSel
              ,LeProduit.ProduitGratuit
              ,LeProduit.AuCatalogueWeb
              ,LeProduit.DateFinVie
              ,LeProduit.Poids
              ,LeProduit.Jauge
              ,LeProduit.UniteLogistique
              ,LeProduit.TypeProduit
              ,LeProduit.CodeTypeReassort
              ,LeProduit.CodePaysOrigine
              ,LeProduit.ObservationsSurBC
              ,LeProduit.CodePaysOrigineMatiere
              ,LeProduit.LongueurProduit
              ,LeProduit.HauteurProduit
              ,LeProduit.CodeTypeEmballage
              ,LeProduit.DelaiReassort
              ,LeProduit.DureeDeVie
              ,LeProduit.CodeTypeMethodeReassort
              ,LeProduit.ZoneDeDoute
              ,LeProduit.DateFinCdeDirecte
              ,LeProduit.CodeUnitePresentation
              ,LeProduit.NbPieceParUnitePresent
              ,LeProduit.DateModificationAssort
              ,LeProduit.ExclusionFidelite
              ,LeProduit.CodeDouanier2
              ,LeProduit.CodeUniteGestionVente
              ,LeProduit.CodeUniteGestionStock
              ,LeProduit.CodeUniteGestionAchat
              ,LeProduit.IndiceTailleBase
              ,LeProduit.DateModificationTfj
              ,LeProduit.NbPiecesParUniteRangement);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion du produit ' || Ligne.ArtCode || ' : ' || CHR(13) || SQLERRM(SQLCODE));
          END;
        
          BEGIN
            INSERT INTO INT_PRODUITS_COLORIS
              (CODEPRODUIT
              ,CODECOLORIS
              ,LIBCOLORISMODIFIE
              ,CODECOURBEDEVIE
              ,CODEETAT
              ,DATECREATION
              ,DATEMODIFICATION
              ,CODESAISONGESTION
              ,DATESUPPRESSION
              ,CODECIBLEIMPLANTATION
              ,DATEMODIFCIBLEIMPLANTATION
              ,DATEDEBUTSAISONGESTION
              ,DATEIMPLANTATIONPREVUE
              ,AREIMPLANTER
              ,CODEETATIMPLANTATION
              ,CODEETATPOURPALMARES)
            VALUES
              (LeProduitColoris.CodeProduit
              ,LeProduitColoris.CodeColoris
              ,LeProduitColoris.LibColorisModifie
              ,LeProduitColoris.CodeCourbeDeVie
              ,LeProduitColoris.CodeEtat
              ,LeProduitColoris.DateCreation
              ,LeProduitColoris.DateModification
              ,LeProduitColoris.CodeSaisonGestion
              ,LeProduitColoris.DateSuppression
              ,LeProduitColoris.CodeCibleImplantation
              ,LeProduitColoris.DateModifCibleImplantation
              ,LeProduitColoris.DateDebutSaisonGestion
              ,LeProduitColoris.DateImplantationPrevue
              ,LeProduitColoris.AReimplanter
              ,LeProduitColoris.CodeEtatImplantation
              ,LeProduitColoris.CodeEtatPourPalmares);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion du produit/coloris ' || Ligne.ArtCode || '/1 : ' || CHR(13) || SQLERRM(SQLCODE));
          END;
        
          BEGIN
            INSERT INTO INT_ARTICLES
              (CODEINTERNEARTICLE
              ,CODEPRODUIT
              ,CODECOLORIS
              ,CODEGRILLETAILLE
              ,INDICE
              ,CODEBARRES
              ,QTETOTALEACHETEE
              ,QTEACHETEEREINIT
              ,VALTOTALEACHATHT
              ,VALACHATHTREINIT
              ,CODEDEVISE
              ,CODEETAT
              ,ARRETREASSORT
              ,DATECREATION
              ,DATEMODIFICATION
              ,CODEGRILLEVARIANTE
              ,INDICEVARIANTE
              ,GEREENSTOCK
              ,NONREMISE
              ,STKOPTIMALMINI
              ,STKOPTIMALMAXI
              ,ARTICLECENTRALE
              ,PRIXREVIENTIND
              ,PCB
              ,DATESUPPRESSION
              ,CODENATURE)
            VALUES
              (LeArticle.CodeInterneArticle
              ,LeArticle.CodeProduit
              ,LeArticle.CodeColoris
              ,LeArticle.CodeGrilleTaille
              ,LeArticle.Indice
              ,LeArticle.CodeBarres
              ,LeArticle.QteTotaleAchetee
              ,LeArticle.QteAcheteeReinit
              ,LeArticle.ValTotaleAchatHT
              ,LeArticle.ValAchatHTReinit
              ,LeArticle.CodeDevise
              ,LeArticle.CodeEtat
              ,LeArticle.ArretReassort
              ,LeArticle.DateCreation
              ,LeArticle.DateModification
              ,LeArticle.CodeGrilleVariante
              ,LeArticle.IndiceVariante
              ,LeArticle.GereEnStock
              ,LeArticle.NonRemise
              ,LeArticle.StkOptimalMini
              ,LeArticle.StkOptimalMaxi
              ,LeArticle.ArticleCentrale
              ,LeArticle.PrixRevientInd
              ,LeArticle.PCB
              ,LeArticle.DateSuppression
              ,LeArticle.CodeNature);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion de l''article pour le produit ' || Ligne.ArtCode || ' : ' || CHR(13) || SQLERRM(SQLCODE));
          END;
        
          BEGIN
            INSERT INTO INT_TVA_PRODUIT_PAYS
              (CODEPAYS
              ,CODEPRODUIT
              ,CODETVA)
            VALUES
              (LeTvaProduitPays.CodePays
              ,LeTvaProduitPays.CodeProduit
              ,LeTvaProduitPays.CodeTVA);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion de la TVA Produit/Pays pour le produit ' || Ligne.ArtCode || ' : ' || CHR(13) || SQLERRM(SQLCODE));
          END;
        
          BEGIN
            INSERT INTO INT_DESCRIPTIONS_PRODUIT_WEB
              (CODEPRODUIT
              ,LIBELLECOURT
              ,LIBELLELONG
              ,CODELANGUE)
            VALUES
              (LeProduit.CODEPRODUIT
              ,substr(LeProduit.CodeClassProd3
                     ,-5
                     ,5) || ' ' || replace(Ligne.ArtLib
                                          ,'|'
                                          ,' ')
              ,NULL
              ,1);
          EXCEPTION
            WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion de la description web Produit pour le produit ' || Ligne.ArtCode || ' : ' || CHR(13) || SQLERRM(SQLCODE));
          END;
        
          BEGIN
            BEGIN
              SELECT c1.CodeClassProd0
                INTO Enseigne
                FROM CLASSPROD1 c1
                    ,CLASSPROD2 c2
                    ,CLASSPROD3 c3
               WHERE c3.CodeClassProd3 = LeProduit.CODECLASSPROD3
                 AND c2.CodeClassProd2 = c3.CodeClassProd2
                 AND c1.CodeClassProd1 = c2.CodeClassProd1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                BEGIN
                  SELECT c1.CodeClassProd0
                    INTO Enseigne
                    FROM INT_CLASSPROD1 c1
                        ,INT_CLASSPROD2 c2
                        ,INT_CLASSPROD3 c3
                   WHERE c3.CodeClassProd3 = LeProduit.CODECLASSPROD3
                     AND c2.CodeClassProd2 = c3.CodeClassProd2
                     AND c1.CodeClassProd1 = c2.CodeClassProd1;
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                    Enseigne := NULL;
                END;
            END;
            INSERT INTO INT_STATS_PRODUIT_COLORIS
              (CODEPRODUIT
              ,CODECOLORIS
              ,CODEAXESTAT
              ,CODEELEMENTSTAT
              ,DATEDEBUT)
            VALUES
              (LeArticle.CodeProduit
              ,0
              ,LaxeEnseigne
              ,Enseigne
              ,trunc(SYSDATE));
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              NULL;
          END;
        ELSE
          -- Mise a jour
          UPDATE INT_PRODUITS
             SET LIBPRODUIT        = LeProduit.LibProduit
                ,CODESAISON        = LeProduit.CodeSaison
                ,CODECLASSPROD3    = LeProduit.CodeClassProd3
                ,CODEGRILLETAILLE  = LeProduit.CodeGrilleTaille
                ,CODETYPEETIQUETTE = LeProduit.CodeTypeEtiquette
                ,CODEDOUANIER      = LeProduit.CodeDouanier
                ,CODETYPESTOCKAGE  = LeProduit.CodeTypeStockage
                ,POIDSPRODUIT      = LeProduit.PoidsProduit
                ,VOLUMEPRODUIT     = LeProduit.VolumeProduit
                ,EPAISSEURPRODUIT  = LeProduit.EpaisseurProduit
                ,OBSERVATIONS      = LeProduit.Observations
                ,CODEUTILISATEUR   = LeProduit.CodeUtilisateur
                ,
                 --              DATECREATION              = LeProduit.DateCreation,
                 DATEMODIFICATION          = LeProduit.DateModification
                ,CODEGRILLEVARIANTE        = LeProduit.CodeGrilleVariante
                ,DATESUPPRESSION           = LeProduit.DateSuppression
                ,CODECOLORISSEL            = LeProduit.CodeColorisSel
                ,PRODUITGRATUIT            = LeProduit.ProduitGratuit
                ,AUCATALOGUEWEB            = LeProduit.AuCatalogueWeb
                ,DATEFINVIE                = LeProduit.DateFinVie
                ,POIDS                     = LeProduit.Poids
                ,JAUGE                     = LeProduit.Jauge
                ,UNITELOGISTIQUE           = LeProduit.UniteLogistique
                ,TYPEPRODUIT               = LeProduit.TypeProduit
                ,CODETYPEREASSORT          = LeProduit.CodeTypeReassort
                ,CODEPAYSORIGINE           = LeProduit.CodePaysOrigine
                ,OBSERVATIONSSURBC         = LeProduit.ObservationsSurBC
                ,CODEPAYSORIGINEMATIERE    = LeProduit.CodePaysOrigineMatiere
                ,LONGUEURPRODUIT           = LeProduit.LongueurProduit
                ,HAUTEURPRODUIT            = LeProduit.HauteurProduit
                ,CODETYPEEMBALLAGE         = LeProduit.CodeTypeEmballage
                ,DELAIREASSORT             = LeProduit.DelaiReassort
                ,DUREEDEVIE                = LeProduit.DureeDeVie
                ,CODETYPEMETHODEREASSORT   = LeProduit.CodeTypeMethodeReassort
                ,ZONEDEDOUTE               = LeProduit.ZoneDeDoute
                ,DATEFINCDEDIRECTE         = LeProduit.DateFinCdeDirecte
                ,CODEUNITEPRESENTATION     = LeProduit.CodeUnitePresentation
                ,NBPIECEPARUNITEPRESENT    = LeProduit.NbPieceParUnitePresent
                ,DATEMODIFICATIONASSORT    = LeProduit.DateModificationAssort
                ,EXCLUSIONFIDELITE         = LeProduit.ExclusionFidelite
                ,CODEDOUANIER2             = LeProduit.CodeDouanier2
                ,CODEUNITEGESTIONVENTE     = LeProduit.CodeUniteGestionVente
                ,CODEUNITEGESTIONSTOCK     = LeProduit.CodeUniteGestionStock
                ,CODEUNITEGESTIONACHAT     = LeProduit.CodeUniteGestionAchat
                ,INDICETAILLEBASE          = LeProduit.IndiceTailleBase
                ,DATEMODIFICATIONTFJ       = LeProduit.DateModificationTfj
                ,NBPIECESPARUNITERANGEMENT = LeProduit.NbPiecesParUniteRangement
           WHERE CODEPRODUIT = LeProduit.CodeProduit
             AND NOMPRODUIT = LeProduit.NomProduit;
        
          IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de la mise a jour de la table INT_PRODUIT : Aucun enregistrement trouve pour le produit ' || LeProduit.CodeProduit || ' (' || Ligne.ArtCode || ').');
          END IF;
        
          UPDATE INT_PRODUITS_COLORIS
             SET LIBCOLORISMODIFIE = LeProduitColoris.LibColorisModifie
                ,CODECOURBEDEVIE   = LeProduitColoris.CodeCourbeDeVie
                ,CODEETAT          = LeProduitColoris.CodeEtat
                ,
                 --              DATECREATION               = LeProduitColoris.DateCreation,
                 DATEMODIFICATION           = LeProduitColoris.DateModification
                ,CODESAISONGESTION          = LeProduitColoris.CodeSaisonGestion
                ,DATESUPPRESSION            = LeProduitColoris.DateSuppression
                ,CODECIBLEIMPLANTATION      = LeProduitColoris.CodeCibleImplantation
                ,DATEMODIFCIBLEIMPLANTATION = LeProduitColoris.DateModifCibleImplantation
                ,DATEDEBUTSAISONGESTION     = LeProduitColoris.DateDebutSaisonGestion
                ,DATEIMPLANTATIONPREVUE     = LeProduitColoris.DateImplantationPrevue
                ,AREIMPLANTER               = LeProduitColoris.AReimplanter
                ,CODEETATIMPLANTATION       = LeProduitColoris.CodeEtatImplantation
                ,CODEETATPOURPALMARES       = LeProduitColoris.CodeEtatPourPalmares
           WHERE CODEPRODUIT = LeProduitColoris.CodeProduit
             AND CODECOLORIS = LeProduitColoris.CodeColoris;
        
          IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de la mise a jour de la table INT_PRODUITS_COLORIS : Aucun enregistrement trouve pour le produit/coloris ' || LeProduitColoris.CodeProduit || '/' || LeProduitColoris.CodeColoris || ' (' || Ligne.ArtCode || ').');
          END IF;
        
          UPDATE INT_ARTICLES
             SET CODEPRODUIT      = LeArticle.CodeProduit
                ,CODECOLORIS      = LeArticle.CodeColoris
                ,CODEGRILLETAILLE = LeArticle.CodeGrilleTaille
                ,INDICE           = LeArticle.Indice
                ,CODEBARRES       = LeArticle.CodeBarres
                ,QTETOTALEACHETEE = LeArticle.QteTotaleAchetee
                ,QTEACHETEEREINIT = LeArticle.QteAcheteeReinit
                ,VALTOTALEACHATHT = LeArticle.ValTotaleAchatHT
                ,VALACHATHTREINIT = LeArticle.ValAchatHTReinit
                ,CODEDEVISE       = LeArticle.CodeDevise
                ,CODEETAT         = LeArticle.CodeEtat
                ,ARRETREASSORT    = LeArticle.ArretReassort
                ,
                 --              DATECREATION         = LeArticle.DateCreation,
                 DATEMODIFICATION   = LeArticle.DateModification
                ,CODEGRILLEVARIANTE = LeArticle.CodeGrilleVariante
                ,INDICEVARIANTE     = LeArticle.IndiceVariante
                ,GEREENSTOCK        = LeArticle.GereEnStock
                ,NONREMISE          = LeArticle.NonRemise
                ,STKOPTIMALMINI     = LeArticle.StkOptimalMini
                ,STKOPTIMALMAXI     = LeArticle.StkOptimalMaxi
                ,ARTICLECENTRALE    = LeArticle.ArticleCentrale
                ,PRIXREVIENTIND     = LeArticle.PrixRevientInd
                ,PCB                = LeArticle.PCB
                ,DATESUPPRESSION    = LeArticle.DateSuppression
           WHERE CODEINTERNEARTICLE = LeArticle.CodeInterneArticle;
        
          IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de la mise a jour de la table INT_ARTICLES : Aucun enregistrement trouve pour le CodeInterneArticle ' || LeArticle.CodeInterneArticle || ' (' || Ligne.ArtCode || ').');
          END IF;
        
          UPDATE INT_TVA_PRODUIT_PAYS
             SET CODETVA = LeTvaProduitPays.CodeTVA
           WHERE CODEPRODUIT = LeTvaProduitPays.CodeProduit
             AND CODEPAYS = LeTvaProduitPays.CodePays;
        
          IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de la mise a jour de la table INT_TVA_PRODUIT_PAYS : Aucun enregistrement trouve pour le Produit/Pays ' || LeTvaProduitPays.CodeProduit || '/' || LeTvaProduitPays.CodePays || ' (' || Ligne.ArtCode || ').');
          END IF;
        
          UPDATE INT_Descriptions_Produit_Web
             SET LIBELLECOURT = substr(LeProduit.CodeClassProd3
                                      ,-5
                                      ,5)
           WHERE CODEPRODUIT = LeProduit.CodeProduit
             AND CODELANGUE = 1;
        
          IF SQL%NOTFOUND THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de la mise a jour de la table INT_Descriptions_Produit_Web : Aucun enregistrement trouve pour le Produit ' || LeTvaProduitPays.CodeProduit);
          END IF;
        
        END IF;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de l''integration de l''article ' || Ligne.ArtCode || '.' || CHR(13) || SQLERRM(SQLCODE));
          Ajouter_Log_LBM('Article'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,SQLERRM(SQLCODE)
                         ,Ligne.ArtCode);
      END;
    END LOOP;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des articles par LBM_ARTICLE');
  END;

  /*******************************************************************/
  /*  Procedure LBM_EAN                                              */
  /*                                                                 */
  /*  Integratrion des articles                                      */
  /*    depuis la table LBM_EAN                                      */
  /*                                                                 */
  /*  PB 06/11/2006 #20104 Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_EAN(CodeTraitement VARCHAR2) IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
    LEAN      TRecEAN;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock TTabLock;
  
  BEGIN
    LeCodeMsg := 'BIZ-0002';
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration des articles par LBM_EAN');
    FOR Ligne IN (SELECT * FROM LBM_EAN where MESSAGEID = codetraitement) LOOP
      BEGIN
        select ARTCODE BULK COLLECT
          INTO TabLock
          from LBM_EAN
         where messageid = CodeTraitement
           and ARTCODE = Ligne.ArtCode
           for update;
        BEGIN
          SELECT a.CodeInterneArticle
                ,a.DateCreation
            INTO LEAN.CODEINTERNEARTICLE
                ,LEAN.DATECREATION
            FROM ARTICLES a
                ,Produits p
           WHERE a.CodeProduit = p.CodeProduit
             AND p.NomProduit = Ligne.ArtCode;
        
          --DLA le 02/01/2007 : pour l'instant, pas de gestion de code fournisseur
          --           BEGIN
          --             SELECT af.CodeFournisseur INTO LEAN.CODEFOURNISSEUR
          --             FROM ARTICLES_FOURNISSEURS af
          --             WHERE af.CodeInterneArticle = LEAN.CODEINTERNEARTICLE
          --             AND NOORDRE = 1;
          --           EXCEPTION
          --             WHEN NO_DATA_FOUND THEN
          --               LEAN.CODEFOURNISSEUR := '1';
          --           END;
        
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            BEGIN
              --              LEAN.CODEFOURNISSEUR := '1';
              SELECT ia.CodeInterneArticle
                    ,ia.DateCreation
                INTO LEAN.CODEINTERNEARTICLE
                    ,LEAN.DATECREATION
                FROM INT_ARTICLES ia
                    ,INT_PRODUITS ip
               WHERE ia.CodeProduit = ip.CodeProduit
                 AND ip.NomProduit = Ligne.ArtCode;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                LEAN.CODEINTERNEARTICLE := 0;
            END;
        END;
      
        IF LEAN.CodeInterneArticle <> 0 THEN
        
          --DLA le 13/04/2007 : on supprime les EAN dans Histo_CB_Frn
          -- car on fait un annule et remplace complet
        
          DELETE FROM HISTO_CB_FRN WHERE CodeInterneArticle = LEAN.CODEINTERNEARTICLE;
        
          -- recuperation des donnees BizTalk
        
          LEAN.DateFinApplication  := Ligne.EANDateFin;
          LEAN.CodeBarres          := Ligne.EAN;
          LEAN.CODEFOURNISSEUR     := 1;
          LEAN.RefFournisseur      := NULL;
          LEAN.ColorisFournisseur  := NULL;
          LEAN.TailleFournisseur   := NULL;
          LEAN.VarianteFournisseur := NULL;
        
          BEGIN
            INSERT INTO INT_HISTO_CB_FRN
              (CodeFournisseur
              ,CodeBarres
              ,CodeInterneArticle
              ,ColorisFournisseur
              ,DateCreation
              ,DateFinApplication
              ,RefFournisseur
              ,TailleFournisseur
              ,VarianteFournisseur)
            VALUES
              (LEAN.CodeFournisseur
              ,LEAN.CodeBarres
              ,LEAN.CodeInterneArticle
              ,LEAN.ColorisFournisseur
              ,LEAN.DateCreation
              ,LEAN.DateFinApplication
              ,LEAN.RefFournisseur
              ,LEAN.TailleFournisseur
              ,LEAN.VarianteFournisseur);
          EXCEPTION
            -- DLA le 02/01/2007 : pas de gestion de mise a jour, on recoit tous les EAN
            -- si duplication de cle, on ignore
            --             WHEN DUP_VAL_ON_INDEX THEN
            --               BEGIN
            --                 UPDATE INT_HISTO_CB_FRN
            --                 SET CodeBarres         = LEAN.CodeBarres,
            --                     CodeInterneArticle = LEAN.CodeInterneArticle,
            --                     ColorisFournisseur = LEAN.ColorisFournisseur,
            --                     DateCreation       = LEAN.DateCreation,
            --                     DateFinApplication = LEAN.DateFinApplication,
            --                     RefFournisseur     = LEAN.RefFournisseur,
            --                     TailleFournisseur  = LEAN.TailleFournisseur,
            --                     VarianteFournisseur = LEAN.VarianteFournisseur
            --                 WHERE CodeBarres        = LEAN.CodeBarres
            --                 AND CodeFournisseur     = LEAN.CodeFournisseur
            --                 AND CodeInterneArticle  = LEAN.CodeInterneArticle
            --                 AND DateFinApplication  = LEAN.DateFinApplication;
            --               EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              NULL;
            WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001
                                     ,'Erreur lors de l''insertion des donnees dans la table INT_HISTO_CB_FRN : ' || SQLERRM(SQLCODE));
              --               END;
          END;
          COMMIT;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de l''integration de l''article ' || Ligne.ArtCode || '.' || CHR(13) || SQLERRM(SQLCODE));
          Ajouter_Log_LBM('Article'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,SQLERRM(SQLCODE)
                         ,Ligne.ArtCode);
      END;
    END LOOP;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des articles par LBM_EAN');
  END;

  /*******************************************************************/
  /*  Procedure LBM_Tarif                                            */
  /*                                                                 */
  /*  Integratrion des tarifs                                        */
  /*    depuis la table LBM_tarif                                    */
  /*                                                                 */
  /*  DL 06/11/2006        Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_TARIF(CodeTraitement VARCHAR2) IS
    LeCodeMsg            Log_Traitements.CodeMsg%TYPE;
    LeCodeInterneArticle articles.CodeINterneArticle%TYPE;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock TTabLock;
  
    PROCEDURE TRAITEMENT_TARIFS_EN_COURS IS
      LTARIF TRecTARIF;
    BEGIN
      FOR Ligne IN (SELECT *
                      FROM LBM_TARIF
                     WHERE MESSAGEID = CodeTraitement
                       AND DateDebut <= SYSDATE
                          --                    AND   PlanLib IS NULL
                          --DLA le 01/03/2007
                       AND TYPECOND = 'VKP0'
                    UNION ALL
                    SELECT *
                      FROM LBM_TARIF
                     WHERE MESSAGEID = CodeTraitement
                       AND DateDebut > SYSDATE
                          --                          AND   PlanLib IS NULL
                          --DLA le 01/03/2007
                       AND TYPECOND = 'VKP0'
                       AND (artcode, datedebut) in (select artcode
                                                          ,min(datedebut)
                                                      FROM LBM_TARIF
                                                     WHERE MESSAGEID = CodeTraitement
                                                       AND DateDebut > SYSDATE
                                                       AND TYPECOND = 'VKP0'
                                                     group by artcode)) LOOP
        SELECT ARTCODE BULK COLLECT
          INTO TabLock
          FROM LBM_TARIF
         WHERE messageid = CodeTraitement
           AND ARTCODE = Ligne.ArtCode
           FOR UPDATE;
      
        BEGIN
          SELECT a.CodeInterneArticle
                ,a.DateCreation
            INTO LTARIF.CODEINTERNEARTICLE
                ,LTARIF.DATECREATION
            FROM ARTICLES a
                ,Produits p
           WHERE a.CodeProduit = p.CodeProduit
             AND p.NomProduit = Ligne.ArtCode;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            LTARIF.CODEINTERNEARTICLE := 0;
        END;
      
        IF LTARIF.CodeInterneArticle = 0 THEN
          BEGIN
            SELECT a.CodeInterneArticle
                  ,a.DateCreation
              INTO LTARIF.CODEINTERNEARTICLE
                  ,LTARIF.DATECREATION
              FROM INT_ARTICLES a
                  ,INT_Produits p
             WHERE a.CodeProduit = p.CodeProduit
               AND p.NomProduit = Ligne.ArtCode;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LTARIF.CODEINTERNEARTICLE := 0;
          END;
        END IF;
      
        --DLA le 01/03/2007 : pour CEGID et GIMA, si la date de debut est '31/12/1899',
        -- alors on met CodeInternearticle = 0, pour ne pas traiter la ligne
      
        IF Ligne.DateDebut = '31/12/1899' THEN
          LTARIF.CodeInterneArticle := 0;
        END IF;
      
        BEGIN
          IF LTARIF.CodeInterneArticle <> 0 THEN
            -- recuperation des donnees BizTalk
          
            LTarif.CODEPAYS  := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
            LTarif.DATEDEBUT := Trunc(Ligne.DateDebut);
            IF Ligne.DateFin = '31/12/9999' THEN
              LTarif.DATEFIN := NULL;
            ELSE
              LTarif.DATEFIN := Trunc(Ligne.DateFin);
            END IF;
            IF Ligne.TypeCond = 'VKP0' /*AND Ligne.PlanLib IS NULL*/
             THEN
              LTarif.CODETYPETARIF := 1;
            END IF;
            --DLA le 03/01/2007 mise en commentaire (le filtre est fait au dessus
            --           IF Ligne.TypeCond = 'VKP0' AND Ligne.PlanCode IS NOT NULL THEN
            --            LTarif.CODETYPETARIF   := 3;
            --           END IF;
            --           IF Ligne.TypeCond = 'VKA0' THEN
            --            RAISE_APPLICATION_ERROR(-20001, 'Erreur lors du traitement des tarifs en cours, TypeCond VKA0 sans PlanCode');
            --     --LTarif.CODETYPETARIF   := 4; --SM 06/02/2007 #20792
            --           END IF;
            --             IF Ligne.TypeCond = 'KA02' /*AND Ligne.PlanCode IS NOT NULL*/ THEN
            --               RAISE_APPLICATION_ERROR(-20001, 'Erreur lors du traitement des tarifs en cours, TypeCond VKA0 sans PlanCode');
            --     --LTarif.CODETYPETARIF    := 4;
            --             END IF;
            --             IF Ligne.TypeCond = 'ZA02' AND Ligne.PlanCode IS NOT NULL THEN
            --               LTarif.CODETYPETARIF    := 4;
            --             END IF;
          
            LTarif.PVTTC            := Ligne.MONTANTOUTAUX;
            LTarif.CODEOPECOMM      := NULL; --Ligne.PLANCODE;
            LTarif.DATECREATION     := Trunc(sysdate);
            LTarif.DATEMODIFICATION := Trunc(sysdate);
            LTarif.PVEURO           := Ligne.MONTANTOUTAUX;
          
            --DLA le 28/02/2007 : pour articles non sap, si DateDebut = '31/12/1899', on n'insere pas la ligne
            --   IF  LTarif.DATEDEBUT <> '31/12/1899' THEN
            BEGIN
              INSERT INTO INT_TARIFS
                (CODEPAYS
                ,CODEINTERNEARTICLE
                ,CODETYPETARIF
                ,DATEDEBUT
                ,DATEFIN
                ,PVTTC
                ,CODEOPECOMM
                ,DATECREATION
                ,DATEMODIFICATION
                ,PVEURO)
              VALUES
                (LTarif.CODEPAYS
                ,LTarif.CODEINTERNEARTICLE
                ,LTarif.CODETYPETARIF
                ,LTarif.DATEDEBUT
                ,NULL
                ,
                 --              LTarif.DATEFIN,
                 LTarif.PVTTC
                ,LTarif.CODEOPECOMM
                ,LTarif.DATECREATION
                ,LTarif.DATEMODIFICATION
                ,LTarif.PVEURO);
            EXCEPTION
              WHEN DUP_VAL_ON_INDEX THEN
                BEGIN
                  UPDATE INT_TARIFS
                     SET PVTTC            = LTarif.PVTTC
                        ,PVEURO           = LTarif.PVEURO
                        ,DATEMODIFICATION = LTarif.DATEMODIFICATION
                        ,DATEFIN          = LTarif.DATEFIN
                   WHERE CODEINTERNEARTICLE = LTarif.CODEINTERNEARTICLE
                     AND CODEPAYS = LTarif.CODEPAYS
                     AND CODETYPETARIF = LTarif.CODETYPETARIF
                     AND DATEDEBUT = LTarif.DATEDEBUT;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Erreur lors de l''insertion des donnees dans la table INT_Tarifs : ' || SQLERRM(SQLCODE));
                END;
            END;
            --   END IF;
          END IF;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Une erreur s''est produite lors de l''integration de l''article ' || Ligne.ArtCode || '.' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    END;
  
    PROCEDURE TRAITEMENT_TARIFS_FUTURS IS
      LTarifFutur                TRecTarifFutur;
      LeNbJourDescenteTarifFutur NUMBER;
    BEGIN
      FOR Ligne IN (SELECT *
                      FROM (SELECT *
                              FROM LBM_TARIF
                             WHERE MESSAGEID = CodeTraitement
                               AND DateDebut > SYSDATE
                               AND PlanLib IS NULL
                                  --DLA le 01/03/2007
                               AND TYPECOND = 'VKP0'
                             ORDER BY DateDebut)
                     WHERE RowNum > 1) LOOP
      
        SELECT ARTCODE BULK COLLECT
          INTO TabLock
          FROM LBM_TARIF
         WHERE messageid = CodeTraitement
           AND ARTCODE = Ligne.ArtCode
           FOR UPDATE;
      
        BEGIN
          SELECT a.CodeInterneArticle
                ,a.DateCreation
                ,cp0.CodeClassProd0
            INTO LTarifFutur.CODEINTERNEARTICLE
                ,LTarifFutur.DATECREATION
                ,LTarifFutur.CodeGroupeMagasin
            FROM ARTICLES   a
                ,Produits   p
                ,CLASSPROD0 cp0
                ,CLASSPROD1 cp1
                ,CLASSPROD2 cp2
                ,CLASSPROD3 cp3
           WHERE a.CodeProduit = p.CodeProduit
             AND p.NomProduit = Ligne.ArtCode
             AND cp3.COdeClassProd3 = p.CodeClassProd3
             AND cp2.CodeClassProd2 = cp3.CodeClassProd2
             AND cp1.CodeClassProd1 = cp2.CodeClassProd1
             AND cp0.CodeClassProd0 = cp1.CodeClassProd0;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            LTarifFutur.CODEINTERNEARTICLE := 0;
        END;
      
        IF LTarifFutur.CodeInterneArticle = 0 THEN
          BEGIN
            SELECT a.CodeInterneArticle
                  ,a.DateCreation
                  ,cp0.CodeClassProd0
              INTO LTarifFutur.CODEINTERNEARTICLE
                  ,LTarifFutur.DATECREATION
                  ,LTarifFutur.CodeGroupeMagasin
              FROM INT_ARTICLES a
                  ,INT_Produits p
                  ,CLASSPROD0   cp0
                  ,CLASSPROD1   cp1
                  ,CLASSPROD2   cp2
                  ,CLASSPROD3   cp3
             WHERE a.CodeProduit = p.CodeProduit
               AND p.NomProduit = Ligne.ArtCode
               AND cp3.COdeClassProd3 = p.CodeClassProd3
               AND cp2.CodeClassProd2 = cp3.CodeClassProd2
               AND cp1.CodeClassProd1 = cp2.CodeClassProd1
               AND cp0.CodeClassProd0 = cp1.CodeClassProd0;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              LTarifFutur.CODEINTERNEARTICLE := 0;
          END;
        END IF;
      
        --DLA le 01/03/2007 : pour CEGID et GIMA, si la date de debut est '31/12/1899',
        -- alors on met CodeInternearticle = 0, pour ne pas traiter la ligne
      
        IF Ligne.DateDebut = '31/12/1899' THEN
          LTarifFutur.CodeInterneArticle := 0;
        END IF;
      
        BEGIN
          IF LTarifFutur.CodeInterneArticle <> 0 THEN
            -- recuperation des donnees BizTalk
          
            LTarifFutur.CODEPAYS  := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
            LTarifFutur.DATEDEBUT := Trunc(Ligne.DateDebut);
            IF Ligne.DateFin = '31/12/9999' THEN
              LTarifFutur.DATEFIN := NULL;
            ELSE
              LTarifFutur.DATEFIN := Trunc(Ligne.DateFin);
            END IF;
            IF Ligne.TypeCond = 'VKP0' /*AND Ligne.PlanLib IS NULL*/
             THEN
              LTarifFutur.CODETYPETARIF := 1;
            END IF;
            --DLA le 01/03/2007 : mise en commentaire (le filtre est fait plus haut)
            --           IF Ligne.TypeCond = 'VKP0' AND Ligne.PlanCode IS NOT NULL THEN
            --            LTarifFutur.CODETYPETARIF   := 3;
            --           END IF;
            --           IF Ligne.TypeCond = 'VKA0' THEN
            --            LTarifFutur.CODETYPETARIF   := 4; --SM 06/02/2007 #20792
            --           END IF;
            --             IF Ligne.TypeCond = 'KA02' AND Ligne.PlanCode IS NOT NULL THEN
            --               LTarifFutur.CODETYPETARIF    := 4;
            --             END IF;
            --             IF Ligne.TypeCond = 'ZA02' AND Ligne.PlanCode IS NOT NULL THEN
            --               LTarifFutur.CODETYPETARIF    := 4;
            --             END IF;
          
            LeNbJourDescenteTarifFutur := PK_SITE.RETOURNEPARAMETRESITENUMBER('NBJOURDESCENTETARIFFUTUR');
            IF LeNbJourDescenteTarifFutur = 0 THEN
              LTarifFutur.DateEnvoi := TRUNC(SYSDATE);
            ELSE
              LTarifFutur.DateEnvoi := LTarifFutur.DATEDEBUT - LeNbJourDescenteTarifFutur;
            END IF;
            LTarifFutur.PVTTC := Ligne.MONTANTOUTAUX;
          
            LTarifFutur.DATECREATION      := Trunc(sysdate);
            LTarifFutur.DATEMODIFICATION  := Trunc(sysdate);
            LTarifFutur.PVEURO            := Ligne.MONTANTOUTAUX;
            LTarifFutur.CODEGROUPEMAGASIN := 0;
          
            BEGIN
              INSERT INTO INT_TARIFS_FUTURS
                (CODEPAYS
                ,CODEINTERNEARTICLE
                ,CODETYPETARIF
                ,DATEDEBUT
                ,DATEFIN
                ,PVTTC
                ,DATECREATION
                ,DATEMODIFICATION
                ,PVEURO
                ,DATEENVOI
                ,CODEGROUPEMAGASIN)
              VALUES
                (LTarifFutur.CODEPAYS
                ,LTarifFutur.CODEINTERNEARTICLE
                ,LTarifFutur.CODETYPETARIF
                ,LTarifFutur.DATEDEBUT
                ,LTarifFutur.DATEFIN
                ,LTarifFutur.PVTTC
                ,LTarifFutur.DATECREATION
                ,LTarifFutur.DATEMODIFICATION
                ,LTarifFutur.PVEURO
                ,LTarifFutur.DATEENVOI
                ,LTarifFutur.CODEGROUPEMAGASIN);
            EXCEPTION
              WHEN DUP_VAL_ON_INDEX THEN
                BEGIN
                  UPDATE INT_TARIFS_FUTURS
                     SET PVTTC            = LTarifFutur.PVTTC
                        ,PVEURO           = LTarifFutur.PVEURO
                        ,DATEMODIFICATION = LTarifFutur.DATEMODIFICATION
                        ,DATEFIN          = LTarifFutur.DATEFIN
                        ,DATEENVOI        = LTarifFutur.DateEnvoi
                   WHERE CODEINTERNEARTICLE = LTarifFutur.CODEINTERNEARTICLE
                     AND CODEPAYS = LTarifFutur.CODEPAYS
                     AND CODEGROUPEMAGASIN = LTarifFutur.CODEGROUPEMAGASIN
                     AND CODETYPETARIF = LTarifFutur.CODETYPETARIF
                     AND DATEDEBUT = LTarifFutur.DATEDEBUT;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Erreur lors de l''insertion des donnees dans la table INT_TARIFS_FUTURS : ' || SQLERRM(SQLCODE));
                END;
            END;
          END IF;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Une erreur s''est produite lors de l''integration de l''article ' || Ligne.ArtCode || '.' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    END;
  
    PROCEDURE TRAITEMENT_TARIFS_GROUPE_MAG IS
      LTarifGroupeMag   TRecTarifGroupeMag;
      TabCodesOpeComm   TTabCodesOpeComm;
      CodeOpeCommTrouve BOOLEAN;
      --DLA le 01/03//2007 : les codeopecomm sont crees a la volee
      -- les PLANLIB, mis dans le libelle, sont UNIQUE, on va donc s'en
      -- servir pour rechercher si l'opecomm existe deja
    
      LeNouveauCodeOpeComm OPERATIONS_COMMERCIALES.CodeOpeComm%TYPE;
      LeCodeMaxOpeComm     OPERATIONS_COMMERCIALES.CodeOpeComm%TYPE;
    
      PROCEDURE InsertOpeComm(LeCodeOpeComm       NUMBER
                             ,LePlanLib           VARCHAR2
                             ,LeCodeTypeTarif     NUMBER
                             ,LaDateDebut         DATE
                             ,LaDateFin           DATE
                             ,LeTypeCond          VARCHAR2
                             ,LeCodeGroupeMagasin VARCHAR2) IS
      BEGIN
        --DLA le 01/03/2007 FIN
        "		DELETE FROM INT_OPERATIONS_COMMERCIALES" WHERE CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS') AND CodeOpeComm = LeCodeOpeComm;
      
        "	  	 			BEGIN" INSERT
          INTO INT_OPERATIONS_COMMERCIALES(CODEOPECOMM
                                          ,LIBOPECOMM
                                          ,CODEPAYS
                                          ,CODEETATOPECOMM
                                          ,CODETYPETARIF
                                          ,NIVEAUOPECOMM
                                          ,DATEDEBUT
                                          ,DATEFIN
                                          ,DATEFINPREPARATION
                                          ,DATEENVOIMAG
                                          ,OBSERVATIONS
                                          ,DATECREATION
                                          ,DATEMODIFICATION
                                          ,CODETYPEOPECOMM
                                          ,NUMPOSTE
                                          ,CODEREGLECONVERSION
                                          ,CODEOPECOMMPRINCIPAL) VALUES
        --DLA le 01/03/2007
        (LeCodeOpeComm
        , --Ligne.PlanCode,
         --DLA le 01/03/2007 FIN
         LePlanLib
        ,PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS')
        ,
         -- DLA le 06/03/07 : etat valide = 4, pas 3
         --                       3,
         "			   4," LeCODETYPETARIF
         ,1
         ,LaDateDebut
         ,"			         LaDateFin," NULL
         ,TRUNC(SYSDATE)
         ,NULL
         ,TRUNC(SYSDATE)
         ,TRUNC(SYSDATE)
         ,DECODE(LeTypeCond
               ,'VKP0'
               ,1
               ,'VKA0'
               ,1
               ,'KA02'
               ,2
               ,'ZA02'
               ,2
               ,0)
         ,0
         ,NULL
         ,NULL);
        "					 EXCEPTION" "					 	WHEN DUP_VAL_ON_INDEX THEN" "						BEGIN" "						   RAISE_APPLICATION_ERROR(-20001, 'Une erreur s''est produite lors de la creation de l''OPCOMM '||LeNouveauCodeOpeComm||', ce code existe deja');" "						END;" "					 END;"
        
        DELETE FROM INT_DATES_OPE_COMM WHERE CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS') AND CodeOpeComm = LeCodeOpeComm AND CodeGroupeMagasin = LeCodeGroupeMagasin;
      
        INSERT INTO INT_DATES_OPE_COMM
          (CODEOPECOMM
          ,CODEPAYS
          ,CODEGROUPEMAGASIN
          ,DATEDEBUT
          ,DATEFIN
          ,DATEENVOI
          ,CODEETAT
          ,DATESUPPRESSION
          ,DATECREATION
          ,DATEMODIFICATION)
        VALUES
        --DLA le 01/03/2007
          (LeCodeOpeComm
          , --Ligne.PlanCode,
           --Ligne.PlanCode,
           --DLA le 01/03/2007 FIN
           PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS')
          ,LeCodeGroupeMagasin
          ,LaDateDebut
          ,LaDateFin
          ,TRUNC(SYSDATE)
          ,4
          ,NULL
          ,TRUNC(SYSDATE)
          ,TRUNC(SYSDATE));
      END;
    
    BEGIN
    
      "		 TabCodesOpeComm(1) := 'Premier';"
      
      FOR Ligne IN (
        SELECT *
          FROM LBM_TARIF
         WHERE MESSAGEID = CodeTraitement
           AND PlanLib IS NOT NULL) LOOP
        
        SELECT ARTCODE BULK COLLECT
          INTO TabLock
          FROM LBM_TARIF
         WHERE messageid = CodeTraitement
           AND ARTCODE = Ligne.ArtCode
           FOR UPDATE;
    
      --DLA le 13/04/2007 : toutes les OP seront passees sur le code groupe magasin 4, tous les magasins
      BEGIN
        SELECT a.CodeInterneArticle
              ,a.DateCreation
              ,4
          INTO LTarifGroupeMag.CODEINTERNEARTICLE
              ,LTarifGroupeMag.DATECREATION
              ,LTarifGroupeMag.CodeGroupeMagasin
          FROM INT_ARTICLES a
              ,INT_Produits p
         WHERE a.CodeProduit = p.CodeProduit
           AND p.NomProduit = Ligne.ArtCode;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LTarifGroupeMag.CODEINTERNEARTICLE := 0;
      END;
    
      BEGIN
        IF LTarifGroupeMag.CodeInterneArticle <> 0 THEN
        
          -- recuperation des donnees BizTalk
        
          "		LTarifGroupeMag.DATEDEBUT    := Trunc(Ligne.DateDebut);" IF Ligne.DateFin = '31/12/9999' THEN LTarifGroupeMag.DATEFIN := NULL;
        ELSE
          LTarifGroupeMag.DATEFIN := Trunc(Ligne.DateFin);
        END IF;
        IF Ligne.TypeCond = 'VKP0'
           AND Ligne.PlanLib IS NULL THEN
          LTarifGroupeMag.CODETYPETARIF := 1;
        END IF;
        IF Ligne.TypeCond = 'VKP0'
           AND Ligne.PlanLib IS NOT NULL THEN
          LTarifGroupeMag.CODETYPETARIF := 4;
        END IF;
        IF Ligne.TypeCond = 'VKA0' THEN
          LTarifGroupeMag.CODETYPETARIF := 3; --SM 06/02/2007 #20792
        END IF;
        IF Ligne.TypeCond = 'KA02'
           AND Ligne.PlanLib IS NOT NULL THEN
          LTarifGroupeMag.CODETYPETARIF := 3;
        END IF;
        IF Ligne.TypeCond = 'ZA02'
           AND Ligne.PlanLib IS NOT NULL THEN
          LTarifGroupeMag.CODETYPETARIF := 3;
        END IF;
      
        "			LTarifGroupeMag.DateDebut       := Ligne.DateDebut;"
        
        IF Ligne.TypeCond IN ('VKA0', 'ZA02', 'KA02') AND Ligne.DateFin IS NULL THEN LTarifGroupeMag.DateFin := '31/12/2098';
      ELSIF
      Ligne.TypeCond = 'VKP0' AND Ligne.PlanLib IS NOT NULL AND Ligne.DateFin IS NULL THEN LTarifGroupeMag.DateFin := '31/12/2098';
    ELSE
    LTarifGroupeMag.DateFin := Ligne.DateFin;
  END IF;

  -- on controle si l'ope comm existe
  CodeOpeCommTrouve := FALSE;
  FOR               iCodeOpeComm in TabCodesOpeComm.FIRST .. TabCodesOpeComm.LAST LOOP
  --DLA le 01/03/2007
  IF TabCodesOpeComm(iCodeOpeComm) = Ligne.PlanLib /*Ligne.PlanCode*/
  THEN CodeOpeCommTrouve := TRUE;
  EXIT             ;
END IF;
END LOOP;

"			IF CodeOpeCommTrouve THEN"
BEGIN
SELECT CodeOpeComm INTO LTarifGroupeMag.CodeOpeComm FROM OPERATIONS_COMMERCIALES WHERE LibOpeComm = Ligne.PlanLib AND CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
EXCEPTION
WHEN NO_DATA_FOUND THEN
BEGIN
SELECT CodeOpeComm INTO LTarifGroupeMag.CodeOpeComm FROM INT_OPERATIONS_COMMERCIALES WHERE LibOpeComm = Ligne.PlanLib AND CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
EXCEPTION
WHEN NO_DATA_FOUND THEN "						 RAISE_APPLICATION_ERROR(-20001, 'Erreur pendant la recherche du code pour la promotion '||Ligne.PlanLib);" "				  END;" "			  END;" "			END IF;"

--DLA le 01/03/2007 ajout du NOT
IF not COdeOpeCommTrouve THEN
BEGIN
SELECT CodeOpeComm INTO LTarifGroupeMag.CodeOpeComm FROM OPERATIONS_COMMERCIALES WHERE LibOpeComm = Ligne.PlanLib AND CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');

InsertOpeComm(LTarifGroupeMag.CodeOpeComm, Ligne.PlanLib, LTarifGroupeMag.CODETYPETARIF, Ligne.DateDebut, LTarifGroupeMag.DateFin, Ligne.TypeCond, LTarifGroupeMag.CodeGroupeMagasin);
EXCEPTION
WHEN NO_DATA_FOUND THEN
BEGIN
SELECT CodeOpeComm INTO LTarifGroupeMag.CodeOpeComm FROM INT_OPERATIONS_COMMERCIALES WHERE LibOpeComm = Ligne.PlanLib AND CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');

InsertOpeComm(LTarifGroupeMag.CodeOpeComm, Ligne.PlanLib, LTarifGroupeMag.CODETYPETARIF, Ligne.DateDebut, LTarifGroupeMag.DateFin, Ligne.TypeCond, LTarifGroupeMag.CodeGroupeMagasin);
EXCEPTION
WHEN NO_DATA_FOUND THEN
--DLA le 01/03/2007
"	 		   		 LeNouveauCodeOpeComm := Retourne_CodeSuivant('OPERATIONS_COMMERCIALES', 'CODEOPECOM');"

"					 	  select max(codeopecomm) INTO LeCodeMaxOpeComm from" "					 	  (" "					 	   		 select codeopecomm from OPERATIONS_COMMERCIALES" "					 			 UNION ALL" "					 			 select codeopecomm from INT_OPERATIONS_COMMERCIALES" "						  );"

--DLA le 28/07/2007 : la cle UNIQUE est le libelle; si on a un pb de Ref_Cii, on aura un decalage entre
-- les code ope et les libelles; on verifie et on remet OK si besoin, a chaque creation d'netete d'opcomm

"						 IF (LeNouveauCodeOpeComm <= NVL(LeCodeMaxOpeComm, 0)) THEN"

"							UPDATE Ref_CII" "							SET NumSeq = LeCodeMaxOpeComm" "							WHERE NomTable = 'OPERATIONS_COMMERCIALES'" "							AND Prefixe = 'CODEOPECOM';"

"							LeNouveauCodeOpeComm := Retourne_CodeSuivant('OPERATIONS_COMMERCIALES', 'CODEOPECOM');" "						 END IF;" "				 LTarifGroupeMag.CodeOpeComm := LeNouveauCodeOpeComm;" InsertOpeComm(LeNouveauCodeOpeComm, Ligne.PlanLib, LTarifGroupeMag.CODETYPETARIF, Ligne.DateDebut, LTarifGroupeMag.DateFin, Ligne.TypeCond, LTarifGroupeMag.CodeGroupeMagasin);
END;
END;
--DLA le 01/03/2007
TabCodesOpeComm(TabCodesOpeComm.LAST + 1) := Ligne.PlanLib; --Ligne.PlanCode;
--DLA le 01/03/2007 FIN
END IF; -- IF not COdeOpeCommTrouve THEN

LTarifGroupeMag.DATECREATION := Trunc(sysdate); LTarifGroupeMag.DATEMODIFICATION := Trunc(sysdate); IF (Ligne.TypeCond = 'ZA02' OR Ligne.TypeCond = 'KA02') THEN LTarifGroupeMag.PVTTC := 0; LTarifGroupeMag.PVEURO := 0; LTarifGroupeMag.TauxRemise := Ligne.MONTANTOUTAUX; ELSE LTarifGroupeMag.PVEURO := Ligne.MONTANTOUTAUX; LTarifGroupeMag.PVTTC := Ligne.MONTANTOUTAUX; LTarifGroupeMag.TauxRemise := NULL;
END IF;
BEGIN
INSERT INTO INT_TARIFS_GROUPE_MAGASIN(CODEGROUPEMAGASIN, CODEINTERNEARTICLE, DATEDEBUT, DATEFIN, CODETYPETARIF, PVTTC, CODEOPECOMM, DATECREATION, DATEMODIFICATION, PVEURO, TRANSFERTVERSMAGASIN, TAUXREMISE) VALUES(LTarifGroupeMag.CODEGROUPEMAGASIN, LTarifGroupeMag.CODEINTERNEARTICLE, LTarifGroupeMag.DATEDEBUT, LTarifGroupeMag.DATEFIN, LTarifGroupeMag.CODETYPETARIF, LTarifGroupeMag.PVTTC, LTarifGroupeMag.CODEOPECOMM, LTarifGroupeMag.DATECREATION, LTarifGroupeMag.DATEMODIFICATION, LTarifGroupeMag.PVEURO, LTarifGroupeMag.TRANSFERTVERSMAGASIN, LTarifGroupeMag.TauxRemise);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
BEGIN

IF (Ligne.TypeCond = 'ZA02' OR Ligne.TypeCond = 'KA02') THEN UPDATE INT_TARIFS_GROUPE_MAGASIN SET TauxRemise = LTarifGroupeMag.TauxRemise, DATEMODIFICATION = LTarifGroupeMag.DATEMODIFICATION, TRANSFERTVERSMAGASIN = LTarifGroupeMag.TRANSFERTVERSMAGASIN WHERE CODEGROUPEMAGASIN = LTarifGroupeMag.CODEGROUPEMAGASIN AND CODEINTERNEARTICLE = LTarifGroupeMag.CODEINTERNEARTICLE AND DATEDEBUT = LTarifGroupeMag.DATEDEBUT AND DATEFIN = LTarifGroupeMag.DATEFIN AND CODETYPETARIF = LTarifGroupeMag.CODETYPETARIF "			  AND  CODEOPECOMM      = LTarifGroupeMag.CODEOPECOMM  ;" ELSE UPDATE INT_TARIFS_GROUPE_MAGASIN SET "			  PVEURO                    = LTarifGroupeMag.PVEURO," "			  PVTTC                     = LTarifGroupeMag.PVTTC," DATEMODIFICATION = LTarifGroupeMag.DATEMODIFICATION, TRANSFERTVERSMAGASIN = LTarifGroupeMag.TRANSFERTVERSMAGASIN, DATEDEBUT = LTarifGroupeMag.DATEDEBUT, DATEFIN = LTarifGroupeMag.DATEFIN WHERE CODEGROUPEMAGASIN = LTarifGroupeMag.CODEGROUPEMAGASIN AND CODEINTERNEARTICLE = LTarifGroupeMag.CODEINTERNEARTICLE
--                      AND   DATEDEBUT              = LTarifGroupeMag.DATEDEBUT
--                      AND   DATEFIN                = LTarifGroupeMag.DATEFIN
AND CODETYPETARIF = LTarifGroupeMag.CODETYPETARIF AND CODEOPECOMM = LTarifGroupeMag.CODEOPECOMM;
END IF;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Erreur lors de l''insertion des donnees dans la table INT_TARIFS_GROUPE_MAGASIN : ' || SQLERRM(SQLCODE));
END;
END;
END IF; COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK; Ajouter_Log(1, LeCodeMsg, 'Une erreur s''est produite lors de l''integration de l''article ' || Ligne.ArtCode || '.' || CHR(13) || SQLERRM(SQLCODE)); Ajouter_Log_LBM('Article', LeCodeTraitementBizTalk, 1, SQLERRM(SQLCODE), Ligne.ArtCode);
END;
END LOOP;
END;

BEGIN
LeCodeMsg := 'BIZ-0008';

Ajouter_Log(3, LeCodeMsg, 'Debut de l''integration des tarifs par LBM_Tarif');

TRAITEMENT_TARIFS_EN_COURS; TRAITEMENT_TARIFS_FUTURS; TRAITEMENT_TARIFS_GROUPE_MAG;

Ajouter_Log(3, LeCodeMsg, 'Fin de l''integration des tarifs par LBM_tarif');
END;

/*******************************************************************/
/*  Procedure LBM_IntegrationReferencement                         */
/*                                                                 */
/*  Lancement des integrations :                                   */
/*    - Hierarchie                                                 */
/*    - Articles                                                   */
/*    - Tarifs                                                     */
/*    - EAN                                                        */
/*                                                                 */
/*  SM 06/11/2006 #20104 Creation                                  */
/*                                                                 */
/*******************************************************************/

PROCEDURE LBM_IntegrationReferencement IS
LeCodeMsg Log_Traitements.CodeMsg%TYPE; LockOk BOOLEAN; TimeOutDeclenche BOOLEAN; NbSecondes NUMBER(4); NbSecondesTimeOut NUMBER(4); LeNbErreurs NUMBER(10);
BEGIN
LeCodeMsg := 'BIZ-0000'; Ajouter_Log(3, LeCodeMsg, 'Debut de l''integration du referencement');

BEGIN
SELECT LeTimeOut INTO NbSecondesTimeOut FROM LBM_PARAM_INTERFACE;
EXCEPTION
WHEN OTHERS THEN NbSecondesTimeOut := 600; -- TimeOut = 10 minutes par defaut
END;

NbSecondes := 0; TimeOutDeclenche := FALSE;

WHILE TRUE LOOP
BEGIN
INSERT INTO TABLE_LOCK(NOMTABLE, ENREGISTREMENT, NUMPOSTE, CODEUTILISATEUR) VALUES('PREPA_EN_JOURNEE', '1', to_char(sysdate, 'DDMMHH24MISS'), -1); LockOk := TRUE;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN LockOk := FALSE; dbms_Lock.Sleep(1); -- tempo de 1 seconde
NbSecondes := NbSecondes + 1; IF NbSecondes >= NbSecondesTimeOut THEN TimeOutDeclenche := TRUE;
END IF;
END;

EXIT WHEN LockOk OR TimeOutDeclenche;
END LOOP;

IF TimeOutDeclenche THEN Ajouter_Log(1, LeCodeMsg, 'Impossible d''inserer un lock (TimeOut).'); ELSE
BEGIN
SELECT NVL(CodeMsgLog, 0) + 1 INTO LeCodeTraitementBizTalk FROM LBM_PARAM_INTERFACE;

UPDATE LBM_PARAM_INTERFACE SET CodeMsgLog = LeCodeTraitementBizTalk;
EXCEPTION
WHEN NO_DATA_FOUND THEN LeCodeTraitementBizTalk := -1;
END;

FOR LigneIdMessage in (SELECT Id_Message FROM LBM_MESSAGE_ID WHERE ID_BATCH_STL IS
NULL order by DATE_DEBUT_INTEGRATION) LOOP
BEGIN
IF LigneIdMessage.ID_Message IS
NOT NULL THEN
BEGIN
PRC_LBM_HIERARCHIE(LigneIdMessage.ID_Message); PRC_LBM_CP(LigneIdMessage.ID_Message); PRC_LBM_ARTICLE(LigneIdMessage.ID_Message); PRC_LBM_TARIF(LigneIdMessage.ID_Message); PRC_LBM_EAN(LigneIdMessage.ID_Message);
-- DLA le 13/04/2007 : on n'effectue plus cette procedure; on fait un annule et remplace
-- dans PK_Interface, on envoie toujours tous les EAN a la caisse qui effectue egalement
-- un annule et remplace : les lignes de suppressions de CB sont donc inutiles.
--                  PRC_LBM_EAN_FINALISE;
BEGIN
UPDATE LBM_MESSAGE_ID SET ID_BATCH_STL = LeCodeTraitementBizTalk WHERE Id_Message = LigneIdMessage.ID_Message;
EXCEPTION
WHEN NO_DATA_FOUND THEN NULL;
END;
END; ELSE Ajouter_Log(1, LeCodeMsg, 'Les parametres de l''interface ne sont pas alimentes.');
END IF;
END;
END LOOP;
BEGIN
PK_INterface.INIT_CODETRAITEMENT(LeCodeTraitementBizTalk); PK_INterface.INTEGRATION_REFERENCEMENT;
BEGIN
INSERT INTO LBM_SUIVI_BATCH_INTEGRATION(ID_BATCH, DATE_FIN_INTEGRATION, NBERREURS) VALUES(LeCodeTraitementBizTalk, SYSDATE, 0);
END; COMMIT;
EXCEPTION
WHEN OTHERS THEN
BEGIN
ROLLBACK; Ajouter_Log(1, LeCodeMsg, 'Erreur lors de PK_Interface.INTEGRATION_REFERENCEMENT.' || CHR(13) || SQLERRM(SQLCODE));
END;
END; PRC_TRAITE_REJET(LeCodeTraitementBizTalk);
BEGIN
SELECT COUNT(*) INTO LeNbErreurs FROM LBM_LOGS WHERE ID_MESSAGE = LeCodeTraitementBizTalk;

UPDATE LBM_SUIVI_BATCH_INTEGRATION SET NBERREURS = LeNbErreurs WHERE ID_BATCH = LeCodeTraitementBizTalk;
EXCEPTION
WHEN OTHERS THEN NULL;
END; PRC_PURGE_INT; DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'PREPA_EN_JOURNEE' AND ENREGISTREMENT = '1'; Ajouter_Log(3, LeCodeMsg, 'Fin de l''integration du referencement');
END IF;

--    DELETE FROM TABLE_LOCK
--     WHERE NOMTABLE = 'PREPA_EN_JOURNEE'
--     AND ENREGISTREMENT = '1';
--     Ajouter_Log(3, LeCodeMsg, 'Fin de l''integration du referencement');
END;

/*******************************************************************/
/*  Procedure PRC_LBM_VENTE                                        */
/*                                                                 */
/*  Extraction des ventes depuis Storeland vers BizTalk            */
/*                                                                 */
/*  SM 06/11/2006 #20104 Creation                                  */
/*  DL 09/01/2007 ajout du departement (CP1) du produit            */
/*                                                                 */
/*******************************************************************/

PROCEDURE PRC_LBM_VENTE IS
LeCodeMsg Log_Traitements.CodeMsg%TYPE; NbJoursTickets LBM_PARAM_INTERFACE.NbJourPourTicket%TYPE; CodeAxeSteCaisse LBM_PARAM_INTERFACE.CodeAxeSteCaisse%TYPE; CodeRemiseEscompte LBM_PARAM_INTERFACE.CodeRemiseEscompte%TYPE;
--Dla le 15/05/2007 : ajout du code remise OPCOMM
CodeRemiseOpComm LBM_PARAM_INTERFACE.CodeRemiseOpComm%TYPE; LaDateMiseAJour DATE; LeEnteteVente TRecLBMVenteEntete; LeTabLignesVentes TabLigneVente; LeTabLignesRegl TTabLigneReglement; iLigneVente NUMBER(3); iLigneRegl NUMBER(3); LePlanLib OPERATIONS_COMMERCIALES.LIBOPECOMM%TYPE;
-- DLA le 13/03 /2007 : modif pour extraction des remises, escompte et export
LeNewTicket HISTORIQUE_CAISSES.Numticket%TYPE; LeOldTicket HISTORIQUE_CAISSES.Numticket%TYPE; TicketExport NUMBER(1); TicketEscompte NUMBER(1); TauxEscompte NUMBER(5, 2); EscompteNbLigne NUMBER(8); EscompteMtTotal NUMBER(10, 2); EscompteMtIntermediaire NUMBER(10, 2); EscompteNbLigneIntermediaire NUMBER(8); EscompteCATicketTotal NUMBER(10, 2);
-- DLA le 28/03/2007 pour ne rien integrer quand un ticket est en erreur
TicketEnErreur NUMBER(1);
-- DLA le 13/03 /2007 : FIN modif pour extraction des remises, escompte et export
-- DLA le 29/03/2007 si pas de paiement (ticket a 0 euro), on genere qd meme
-- une ligne de reglement a 0, mode de reglement espece (BFU le 29/03/2007)
TicketAZero NUMBER(1); "TicketChange		NUMBER(1);" "CodeRecetteChange 		  LBM_PARAM_INTERFACE.CodeRecetteChange%TYPE;" "CodeDepenseChange 		  LBM_PARAM_INTERFACE.CodeDepenseChange%TYPE;" "EANChangeLBM				  LBM_PARAM_INTERFACE.EANChangeLBM%TYPE;" "EANChangeSEGEP			  LBM_PARAM_INTERFACE.EANChangeSEGEP%TYPE;" "EANChangeFF				  LBM_PARAM_INTERFACE.EANChangeFF%TYPE;" "TypeChange				  LBM_PARAM_INTERFACE.CodeDepenseChange%TYPE;" PRENUMEROTATION PARAMETRES_FACTURATIONCLIENT.PRENUMEROTATION%TYPE; NumFacture NUM_FACTURE_TICKET.NUMFACTURE%TYPE; TicketClientEnCompte Number(1);
--Ajout pour le controle de coherence du ticket;
"LaSteCaisseEnCours	VARCHAR2(4);" "LeNumCaisseEnCours	NUMBER(10);" "LeNumTicketEnCours	NUMBER(10);" "LaDateHTransEnCours	DATE;" "ControleOK			NUMBER(1);" "PromoPourcentage	NUMBER(1);"
-- PB 19/10/2007 #22884 Gestion des cartes cadeaux
NumRecCarteKDO LBM_PARAM_INTERFACE.NumRecCarteKDO%TYPE; EANCarteKdo_BM LBM_PARAM_INTERFACE.EANCarteKdo_BM%TYPE; EANCarteKdo_SEGEP LBM_PARAM_INTERFACE.EANCarteKdo_SEGEP%TYPE; EANCarteKdo_FF LBM_PARAM_INTERFACE.EANCarteKdo_FF%TYPE; NumReglCarteKDO LBM_PARAM_INTERFACE.NumReglCarteKDO%TYPE; MtTvaKdo HISTORIQUE_CAISSES.MTTVA%TYPE; CANETKdo HISTORIQUE_CAISSES.CaNetRealise%TYPE; CarteCadeau NUMBER(1); EANSaisieKdo HISTORIQUE_CAISSES.CodeSaisie%TYPE; VolVenteKdo HISTORIQUE_CAISSES.VolVente%TYPE; TauxTvaKdo TVA_PAYS.TauxTVA%TYPE; CodeNatureKdo HISTORIQUE_CAISSES.CodeNature%TYPE; "	PROCEDURE InitTicket IS" "	BEGIN" LeEnteteVente.SteCaisse := NULL; LeEnteteVente.DateHTrans := NULL; LeEnteteVente.NumCaisse := NULL; LeEnteteVente.NumCaissierTrans := NULL; LeEnteteVente.NumTicket := NULL; LeEnteteVente.Export := NULL; LeEnteteVente.NumClt := NULL; LeEnteteVente.CaNetTTC := NULL; LeEnteteVente.Escpt := NULL; LeEnteteVente.NumCartePriv := NULL; LeEnteteVente.DateHTOPCA := NULL; LeEnteteVente.DateMaj := NULL;

FOR i IN 1 .. iLigneVente LOOP LeTabLignesVentes(i) := NULL;
END LOOP;

FOR i IN 1 .. iLigneRegl LOOP LeTabLignesRegl(i) := NULL;
END LOOP; iLigneVente := 0; iLigneRegl := 0; "	END;"

"	PROCEDURE EFFACE_LBM_TICKET_A_EXTRAIRE(LeCodeMagasin NUMBER, LeJourDeVente DATE," "	  LeCodeCaisse VARCHAR2, LeNumTicket NUMBER) IS" "	BEGIN" DELETE FROM LBM_TICKET_A_EXTRAIRE WHERE CODEMAGASIN = LeCodeMagasin AND JOURDEVENTE = TRUNC(LeJourDeVente) AND CODECAISSE = LeCodeCaisse AND NUMTICKET = LeNumTicket; "	END;"

"	PROCEDURE EFFACE_LBM_TICKET_A_EXTRAIRE_A(LeCodeMagasin NUMBER, LeJourDeVente DATE," "	  LeCodeCaisse VARCHAR2, LeNumTicket NUMBER) IS" pragma autonomous_transaction; "	BEGIN" EFFACE_LBM_TICKET_A_EXTRAIRE(LeCodeMagasin, "				  LeJourDeVente," LeCodeCaisse, "				  LeNumTicket);" "	  COMMIT;" "	END;"

BEGIN
LeCodeMsg := 'BIZ-0005';
--DLA le 01/01/2007

LePlanLib := NULL;
-- DLA le 13/03 /2007 : modif pour extraction des remises, escompte et export
LeOldTicket := -1; LeNewTicket := -1; TicketExport := 0; TicketEscompte := 0; TicketEnErreur := 0; TicketAZero := 0; TicketChange := 0; "TypeChange	   := 0;" TicketClientEnCompte := 0;

"LaSteCaisseEnCours	:= NULL;" "LeNumCaisseEnCours	:= 0;" "LeNumTicketEnCours	:= 0;" "LaDateHTransEnCours :=	NULL;"
-- DLA le 13/03 /2007 : FIN modif pour extraction des remises, escompte et export

NumRecCarteKDO := 0; EANCarteKdo_BM := 0; EANCarteKdo_SEGEP := 0; EANCarteKdo_FF := 0; NumReglCarteKDO := 0;

Ajouter_Log(3, LeCodeMsg, 'Lancement de la generation des ventes par LBM_VENTE');

--**************** On ramene les parametres des interfaces

BEGIN
BEGIN
SELECT lpi.NbJourPourTicket, lpi.CodeAxeSteCaisse, lpi.CodeRemiseEscompte,
--DLA le 15/05/2007 : ajout de coderemiseopcomm
lpi.CodeRemiseOpComm,
--DLA le 18/05/2007 : ajout du ticket de change
CodeRecetteChange, CodeDepenseChange, EANChangeLBM, EANChangeSEGEP, EANChangeFF, NumRecCarteKDO, EANCarteKdo_BM, EANCarteKdo_SEGEP, EANCarteKdo_FF, NumReglCarteKDO INTO NbJoursTickets, CodeAxeSteCaisse, CodeRemiseEscompte, CodeRemiseOpComm,
--DLA le 18/05/2007 : ajout du ticket de change
CodeRecetteChange, CodeDepenseChange, EANChangeLBM, EANChangeSEGEP, EANChangeFF, NumRecCarteKDO, EANCarteKdo_BM, EANCarteKdo_SEGEP, EANCarteKdo_FF, NumReglCarteKDO FROM LBM_PARAM_INTERFACE lpi;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Erreur lors de la lecture des parametres d''extraction des ventes.' || CHR(13) || SQLERRM(SQLCODE));
END;

--*************DLA le 13/03/2007 : on va chercher le taux de l'escompte
BEGIN
SELECT ValeurDefaut INTO TauxEscompte FROM TYPES_REMISE WHERE CODETYPEREMISE = NVL(CodeRemiseEscompte, 0);
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Erreur lors de la lecture du taux de l''escompte.' || CHR(13) || SQLERRM(SQLCODE));
END;

--*************on recherche le parametrage de la facturation client
BEGIN
SELECT PRENUMEROTATION INTO PRENUMEROTATION FROM PARAMETRES_FACTURATIONCLIENT;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Erreur lors de la lecture du parametrage de la facturation client.' || CHR(13) || SQLERRM(SQLCODE));
END;

--************** on ramene les tickets a extraire

LaDateMiseAJour := SYSDATE; iLigneVente := 0; iLigneRegl := 0;

FOR Ligne IN (SELECT * FROM(SELECT 'Ligne' TypeInfo, sm.CodeElementStat, hc.CodeMagasin, hc.JourDeVente, hc.CodeCaisse, hc.CodeCaissiere, hc.NumTicket, hc.CodeNature, hc.NumLigne, hc.CodeInterneArticle, hc.CodeClient, hc.TypeLigne,
--DLA le 13/03/2007 on remonte les info export, escompte
hc.CaNetRealise, hc.MtRemise, hc.MtRemiseReel, hc.mtremiseligne,(hc.MtRemiseReel - hc.mtremiseligne) MtRemiseTicket,
--         hc.MtTVA,
ROUND((hc.CANETREALISE * TauxEscompte
/
100), 2) MtEscompteLigne,
--DLA le 01/03/2007
hc.CodeOpeComm,
--DLA le 13/03/2007 on remonte les info export, escompte
0 Escompte,
--                                 hc.CodeCarte,
hc.CodeVendeur,
--                                 hc.CodeSaisie,
DECODE(hc.TypeLigne, 7, a.CodeBarres, hc.CodeSaisie) CodeSaisie, CP2.CodeClassprod1, p.CodeClassProd3, lc.APPL, lc.TYPEGEST,
--SUM(NVL(hc.MtRemise, 0)) TotalRemisesLigne,
tp.TauxTVA, hc.MtTva, hc.VolVente,
--                                 SUM(DECODE(tr.ApplicableEn, 1, hc.MtRemise, 0)) MtTotalRemiseLigne,
--                                SUM(DECODE(hc.NumRemise, CodeRemiseEscompte, hc.MtRemise, 0)) EscompteLigne,
DECODE(tr.ApplicableEn, 1, hc.NumRemise, 0) ReducType, DECODE(tr.ApplicableEn, 0, hc.NumRemise, 0) RemiseType, lc.HCA, am.LibRedactionMarketing, am.CodeTypeActionMarketing, hc.MotifRetour, NVL(mrmp.Cheque, 0) Cheque, NVL(mrmp.CB, 0) CB, hc.CodeDevise, hc.NumPieceIdentite, hc.PRIXVENTEARTICLECAISSE, hc.libelle2, hc.MtRemiseOpComm, "					   hc.EnPromotion" FROM HISTORIQUE_CAISSES hc, LBM_TICKET_A_EXTRAIRE ltae, STATS_MAGASIN sm, ARTICLES a, PRODUITS p, CLASSPROD2 CP2, CLASSPROD3 CP3, LBM_CP_HISTO lc, TVA_PAYS tp, ACTIONS_MARKETING am, TYPES_REMISE tr, MODES_REGL_MAGASIN_PAYS mrmp WHERE hc.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets AND hc.TypeLigne IN (1, 2, 9, 7) AND hc.CodeMagasin = ltae.CodeMagasin
-- DLA : ajout du TRUNC
AND trunc(hc.JourDeVente) = ltae.JourDeVente AND hc.CodeCaisse = ltae.CodeCaisse AND hc.NumTicket = ltae.NumTicket AND sm.CodeMagasin = hc.CodeMagasin AND sm.CodeAxeStat = CodeAxeSteCaisse AND a.CodeInterneArticle(+) = hc.CodeInterneArticle AND p.CodeProduit(+) = a.CodeProduit AND lc.CP(+) = p.CodeClassProd3 AND CP3.CodeClassProd3(+) = p.CodeClassProd3 AND CP2.CodeClassprod2(+) = CP3.CodeClassProd2 AND tp.CodeTVA(+) = hc.CodeTVA AND tp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS') AND am.CodeActionMarketing(+) = hc.CodeActionMarketing AND tr.CodeTypeRemise(+) = hc.NumRemise AND mrmp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS') AND mrmp.CodeModeReglementMag(+) = hc.MotifRetour UNION ALL SELECT 'Pied' TypeInfo, sm.CodeElementStat, hc.CodeMagasin, hc.JourDeVente, hc.CodeCaisse, hc.CodeCaissiere, hc.NumTicket, 0 CodeNature, 0 NumLigne, 0 CodeInterneArticle, hc.CodeClient, 0 TypeLigne,
--DLA le 13/03/2007 on remonte les info export, escompte
SUM(DECODE(hc.TypeLigne, 9, CaNetRealise, 0)) CaNetRealise, 0 MtRemiseReel, 0 MtRemise, 0 mtremiseligne, 0 MtRemiseTicket,
--         0 MtExport,
0 MtEscompteLigne,
--DLA le 01/03/2007
0 CodeOpeComm,
--DLA le 13/03/2007 FIN on remonte les info export, escompte
NVL(sum(DECODE(hc.TypeLigne, 6,(DECODE(hc.NumRemise, 99, hc.MtRemise, 0)), 0)), 0) Escompte,
--                                 SUM(NVL(DECODE(hc.NumRemise, 99, hc.MtRemise, 0), 0)) Escompte,
--                                 hc.CodeCarte,
0 CodeVendeur, '' CodeSaisie, '' CodeClassprod1, '' CodeClassProd3, '' APPL, '' TYPEGEST,
--                                 0 TotalRemisesLigne,
0 TauxTVA, 0 MtTva, 0 VolVente,
--                                 0 MtTotalRemiseLigne,
--                                 0 EscompteLigne,
0 ReducType, 0 RemiseType, '' HCA, '' LibRedactionMarketing, 0 CodeTypeActionMarketing, 0 MotifRetour, 0 Cheque, 0 CB, '' CodeDevise, '' NumPieceIdentite, 0 PRIXVENTEARTICLECAISSE, '' libelle2, 0 MtRemiseOpComm, "					   0 EnPromotion" FROM HISTORIQUE_CAISSES hc, LBM_TICKET_A_EXTRAIRE ltae, STATS_MAGASIN sm WHERE hc.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets AND hc.TypeLigne IN (1, 2, 9, 7) AND hc.CodeMagasin = ltae.CodeMagasin
-- DLA ajout du TRUNC
AND trunc(hc.JourDeVente) = ltae.JourDeVente AND hc.CodeCaisse = ltae.CodeCaisse AND hc.NumTicket = ltae.NumTicket AND sm.CodeMagasin = hc.CodeMagasin AND sm.CodeAxeStat = CodeAxeSteCaisse GROUP BY hc.CodeMagasin, hc.JourDeVente, hc.CodeCaisse, hc.NumTicket, sm.CodeElementStat, hc.CodeCaissiere, hc.CodeClient
--                                   ,hc.CodeCarte
) ORDER BY CodeMagasin, JourDeVente, CodeCaisse, NumTicket, TypeInfo, NumLigne) LOOP
BEGIN
--*************On teste le caracterer Export ou escompte ou ticket a 0 du ticket
LeNewTicket := Ligne.NumTicket;

IF (TicketEnErreur = 0) OR (LeOldTicket <> LeNewTicket) then
-- DLA le 28/03/2007 si on change de ticket, on commit
IF LeOldTicket <> LeNewTicket THEN
--************************ On controle la cohernce du ticket precedent
IF LeOldTicket <> '-1' THEN test_ticket(LaSteCaisseEnCours, LeNumCaisseEnCours, LeNumTicketEnCours, LaDateHTransEnCours);
END IF; "			  LeOldTicket:= LeNewTicket;" "LaSteCaisseEnCours	:= Ligne.CodeCaisse;" "LeNumCaisseEnCours	:= Ligne.CodeMagasin;" "LeNumTicketEnCours	:= TO_NUMBER(SUBSTR(LIGNE.NUMTICKET, 4, 10));" "LaDateHTransEnCours :=	Ligne.JourDeVente;"

--************************ Fin du controle

TicketEnErreur := 0; EscompteNbLigne := 0; EscompteNbLigneIntermediaire := 1; EscompteMtTotal := 0; EscompteMtIntermediaire := 0; EscompteCATicketTotal := 0;
BEGIN
SELECT 1, MtRemise INTO TicketEscompte, EscompteMtTotal FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeLigne = 6 AND NumRemise = 99 AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN TicketEscompte := 0; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement escompte, ticket ' || Ligne.NumTicket);
END;

IF TicketEscompte = 1 THEN
BEGIN
SELECT SUM(CANETREALISE), COUNT(*) INTO EscompteCATicketTotal, EscompteNbLigne FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeLigne = 1;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement escompte2, ticket ' || Ligne.NumTicket);
END;
END IF;

BEGIN
SELECT 1 INTO TicketExport FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeLigne = 4 AND MotifRetour = 21 AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN TicketExport := 0; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement export, ticket ' || Ligne.NumTicket);
END;

MtTvaKdo := 0; CANETKdo := 0; EANSaisieKdo := NULL; VolVenteKdo := 0; TauxTvaKdo := 0; CodeNatureKdo := 0;

-- PB 19/10/2007 #22884 Gestion des cartes cadeaux
"		   -- DLA le 26/12/2007 : on gere les lignes de carte cadeau dans la boucle de gestion des lignes" "		   -- de tickets, sinon pas de gestion de plusieurs lignes de carets cadeaux dans le meme tickets" "		   -- de plus, le client veut conserver l'ordre des lignes du tickets (BFU)"
--                BEGIN
--                  SELECT 1,NVL(hc.MTTVA,0),hc.CaNetRealise,hc.CodeSaisie,hc.VolVente,NVL(tp.tauxTva,0),hc.CodeNature
--                  INTO CarteCadeau,MtTvaKdo,CANetKDO,EANSaisieKdo,VolVenteKdo,TauxTvaKdo,CodeNatureKdo
--                  FROM HISTORIQUE_CAISSES hc ,TVA_PAYS tp
"--                  WHERE tp.CodeTVA(+) = hc.CodeTVA"
--                  AND   tp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS')
"--                  AND   hc.CodeMagasin =  Ligne.Codemagasin" "--                  AND   hc.JourDeVente =  Ligne.JourDeVente" "--                  AND   hc.CodeCaisse    =  Ligne.CodeCaisse" "--                  AND   hc.NumTicket   =  Ligne.NumTicket" "--                  AND   hc.TypeLigne  = 7" "--                  AND   hc.MotifRetour = NumRecCarteKDO" "--                  AND   ROWNUM     = 1;" "--                EXCEPTION" "--                  WHEN NO_DATA_FOUND THEN CarteCadeau := 0;"
--                  WHEN OTHERS THEN
--                    RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, ticket '||Ligne.NumTicket);
"--                END;"
--                IF CarteCadeau = 1 THEN
--                  iLigneVente := iLigneVente + 1;
--                     -- recherche d'info sur l'EAN
--                     BEGIN
--                       SELECT cp2.codeclassprod1, p.codeclassprod3
--                       INTO LeTabLignesVentes(iLigneVente).Departement, LeTabLignesVentes(iLigneVente).CP
--                       FROM PRODUITS p, HISTO_CB_FRN hcf, CLASSPROD2 cp2, CLASSPROD3 cp3
--                       WHERE hcf.codebarres = DECODE(Ligne.CodeCaisse,1,EANCarteKdo_BM,
--                                                     DECODE(Ligne.CodeCaisse,2,EANCarteKdo_SEGEP,
--                                                            DECODE(Ligne.CodeCaisse,3,EANCarteKdo_FF)))
--                       AND p.codeproduit = TO_CHAR(hcf.codeinternearticle)
--                       AND cp3.codeclassprod3 = p.codeclassprod3
--                       AND cp2.codeclassprod2 = cp3.codeclassprod2;
--                     EXCEPTION
--                       WHEN OTHERS THEN
--                         RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, recherche du Centre de profit / departement, ticket '||Ligne.NumTicket);
--                     END;
--
--                     BEGIN
--                       SELECT HCA, APPL, TYPEGEST
--                       INTO LeTabLignesVentes(iLigneVente).HCA, LeTabLignesVentes(iLigneVente).APPL, LeTabLignesVentes(iLigneVente).TYPEGEST
--                       FROM LBM_CP_HISTO
--                       WHERE  CP = LeTabLignesVentes(iLigneVente).CP
--                       AND ROWNUM = 1;
--                     EXCEPTION
--                       WHEN OTHERS THEN
--                         RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, recherche du HCA, APPL et TYPEGEST, ticket '||Ligne.NumTicket);
--                     END;
--                     LeTabLignesVentes(iLigneVente).EANSaisie := EANSaisieKdo;
--                     LeTabLignesVentes(iLigneVente).PR := 1;
--                     LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat;
--                     LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente;
--                     LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin;
--                     LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket;
--                     LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente;
--                     LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
--                     LeTabLignesVentes(iLigneVente).TVATaux := TauxTvaKdo;
--                     LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
--
--                     LeTabLignesVentes(iLigneVente).PrixTTCArt := CANetKDO;
--                     LeTabLignesVentes(iLigneVente).PrixHTArt := CANetKDO - MtTVAKdo;
--                     LeTabLignesVentes(iLigneVente).ExpMont := 0;
--                     LeTabLignesVentes(iLigneVente).EscMont := 0;
--                     LeTabLignesVentes(iLigneVente).CaNetLigne := CANetKDO;
--                     LeTabLignesVentes(iLigneVente).CaNetLigneHT := CANetKDO - MtTVAKdo;
--
--                     LeTabLignesVentes(iLigneVente).TotRemRed := 0;
--                     LeTabLignesVentes(iLigneVente).TotRemRedHT := 0;
--                     LeTabLignesVentes(iLigneVente).ReducTotal := 0;
--                     LeTabLignesVentes(iLigneVente).MONTACTMARK := 0;
--                     LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
--                     LeTabLignesVentes(iLigneVente).ExpRemise := 0;
--                     LeTabLignesVentes(iLigneVente).ExpArt := 0;
--                     LeTabLignesVentes(iLigneVente).NumCdeClt := NULL;
--                     LeTabLignesVentes(iLigneVente).TvaMont := MtTVAKdo;
--                     LeTabLignesVentes(iLigneVente).Qte := VolVenteKdo;
--                     LeTabLignesVentes(iLigneVente).ReducType := 0;
--                     LeTabLignesVentes(iLigneVente).RemiseType := 0;
--                     LeTabLignesVentes(iLigneVente).RemManuelle := 0;
--                     LeTabLignesVentes(iLigneVente).NumPlan := 0;
--                     LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL;
--                     LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL;
--                     LeTabLignesVentes(iLigneVente).DatHTopGU := NULL;
--                     LeTabLignesVentes(iLigneVente).TopArch := NULL;
--                     LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
--                     LeTabLignesVentes(iLigneVente).Numplan := NULL;
--                END IF;
--              -- fin traitement carte cadeau

--DLA le 18/05/2007 : ajout du ticket de change
BEGIN
SELECT 1, MotifRetour INTO TicketChange, TypeChange FROM HISTORIQUE_CAISSES "WHERE CodeMagasin		=  Ligne.Codemagasin" "AND   JourDeVente		=  Ligne.JourDeVente" "AND   CodeCaisse		=  Ligne.CodeCaisse" "AND   NumTicket		=  Ligne.NumTicket" "AND   TypeLigne		IN (4, 7)" "AND   MotifRetour		IN (CodeRecetteChange, CodeDepenseChange)" "AND   ROWNUM			= 1;"
EXCEPTION
WHEN NO_DATA_FOUND THEN TicketChange := 0; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement change, ticket ' || Ligne.NumTicket);
END;

IF TicketChange = 1 THEN iLigneVente := iLigneVente + 1; IF Ligne.CodeElementStat = 1 THEN LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeLBM;
END IF; IF Ligne.CodeElementStat = 2 THEN LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeSEGEP;
END IF; IF Ligne.CodeElementStat = 3 THEN LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeFF;
END IF;
-- recherche d'info sur l'EAN change a) remonter
BEGIN
SELECT cp2.codeclassprod1, p.codeclassprod3 INTO LeTabLignesVentes(iLigneVente).Departement, LeTabLignesVentes(iLigneVente).CP FROM produits p, histo_cb_frn hcf, classprod2 cp2, classprod3 cp3 WHERE hcf.codebarres = LeTabLignesVentes(iLigneVente).EANSaisie AND p.codeproduit = to_char(hcf.codeinternearticle) AND cp3.codeclassprod3 = p.codeclassprod3 AND cp2.codeclassprod2 = cp3.codeclassprod2;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement change, recherche du Centre de profit / departement, ticket ' || Ligne.NumTicket);
END;

BEGIN
SELECT HCA, APPL, TYPEGEST INTO LeTabLignesVentes(iLigneVente).HCA, LeTabLignesVentes(iLigneVente).APPL, LeTabLignesVentes(iLigneVente).TYPEGEST FROM LBM_CP_HISTO WHERE CP = LeTabLignesVentes(iLigneVente).CP;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement change, recherche du HCA, APPL et TYPEGEST, ticket ' || Ligne.NumTicket);
END;

BEGIN
SELECT NVL(tp.TauxTVA, 0) INTO LeTabLignesVentes(iLigneVente).TVATaux FROM TVA_Pays tp, TVA_Produit_Pays tpp, histo_cb_frn hcf WHERE tp.CodePays = tpp.CodePays AND tp.CodeTVA = tpp.CodeTVA AND tpp.CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS') AND tpp.CodeProduit = to_char(hcf.codeinternearticle) AND hcf.codebarres = LeTabLignesVentes(iLigneVente).EANSaisie;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement change, recherche du taux de TVA, ticket ' || Ligne.NumTicket);
END;

LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat; LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente; LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin; LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket; LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente; LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur; LeTabLignesVentes(iLigneVente).PrixTTCArt := 0; LeTabLignesVentes(iLigneVente).PrixHTArt := 0; LeTabLignesVentes(iLigneVente).ExpMont := 0; LeTabLignesVentes(iLigneVente).EscMont := 0; LeTabLignesVentes(iLigneVente).CaNetLigne := 0; LeTabLignesVentes(iLigneVente).TotRemRed := 0; LeTabLignesVentes(iLigneVente).TotRemRedHT := 0; LeTabLignesVentes(iLigneVente).ReducTotal := 0; LeTabLignesVentes(iLigneVente).MONTACTMARK := 0; LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0; LeTabLignesVentes(iLigneVente).ExpRemise := 0; LeTabLignesVentes(iLigneVente).ExpArt := 0; LeTabLignesVentes(iLigneVente).NumCdeClt := NULL; LeTabLignesVentes(iLigneVente).TvaMont := 0; IF TypeChange = 1 THEN LeTabLignesVentes(iLigneVente).Qte := 1;
END IF; IF TypeChange = 2 THEN LeTabLignesVentes(iLigneVente).Qte := -1;
END IF; LeTabLignesVentes(iLigneVente).MotifRetour := NULL; LeTabLignesVentes(iLigneVente).PR := NULL; LeTabLignesVentes(iLigneVente).ReducType := 0; LeTabLignesVentes(iLigneVente).RemiseType := 0; LeTabLignesVentes(iLigneVente).RemManuelle := 0; LeTabLignesVentes(iLigneVente).NumPlan := 0; LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL; LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL; LeTabLignesVentes(iLigneVente).DatHTopGU := NULL; LeTabLignesVentes(iLigneVente).TopArch := NULL; LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour; LeTabLignesVentes(iLigneVente).Numplan := Null;
END IF; -- IF TicketChange = 1 THEN

BEGIN
SELECT 0 INTO TicketAZero FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeLigne = 9 AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN
BEGIN
--************* Si c'est un ticket a 0 (sans ligne de reglement), on en cree une
iLigneRegl := 1; LeTabLignesRegl(iLigneRegl).SteCaisse := Ligne.CodeElementStat; LeTabLignesRegl(iLigneRegl).DateHTransac := Ligne.JourDeVente; LeTabLignesRegl(iLigneRegl).NumCaisse := Ligne.Codemagasin; --Ligne.CodeCaisse;
LeTabLignesRegl(iLigneRegl).NumCaissierTrans := Ligne.CodeCaissiere; LeTabLignesRegl(iLigneRegl).NumTicket := Ligne.NumTicket; LeTabLignesRegl(iLigneRegl).NumLigPaie := 1; LeTabLignesRegl(iLigneRegl).NumCertifCHQ := NULL; LeTabLignesRegl(iLigneRegl).NumAutoCB := NULL; LeTabLignesRegl(iLigneRegl).PaieMode := 11; -- espece par defaut
LeTabLignesRegl(iLigneRegl).PaieMontDev := 0; LeTabLignesRegl(iLigneRegl).PaieMontDev := 0; LeTabLignesRegl(iLigneRegl).Dev := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEDEVISE'); LeTabLignesRegl(iLigneRegl).PaieMontDevSte := 0; LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := NULL; LeTabLignesRegl(iLigneRegl).DateMaj := LaDateMiseAJour;
END; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement ticket a zero, ticket ' || Ligne.NumTicket);
END;
END IF; -- IF LeOldTicket <> LeNewTicket THEN

BEGIN
SELECT 1 INTO TicketClientEnCompte FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeLigne = 9 ANd MotifRetour = 61 AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN TicketClientEnCompte := 0; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement client en compte , ticket ' || Ligne.NumTicket);
END;

--************* On traite les lignes
IF Ligne.TypeInfo = 'Ligne' THEN
--DLA le 01/03/2007 : recherche du libelle de l'opecomm
IF Ligne.CodeOpeComm > 0 THEN
BEGIN
SELECT LibOpeComm INTO LePlanLib FROM OPERATIONS_COMMERCIALES WHERE CODEOPECOMM = Ligne.CodeOpeComm;
EXCEPTION
WHEN NO_DATA_FOUND THEN
BEGIN
SELECT LibOpeComm INTO LePlanLib FROM INT_OPERATIONS_COMMERCIALES WHERE CODEOPECOMM = Ligne.CodeOpeComm;
EXCEPTION
WHEN NO_DATA_FOUND THEN LePlanLib := 'INCONNU';
END;
END;
END IF;

--**************** On traite les lignes de vente de carte cadeau

"			  IF (Ligne.TypeLigne = 7) and (ligne.MotifRetour = NumRecCarteKDO) THEN" "			    BEGIN"

"	     		  SELECT 1,NVL(hc.MTTVA,0),hc.CaNetRealise,hc.CodeSaisie,hc.VolVente,NVL(tp.tauxTva,0),hc.CodeNature" INTO CarteCadeau, MtTvaKdo, CANetKDO, EANSaisieKdo, VolVenteKdo, TauxTvaKdo, CodeNatureKdo FROM HISTORIQUE_CAISSES hc, TVA_PAYS tp "		  WHERE tp.CodeTVA(+) = hc.CodeTVA" AND tp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS') "AND   hc.CodeMagasin	=  Ligne.Codemagasin" "		  AND   hc.JourDeVente	=  Ligne.JourDeVente" "		  AND   hc.CodeCaisse		=  Ligne.CodeCaisse" "		  AND   hc.NumTicket		=  Ligne.NumTicket" "				  AND 	hc.numligne		= ligne.numligne" "		  AND   hc.TypeLigne	 = 7" "		  AND   hc.MotifRetour	= NumRecCarteKDO;"

"				EXCEPTION" "		  WHEN NO_DATA_FOUND THEN CarteCadeau := 0;" WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, ticket ' || Ligne.NumTicket); "			      END;"

iLigneVente := iLigneVente + 1;
-- recherche d'info sur l'EAN
BEGIN
SELECT cp2.codeclassprod1, p.codeclassprod3 INTO LeTabLignesVentes(iLigneVente).Departement, LeTabLignesVentes(iLigneVente).CP FROM PRODUITS p, HISTO_CB_FRN hcf, CLASSPROD2 cp2, CLASSPROD3 cp3 WHERE hcf.codebarres = DECODE(Ligne.CodeCaisse, 1, EANCarteKdo_BM, DECODE(Ligne.CodeCaisse, 2, EANCarteKdo_SEGEP, DECODE(Ligne.CodeCaisse, 3, EANCarteKdo_FF))) AND p.codeproduit = TO_CHAR(hcf.codeinternearticle) AND cp3.codeclassprod3 = p.codeclassprod3 AND cp2.codeclassprod2 = cp3.codeclassprod2;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, recherche du Centre de profit / departement, ticket ' || Ligne.NumTicket);
END;

BEGIN
SELECT HCA, APPL, TYPEGEST INTO LeTabLignesVentes(iLigneVente).HCA, LeTabLignesVentes(iLigneVente).APPL, LeTabLignesVentes(iLigneVente).TYPEGEST FROM LBM_CP_HISTO WHERE CP = LeTabLignesVentes(iLigneVente).CP AND ROWNUM = 1;
EXCEPTION
WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement carte cadeau, recherche du HCA, APPL et TYPEGEST, ticket ' || Ligne.NumTicket);
END; LeTabLignesVentes(iLigneVente).EANSaisie := EANSaisieKdo; LeTabLignesVentes(iLigneVente).PR := 1; LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat; LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente; LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin; LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket; LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente; LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur; LeTabLignesVentes(iLigneVente).TVATaux := TauxTvaKdo; LeTabLignesVentes(iLigneVente).MotifRetour := NULL;

LeTabLignesVentes(iLigneVente).PrixTTCArt := CANetKDO; LeTabLignesVentes(iLigneVente).PrixHTArt := CANetKDO - MtTVAKdo; LeTabLignesVentes(iLigneVente).ExpMont := 0; LeTabLignesVentes(iLigneVente).EscMont := 0; LeTabLignesVentes(iLigneVente).CaNetLigne := CANetKDO; LeTabLignesVentes(iLigneVente).CaNetLigneHT := CANetKDO - MtTVAKdo;

LeTabLignesVentes(iLigneVente).TotRemRed := 0; LeTabLignesVentes(iLigneVente).TotRemRedHT := 0; LeTabLignesVentes(iLigneVente).ReducTotal := 0; LeTabLignesVentes(iLigneVente).MONTACTMARK := 0; LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0; LeTabLignesVentes(iLigneVente).ExpRemise := 0; LeTabLignesVentes(iLigneVente).ExpArt := 0; LeTabLignesVentes(iLigneVente).NumCdeClt := NULL; LeTabLignesVentes(iLigneVente).TvaMont := MtTVAKdo; LeTabLignesVentes(iLigneVente).Qte := VolVenteKdo; LeTabLignesVentes(iLigneVente).ReducType := 0; LeTabLignesVentes(iLigneVente).RemiseType := 0; LeTabLignesVentes(iLigneVente).RemManuelle := 0; LeTabLignesVentes(iLigneVente).NumPlan := 0; LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL; LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL; LeTabLignesVentes(iLigneVente).DatHTopGU := NULL; LeTabLignesVentes(iLigneVente).TopArch := NULL; LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour; LeTabLignesVentes(iLigneVente).Numplan := NULL;
END IF;
-- fin traitement carte cadeau

--**************** On traite les lignes de vente ou de retour
IF (Ligne.TypeLigne = 1) OR (Ligne.TypeLigne = 2) THEN IF TicketClientEnCompte = 1 AND PreNumerotation = 1 THEN
BEGIN
SELECT NUMFACTURE Into NumFacture FROM NUM_FACTURE_TICKET WHERE CodeMagasin = Ligne.CodeMagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND TypeFacture = DECODE(Ligne.TypeLigne, 1, 0, 1);
EXCEPTION
WHEN NO_DATA_FOUND THEN NumFacture := 0;
END; IF NumFacture = 0 THEN
BEGIN
INSERT INTO NUM_FACTURE_TICKET(CODEMAGASIN, JOURDEVENTE, CODECAISSE, NUMTICKET, TYPEFACTURE, NUMFACTURE) VALUES(Ligne.CodeMagasin, Ligne.JourDeVente, Ligne.CodeCaisse, Ligne.NumTicket, DECODE(Ligne.TypeLigne, 1, 0, 1), Retourne_NumFactClientSuivant(Ligne.CodeMagasin));
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN NULL; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors de l''insertion du numero de facture client, ticket ' || Ligne.NumTicket);
END;
END IF;
END IF;

--DLA le 16/05/2007 : impact de la "remise" promo"
-- DLA le 12/10/2007

"				 if ligne.EnPromotion = 1 then" "				 begin" "				 	  select 1 into PromoPourcentage" "						  from tarifs_groupe_magasin" "				 	  where codeinternearticle = ligne.CodeInterneArticle" "				 	  and tauxremise is not null" "				 	  and datedebut <= trunc(ligne.jourdevente)" "				 	  and datefin >= trunc(ligne.jourdevente)" "					  and rownum = 1;" "				exception" "				when no_data_found then" "					 Ligne.MtRemiseOpcomm := 0;" "				end;" "				end if;"

Ligne.MtRemiseReel := Ligne.MtRemiseReel + Ligne.MtRemiseOpcomm;
-- Ligne de vente ou de retour
iLigneVente := iLigneVente + 1;

--******************* Donnees diverses

LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat; LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente; LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin; --Ligne.CodeCaisse;
LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket; LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente; LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
--DLA le 15/05/2007 : on prend Libelle2
--                  LeTabLignesVentes(iLigneVente).EANSaisie := Ligne.CodeSaisie;
LeTabLignesVentes(iLigneVente).EANSaisie := Ligne.Libelle2; LeTabLignesVentes(iLigneVente).Departement := Ligne.CodeClassProd1; LeTabLignesVentes(iLigneVente).CP := Ligne.CodeClassProd3;

--******************* Traitement du montant de l'export a la ligne
--******************* Export sur CABrut, sur CANet et sur remise

IF TicketExport = 1 THEN IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).ExpRemise := round(Ligne.MtRemiseReel * (1 - (1
/
(1 + Ligne.TauxTVA
/
100))), 2); LeTabLignesVentes(iLigneVente).ExpMont := Ligne.MtTVA; LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).ExpRemise + LeTabLignesVentes(iLigneVente).ExpMont;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).ExpRemise := -round(Ligne.MtRemiseReel * (1 - (1
/
(1 + Ligne.TauxTVA
/
100))), 2); LeTabLignesVentes(iLigneVente).ExpMont := -Ligne.MtTVA; LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).ExpRemise + LeTabLignesVentes(iLigneVente).ExpMont;
END IF; ELSE LeTabLignesVentes(iLigneVente).ExpMont := 0; LeTabLignesVentes(iLigneVente).ExpArt := 0; LeTabLignesVentes(iLigneVente).ExpRemise := 0;
END IF;

--******************* Traitement du montant de l'escompte a la ligne
--******************* Si ligne de retour, le montant de l'escompte est 0

IF TicketEscompte = 1 THEN IF Ligne.TypeLigne = 1 THEN IF EscompteNbLigneIntermediaire < EscompteNbLigne THEN
-- ========================================
-- BFU le 28/5/2007 modification calcul repartition de l'escompte (idem WS)
IF EscompteMtIntermediaire < EscompteMtTotal THEN LeTabLignesVentes(iLigneVente).EscMont := ceil((Ligne.CaNetRealise
/
EscompteCATicketTotal) * EscompteMtTotal * 100)
/
100; ELSE LeTabLignesVentes(iLigneVente).EscMont := 0;
END IF;
--         LeTabLignesVentes(iLigneVente).EscMont := floor((Ligne.CaNetRealise / EscompteCATicketTotal) * EscompteMtTotal * 100) / 100;
-- ========================================
EscompteMtIntermediaire := EscompteMtIntermediaire + LeTabLignesVentes(iLigneVente).EscMont; EscompteNbLigneIntermediaire := EscompteNbLigneIntermediaire + 1; ELSE LeTabLignesVentes(iLigneVente).EscMont := EscompteMtTotal - EscompteMtIntermediaire;
END IF;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).EscMont := 0;
END IF; ELSE LeTabLignesVentes(iLigneVente).EscMont := 0;
END IF;

--******************* Traitement du CANET par ligne

--DLA le 13/03/2007 : pour les tickets export, on retire la TVA sur le CANet et les mtremise
-- Si le ticket contient de l'escompte, on retire l'escompte des remise avant ce calcul

IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).CaNetLigne := Ligne.CaNetRealise - LeTabLignesVentes(iLigneVente).ExpMont; LeTabLignesVentes(iLigneVente).CaNetLigneHT := Ligne.CaNetRealise - Ligne.MtTVA;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).CaNetLigne := -Ligne.CaNetRealise - LeTabLignesVentes(iLigneVente).ExpMont; LeTabLignesVentes(iLigneVente).CaNetLigneHT := - (Ligne.CaNetRealise - Ligne.MtTVA);
END IF;

--******************* Traitement de la somme des remises par lignes

IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).TotRemRed := Ligne.MtRemiseReel + LeTabLignesVentes(iLigneVente).ExpMont; LeTabLignesVentes(iLigneVente).TotRemRedHT := (Ligne.MtRemiseReel
/
(1 + (Ligne.TauxTVA
/
100))); --+  LeTabLignesVentes(iLigneVente).ExpMont;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).TotRemRed := -Ligne.MtRemiseReel + LeTabLignesVentes(iLigneVente).ExpMont; LeTabLignesVentes(iLigneVente).TotRemRedHT := - (Ligne.MtRemiseReel
/
(1 + (Ligne.TauxTVA
/
100))); --(LeTabLignesVentes(iLigneVente).TotRemRed / (1 + (Ligne.TauxTVA / 100)));
END IF;

--******************* Traitement du CABrut

LeTabLignesVentes(iLigneVente).PrixTTCArt := LeTabLignesVentes(iLigneVente).CaNetLigne + LeTabLignesVentes(iLigneVente).TotRemRed; LeTabLignesVentes(iLigneVente).PrixHTArt := LeTabLignesVentes(iLigneVente).PrixTTCArt - round((LeTabLignesVentes(iLigneVente).PrixTTCArt * (1 - (1
/
(1 + (Ligne.TauxTVA
/
100))))), 2);
-- ========================================
-- BFU le 28/5/2007 modification calcul expart en fonction du TTC - HT et expremise par difference entre expart et expmont
IF TicketExport = 1 THEN LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).PrixTTCArt - LeTabLignesVentes(iLigneVente).PrixHTArt; LeTabLignesVentes(iLigneVente).ExpRemise := LeTabLignesVentes(iLigneVente).ExpArt - LeTabLignesVentes(iLigneVente).ExpMont;
END IF;
-- ========================================
--******************* Traitement du montant des actions marketing par ligne

IF Ligne.LibRedactionMarketing IS
NOT NULL THEN IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).MONTACTMARK := Ligne.MtRemiseLigne; LeTabLignesVentes(iLigneVente).MONTACTMARKHT := LeTabLignesVentes(iLigneVente).MONTACTMARK
/
(1 + (Ligne.TauxTVA
/
100));
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).MONTACTMARK := -Ligne.MtRemiseLigne; LeTabLignesVentes(iLigneVente).MONTACTMARKHT := - (LeTabLignesVentes(iLigneVente).MONTACTMARK
/
(1 + (Ligne.TauxTVA
/
100)));
END IF; ELSE LeTabLignesVentes(iLigneVente).MONTACTMARK := 0; LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
END IF;

--******************* Autres donnees

LeTabLignesVentes(iLigneVente).Appl := Ligne.Appl; LeTabLignesVentes(iLigneVente).TypeGest := Ligne.TypeGest; LeTabLignesVentes(iLigneVente).NumCdeClt := NULL; LeTabLignesVentes(iLigneVente).TvaTaux := Ligne.TauxTVA; IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).TvaMont := Ligne.MtTVA;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).TvaMont := -Ligne.MtTVA;
END IF; IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).Qte := Ligne.VolVente;
--DLA le 12/05/2007 : ajout du motif de retour
LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
END IF; IF Ligne.TypeLigne = 2 THEN LETABLIGNESVENTES(ILIGNEVENTE).QTE := -LIGNE.VOLVENTE;
--DLA LE 12/05/2007 : AJOUT DU MOTIF DE RETOUR
LETABLIGNESVENTES(ILIGNEVENTE).MOTIFRETOUR := LIGNE.MOTIFRETOUR;
END IF;

LeTabLignesVentes(iLigneVente).PR := Ligne.CodeNature; -- Nature Article, dev ulterieur
-- DLA le 15/03/2007 suite appel N.RAspal

--******************* Si la remise lignes est en montant, on renseigne REDUCTOTAL

IF Ligne.ReducType <> 0 THEN IF Ligne.TypeLigne = 1 THEN LeTabLignesVentes(iLigneVente).ReducTotal := Ligne.MtRemiseLigne;
END IF; IF Ligne.TypeLigne = 2 THEN LeTabLignesVentes(iLigneVente).ReducTotal := -Ligne.MtRemiseLigne;
END IF;
END IF;

--******************* recherche du code de la remise la plus avantageuse

LeTabLignesVentes(iLigneVente).ReducType := 0; LeTabLignesVentes(iLigneVente).RemiseType := 0;
--DLA le 16/05/2007 : impact de la "remise" opcomm
IF Ligne.MtRemiseLigne > (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN IF Ligne.RemiseType <> CodeRemiseEscompte THEN LeTabLignesVentes(iLigneVente).RemiseType := Ligne.RemiseType; LeTabLignesVentes(iLigneVente).ReducType := Ligne.ReducType; ELSE LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseEscompte; LeTabLignesVentes(iLigneVente).ReducType := 0;
END IF; ELSE IF Ligne.RemiseType <> 0 THEN LeTabLignesVentes(iLigneVente).RemiseType := 56; LeTabLignesVentes(iLigneVente).ReducType := 0;
END IF; IF Ligne.ReducType <> 0 THEN LeTabLignesVentes(iLigneVente).ReducType := 56; LeTabLignesVentes(iLigneVente).RemiseType := 0;
END IF;
END IF;
-- DLA le 15/05/2007 : comparaison egalement avec le code remise parametre pour
-- la remise lie a une OpComm en %

IF Ligne.MtRemiseLigne >= (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN IF Ligne.MtRemiseLigne < Ligne.MtRemiseOpComm THEN LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseOpComm; LeTabLignesVentes(iLigneVente).ReducType := 0;
END IF;
END IF;

IF Ligne.MtRemiseLigne < (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN IF (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) < Ligne.MtRemiseOpComm THEN LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseOpComm; LeTabLignesVentes(iLigneVente).ReducType := 0;
END IF;
END IF;

--******************* Autres donnees

LeTabLignesVentes(iLigneVente).RemManuelle := 0; LeTabLignesVentes(iLigneVente).NumPlan := 0; LeTabLignesVentes(iLigneVente).HCA := Ligne.HCA; LeTabLignesVentes(iLigneVente).ActMarkLibReduit := Ligne.LibRedactionMarketing; LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := Ligne.CodeTypeActionMarketing; LeTabLignesVentes(iLigneVente).DatHTopGU := NULL; LeTabLignesVentes(iLigneVente).TopArch := NULL; LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
--DLA le 01/03/2007
LeTabLignesVentes(iLigneVente).Numplan := LePlanLib;

--******************* Traitement des lignes de reglement

ELSIF Ligne.TypeLigne = 9 THEN

iLigneRegl := iLigneRegl + 1;

LeTabLignesRegl(iLigneRegl).SteCaisse := Ligne.CodeElementStat; LeTabLignesRegl(iLigneRegl).DateHTransac := Ligne.JourDeVente; LeTabLignesRegl(iLigneRegl).NumCaisse := Ligne.Codemagasin; --Ligne.CodeCaisse;
LeTabLignesRegl(iLigneRegl).NumCaissierTrans := Ligne.CodeCaissiere; LeTabLignesRegl(iLigneRegl).NumTicket := Ligne.NumTicket; LeTabLignesRegl(iLigneRegl).NumLigPaie := iLigneRegl;

-- DLA le 23/07/2007 : info pour les tickets de change

IF Ligne.Cheque = 1 THEN LeTabLignesRegl(iLigneRegl).NumCertifCHQ := Ligne.NumPieceIdentite; ELSE LeTabLignesRegl(iLigneRegl).NumCertifCHQ := NULL;
END IF;

IF TicketChange = 1 THEN LeTabLignesRegl(iLigneRegl).NumCertifCHQ := '1';
END IF;

LeTabLignesRegl(iLigneRegl).PaieMode := Ligne.MotifRetour;

--DLA le 13/03/2007 : correction sur la remontee du CA en devise
IF Ligne.MtRemise <> 0 THEN LeTabLignesRegl(iLigneRegl).PaieMontDev := Ligne.MtRemise;
BEGIN
SELECT CODEDEVISE INTO LeTabLignesRegl(iLigneRegl).Dev FROM MODES_REGL_MAGASIN_PAYS WHERE CODEPAYS = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS') AND CODEMODEREGLEMENTMAG = Ligne.MotifRetour;
EXCEPTION
WHEN NO_DATA_FOUND THEN RAISE_APPLICATION_ERROR(-20001, 'Pas de devise pour le mode de reglement ' || Ligne.MotifRetour);
END; ELSE LeTabLignesRegl(iLigneRegl).PaieMontDev := Ligne.CaNetRealise; LeTabLignesRegl(iLigneRegl).Dev := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEDEVISE');
END IF;

LeTabLignesRegl(iLigneRegl).PaieMontDevSte := Ligne.CaNetRealise;

--******************* Si paiement par cheque KDO ou liste de mariage
--******************* On recalcule le numero de cheque ou carte a renvoyer

IF Ligne.MotifRetour IN (62, 65) THEN
--               LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr(Ligne.CodeSaisie, 2, 8));
-- BFU le 31/05/2007 : correction bug sur extraction du numero de cheque cadeau (la suppression des zeros de fin ne fonctionnement pas lorsque le modulo de l'ean8 est a 0)
--       LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr((rtrim(substr(Ligne.CodeSaisie, 2, 11), '0')), 1, (length((rtrim(substr(Ligne.CodeSaisie, 2, 11), '0'))))-1));
LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr(Ligne.CodeSaisie, 2, 7));
END IF;

IF Ligne.MotifRetour = 46 THEN LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := '92505300' || substr(Ligne.CodeSaisie, 2, 8);
END IF;

--******************* Si paiement autre que cheque, on met le numero d'identification remonte
IF Ligne.MotifRetour IN (42, 44, 45, 52, 43, 47) THEN LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.NumPieceIdentite; LeTabLignesRegl(iLigneRegl).NumAutoCB := TEST_CodeSaisie(Ligne.CodeSaisie);
END IF;
--******************* Si c'est un client en compte, on met le code client dans NumIdMoyPaie
-- DLA le 16/05/2007 : si client en compte, alors on met code client

IF Ligne.MotifRetour = 61 THEN LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.CodeClient;

BEGIN
SELECT NUMFACTURE Into LeTabLignesRegl(iLigneRegl).NumCertifCHQ FROM NUM_FACTURE_TICKET WHERE CodeMagasin = Ligne.CodeMagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN NULL; WHEN OTHERS THEN RAISE_APPLICATION_ERROR(-20001, 'Probleme lors de la recuperation du numero de facture client, ticket ' || Ligne.NumTicket);
END;
END IF; "IF Ligne.MotifRetour	= NumReglCarteKDO THEN" LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.CodeSaisie;
END IF;

LeTabLignesRegl(iLigneRegl).DateMaj := LaDateMiseAJour;
END IF;

--******************* Si c'est un credit, on met le numero de credit dans NumIdMoyPaie

IF Ligne.MotifRetour IN (32, 33, 34) THEN LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.NumPieceIdentite;
END IF;
--******************* Traitement des PIED de ticket (creation d'une entete)
ELSE
-- Pied de ticket => alimentation de la structure de l'entete de ticket
-- et insertion des donnees dans les tables BizTalk
LeEnteteVente.SteCaisse := Ligne.CodeElementStat; LeEnteteVente.DateHTrans := Ligne.JourDeVente; LeEnteteVente.NumCaisse := Ligne.CodeMagasin; --Ligne.CodeCaisse;
LeEnteteVente.NumCaissierTrans := Ligne.CodeCaissiere; LeEnteteVente.NumTicket := Ligne.NumTicket; IF TicketExport = 1 THEN LeEnteteVente.Export := 'O'; ELSE LeEnteteVente.Export := 'N';
END IF; LeEnteteVente.CaNetTTC := Ligne.CaNetRealise; LeEnteteVente.NumClt := Ligne.CodeClient; LeEnteteVente.Escpt := 0;

BEGIN
SELECT CodeCarte INTO LeEnteteVente.NumCartePriv FROM HISTORIQUE_CAISSES WHERE CodeMagasin = Ligne.Codemagasin AND JourDeVente = Ligne.JourDeVente AND CodeCaisse = Ligne.CodeCaisse AND NumTicket = Ligne.NumTicket AND CODECARTE IS
NOT NULL AND ROWNUM = 1;
EXCEPTION
WHEN NO_DATA_FOUND THEN LeEnteteVente.NumCartePriv := NULL;
END;

LeEnteteVente.DateHTOPCA := NULL; LeEnteteVente.DateMaj := LaDateMiseAJour;

--******************* Alimentation des tables BizTalk

--DLA le 28/02/2007 : on tronque le numticket dans tous les INSERT
BEGIN
INSERT INTO LBM_TICKET_EXTRAIT(CODEMAGASIN, JOURDEVENTE, CODECAISSE, NUMTICKET) VALUES(Ligne.CodeMagasin, Ligne.JourDeVente, Ligne.CodeCaisse, TO_NUMBER(SUBSTR(LIGNE.NUMTICKET, 4, 10))
--        Ligne.NumTicket
);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN EFFACE_LBM_TICKET_A_EXTRAIRE_A(Ligne.CodeMagasin, "				  Ligne.JourDeVente," Ligne.CodeCaisse, "				  Ligne.NumTicket);"
--                COMMIT;
RAISE_APPLICATION_ERROR(-20001, 'Ce ticket est deja present dans la table LBM_TICKET_EXTRAIT');
END;

BEGIN
INSERT INTO LBM_VENTE_ENTETE(STECAISSE, DATEHTRANS, NUMCAISSE, NUMCAISSIERTRANS, NUMTICKET, EXPORT, NUMCLT, CANETTTC, ESCPT, NUMCARTEPRIV, DATEHTOPCA, DATEMAJ, "				 TOPCA," "				 TOPLM") VALUES(LeEnteteVente.SteCaisse, LeEnteteVente.DateHTrans, LeEnteteVente.NumCaisse, LeEnteteVente.NumCaissierTrans, TO_NUMBER(SUBSTR(LeEnteteVente.NumTicket, 4, 10)),
--     LeEnteteVente.NumTicket,
LeEnteteVente.Export, LeEnteteVente.NumClt, LeEnteteVente.CaNetTTC, LeEnteteVente.Escpt, LeEnteteVente.NumCartePriv, LeEnteteVente.DateHTOPCA, LeEnteteVente.DateMaj, "				 0," "				 0");
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN RAISE_APPLICATION_ERROR(-20001, 'Une entete de ticket identique est deja presente dans la table LBM_VENTE_POSTE');
END;

FOR lVente IN 1 .. iLigneVente LOOP
BEGIN
INSERT INTO LBM_VENTE_POSTE(STECAISSE, DATEHTRANS, NUMCAISSE, NUMTICKET, NUMLIGNE, CODEVEND, EANSAISIE, DEPARTEMENT, CP, PRIXTTCART, CANETLIGNE, APPL, TYPEGEST, NUMCDECLT, TOTREMRED, TVATAUX, TVAMONT, QTE, PR, REDUCTOTAL, ESCMONT, REDUCTYPE, REMISETYPE, REMMANUELLE, NUMPLAN, HCA, ACTMARKLIBREDUIT, ACTMARKCODEDUTYPE, DATHTOPGU, TOPARCH, DATEMAJ, EXPMONT, PRIXHTART, TOTREMREDHT, CANETLIGNEHT, MONTACTMARKHT, MONTACTMARK, EXPART, EXPREMISE, MOTIFRETOUR, "				   TOPGU") VALUES(LeTabLignesVentes(lVente).SteCaisse, LeTabLignesVentes(lVente).DateHTrans, LeTabLignesVentes(lVente).NumCaisse, TO_NUMBER(SUBSTR(LeTabLignesVentes(lVente).NumTicket, 4, 10)),
--             LeTabLignesVentes(lVente).NumTicket,
LeTabLignesVentes(lVente).NumLigne, LeTabLignesVentes(lVente).CodeVend, LeTabLignesVentes(lVente).EanSaisie, LeTabLignesVentes(lVente).Departement, LeTabLignesVentes(lVente).Cp, LeTabLignesVentes(lVente).PrixTTCArt, LeTabLignesVentes(lVente).CANetLigne, LeTabLignesVentes(lVente).Appl, LeTabLignesVentes(lVente).TypeGest, LeTabLignesVentes(lVente).NumCdeCLT, LeTabLignesVentes(lVente).TotRemRed, LeTabLignesVentes(lVente).TvaTaux, LeTabLignesVentes(lVente).TvaMont, LeTabLignesVentes(lVente).Qte, LeTabLignesVentes(lVente).Pr, LeTabLignesVentes(lVente).ReducTotal, LeTabLignesVentes(lVente).EscMont, LeTabLignesVentes(lVente).ReducType, LeTabLignesVentes(lVente).RemiseType, LeTabLignesVentes(lVente).RemManuelle, LeTabLignesVentes(lVente).NumPlan, LeTabLignesVentes(lVente).Hca, LeTabLignesVentes(lVente).ActMarkLibReduit, LeTabLignesVentes(lVente).ActMarkCodeDuType, LeTabLignesVentes(lVente).DatHTOPGU, LeTabLignesVentes(lVente).TopArch, LeTabLignesVentes(lVente).DateMaj, LeTabLignesVentes(lVente).EXPMONT, LeTabLignesVentes(lVente).PRIXHTART, LeTabLignesVentes(lVente).TOTREMREDHT, LeTabLignesVentes(lVente).CANETLIGNEHT, LeTabLignesVentes(lVente).MONTACTMARKHT, LeTabLignesVentes(lVente).MONTACTMARK, LeTabLignesVentes(lVente).EXPART, LeTabLignesVentes(lVente).EXPREMISE, LeTabLignesVentes(lVente).MOTIFRETOUR, "				   0");
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN RAISE_APPLICATION_ERROR(-20001, 'Une ligne de ticket identique est deja presente dans la table LBM_VENTE_POSTE');
END;
END LOOP;

FOR lRegl IN 1 .. iLigneRegl LOOP
BEGIN
INSERT INTO LBM_VENTE_REGLEMENT(STECAISSE, DATEHTRANSAC, NUMCAISSE, NUMCAISSIERTRANS, NUMTICKET, NUMLIGPAIE, NUMCERTIFCHQ, NUMAUTOCB, PAIEMODE, PAIEMONTDEV, DEV, PAIEMONTDEVSTE, NUMIDMOYPAIE, DATEMAJ) VALUES(LeTabLignesRegl(lRegl).SteCaisse, LeTabLignesRegl(lRegl).DateHTRansac, LeTabLignesRegl(lRegl).NumCaisse, LeTabLignesRegl(lRegl).NumCaissierTrans, TO_NUMBER(SUBSTR(LeTabLignesRegl(lRegl).NumTicket, 4, 10)),
--     LeTabLignesRegl(lRegl).NumTicket,
LeTabLignesRegl(lRegl).NumLigPaie, LeTabLignesRegl(lRegl).NumCertifChq, LeTabLignesRegl(lRegl).NumAutoCb, LeTabLignesRegl(lRegl).PaieMode, LeTabLignesRegl(lRegl).PaieMontDev, LeTabLignesRegl(lRegl).Dev, LeTabLignesRegl(lRegl).PaieMontDevSte, LeTabLignesRegl(lRegl).NumIdMoyPaie, LeTabLignesRegl(lRegl).DateMaj);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN RAISE_APPLICATION_ERROR(-20001, 'Une ligne de reglement identique est deja presente dans la table LBM_VENTE_REGLEMENT');
END;
END LOOP;

--******************* Une fois le ticket extrait, on le supprime de la tablme des tickets a extraire
EFFACE_LBM_TICKET_A_EXTRAIRE(Ligne.CodeMagasin, Ligne.JourDeVente, Ligne.CodeCaisse, Ligne.NumTicket);

--******************* Une fois le ticket extrait, on reinitialise les donnees
InitTicket;
END IF;
END IF;
EXCEPTION
WHEN OTHERS THEN TicketEnErreur := 1; ROLLBACK; Ajouter_Log(1, LeCodeMsg, 'Erreur lors de l''integration  du ticket ' || Ligne.NumTicket || ' du ' || Ligne.JourDeVente || ' pour le magasin ' || Ligne.CodeMagasin || ' caisse ' || Ligne.CodeCaisse || ' :' || CHR(13) || SQLERRM(SQLCODE));
-- Reinit des donnees
"		  InitTicket;"
END;
END LOOP;
-- DLA le 28/03/2007 : ce commit est place ici pour assurer l'integration du dernier ticket
-- En effet, l'autre commit est place au changement de ticket, qui n'a jamais lieu pour
-- le dernier
test_ticket(LaSteCaisseEnCours, LeNumCaisseEnCours, LeNumTicketEnCours, LaDateHTransEnCours);
--   COMMIT;
EXCEPTION
WHEN OTHERS THEN Ajouter_Log(1, LeCodeMsg, 'Erreur lors de de la generation des ventes : ' || CHR(13) || SQLERRM(SQLCODE));
END; Ajouter_Log(3, LeCodeMsg, 'Fin de la generation des ventes par LBM_ VENTE'); ROLLBACK;
END;

/*******************************************************************/
/*  Procedure PRC_LBM_TypeRemise                                   */
/*                                                                 */
/*  Extraction des types de remise depuis Storeland vers BizTalk   */
/*                                                                 */
/*  SM 07/11/2006 #20104 Creation                                  */
/*                                                                 */
/*******************************************************************/

PROCEDURE PRC_LBM_TypeRemise IS
LeCodeMsg Log_Traitements.CodeMsg%TYPE; LaDateMiseAJour DATE;

LeTypeRemise TRecLBMTypeRemise;
BEGIN
LeCodeMsg := 'BIZ-0006'; LaDateMiseAJour := SYSDATE;

Ajouter_Log(3, LeCodeMsg, 'Lancement de la generation des types de remises par LBM_ TYPEREMISE');

BEGIN
FOR Ligne IN (SELECT CodeTypeRemise, LibTypeRemise FROM TYPES_REMISE) LOOP
BEGIN
-- Extraction des donnees depuis Storeland
LeTypeRemise.RemiseType := Ligne.CodeTypeRemise; LeTypeRemise.RemiseLib := Ligne.LibTypeRemise; LeTypeRemise.DateMaj := LaDateMiseAJour;

-- Insertion des donnees dans les tables BizTalk
BEGIN
INSERT INTO LBM_TYPE_REMISE(REMISETYPE, REMISELIB, DATEMAJ) VALUES(LeTypeRemise.RemiseType, LeTypeRemise.RemiseLib, LeTypeRemise.DateMaj);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN NULL;
--              RAISE_APPLICATION_ERROR(-20001, 'Un enregistrement existe deja dans la table LBM_TYPE_REMISE pour ce code RemiseType.');
END; COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK; Ajouter_Log(1, LeCodeMsg, 'Erreur lors de l''extraction du type de remise ' || LeTypeRemise.RemiseType || '(' || LeTypeRemise.RemiseLib || ') : ' || CHR(13) || SQLERRM(SQLCODE));
END;
END LOOP;
EXCEPTION
WHEN OTHERS THEN Ajouter_Log(1, LeCodeMsg, 'Une erreur s''est produite lors de l''extraction des types de remises : ' || CHR(13) || SQLERRM(SQLCODE));
END; Ajouter_Log(3, LeCodeMsg, 'Fin de la generation des types de remises par LBM_ TYPEREMISE');
END;

/*******************************************************************/
/*  Procedure PRC_LBM_TypeAM                                       */
/*                                                                 */
/*  Extraction des types d'action markeetingh                      */
/*  depuis Storeland vers BizTalk                                  */
/*                                                                 */
/*  SM 07/11/2006 #20104 Creation                                  */
/*                                                                 */
/*******************************************************************/

PROCEDURE PRC_LBM_TypeAM IS
LeCodeMsg Log_Traitements.CodeMsg%TYPE; LaDateMiseAJour DATE;

LeTypeActionMarketing TRecLBMActionMarketing;
BEGIN
LeCodeMsg := 'BIZ-0007'; LaDateMiseAJour := SYSDATE;

Ajouter_Log(3, LeCodeMsg, 'Lancement de la generation des types AM par LBM_ TYPEAM');

BEGIN
FOR Ligne IN (SELECT CodeTypeActionMarketing, LibTypeActionMarketing FROM TYPES_ACTION_MARKETING) LOOP
BEGIN
-- Extraction des donnees depuis Storeland
LeTypeActionMarketing.ActMarkCodeType := Ligne.CodeTypeActionMarketing; LeTypeActionMarketing.ActMarkLibDuType := Ligne.LibTypeActionMarketing; LeTypeActionMarketing.DateMaj := LaDateMiseAJour;

-- Insertion des donnees dans les tables BizTalk
BEGIN
INSERT INTO LBM_ACTION_MARKETING(ACTMARKCODETYPE, ACTMARKLIBDUTYPE, DATEMAJ) VALUES(LeTypeActionMarketing.ActMarkCodeType, LeTypeActionMarketing.ActMarkLibDuType, LeTypeActionMarketing.DateMaj);
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN NULL;
--              RAISE_APPLICATION_ERROR(-20001, 'Un enregistrement existe deja dans la table LBM_ACTION_MARKETING pour ce code ActMarkCodeType.');
END; COMMIT;
EXCEPTION
WHEN OTHERS THEN ROLLBACK; Ajouter_Log(1, LeCodeMsg, 'Erreur lors de l''extraction du type d''action marketing ' || LeTypeActionMarketing.ActMarkCodeType || '(' || LeTypeActionMarketing.ActMarkLibDuType || ') : ' || CHR(13) || SQLERRM(SQLCODE));
END;
END LOOP;
EXCEPTION
WHEN OTHERS THEN Ajouter_Log(1, LeCodeMsg, 'Une erreur s''est produite lors de l''extraction des types d''action marketing : ' || CHR(13) || SQLERRM(SQLCODE));
END; Ajouter_Log(3, LeCodeMsg, 'Fin de la generation des types AM par LBM_ TYPEAM');
END;

/*******************************************************************/
/*  Procedure LBM_Extractions                                      */
/*                                                                 */
/*  Lancement des Extractions :                                    */
/*    - Ventes                                                     */
/*    - Types Remises                                              */
/*    - Types Actions Marketing                                    */
/*                                                                 */
/*  SM 07/11/2006 #20104 Creation                                  */
/*  DLA 08/01/2007<pas de gestion de code traitement               */
/*                                                                 */
/*******************************************************************/

PROCEDURE LBM_Extractions IS
LeCodeMsg Log_Traitements.CodeMsg%TYPE;
BEGIN
LeCodeMsg := 'BIZ-0008';
-- Incrementation du code traitement BizTalk
--     BEGIN
--       SELECT NVL(CodeMsgLog, 0) + 1 INTO LeCodeTraitementBizTalk
--       FROM LBM_PARAM_INTERFACE;
--
--       UPDATE LBM_PARAM_INTERFACE
--       SET CodeMsgLog = LeCodeTraitementBizTalk;
--     EXCEPTION
--       WHEN NO_DATA_FOUND THEN
--         LeCodeTraitementBizTalk := -1;
--     END;

Ajouter_Log(3, LeCodeMsg, 'Debut des extractions Storeland vers BizTalk');

-- SM 28/02/2007 gestion d'un lock pour eviter le lancement du traitement si il est deja en cours
BEGIN
INSERT INTO TABLE_LOCK(NOMTABLE, ENREGISTREMENT, NUMPOSTE, CODEUTILISATEUR) VALUES('PK_LBM', 'LBM_Extractions', 0, 0); COMMIT;

--    IF LeCodeTraitementBizTalk <> -1  THEN
BEGIN
"	    PRC_LBM_VENTE;" PRC_LBM_TypeRemise; PRC_LBM_TypeAM;
EXCEPTION
"	    WHEN OTHERS THEN" "		  ROLLBACK;" "		  Ajouter_Log(1, LeCodeMsg, 'Erreur lors de l''extraction des ventes '||SQLERRM(SQLCODE));"
END;
--    ELSE
--      Ajouter_Log(1, LeCodeMsg, 'Les parametres de l''interface ne sont pas alimentes.');
--    END IF;

DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'PK_LBM' AND ENREGISTREMENT = 'LBM_Extractions' AND NUMPOSTE = 0 AND CODEUTILISATEUR = 0;

COMMIT;

EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN NULL;
END;

Ajouter_Log(3, LeCodeMsg, 'Fin des extractions Storeland vers BizTalk');
-- DLA le 26/12/2006 :modification, on transporte un ID fourni par BizTalk
--    CodeTraitementExtraction := LeCodeTraitementBizTalk;
-- DLA le 26/12/2006 : FIN modification, on transporte un ID fourni par BizTalk
END;

END PK_LBM_dla;
