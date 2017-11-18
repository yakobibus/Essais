create PACKAGE pk_lbm AS
  /**************************************************************************************************************/
  /*                                    PACKAGE SPECIFIQUE LE BON MARCHE                                        */
  /*  Permet d'alimenter les tables tampon storeland depuis les tables specifiques BizTalk pour integration     */
  /*  dans Storeland via le package standard PK_INTERFACE                                                       */
  /*                                                                                                            */
  /*  SM 06/11/2006 #20104 Creation                                                                             */
  /*  PB 12/06/2007 MAJ Client en  Compte  #21574                                                               */
  /*  BP 24/10/2008 #27260 Interface Biztalk                                                                    */
  /*  AD 08/04/2009 #31480 Corrections diverses                                                                 */
  /* JJD 29/10/2009 #35737 le commit global n'inclue pas les frais de port                                      */
  /* JJD 30/10/2009 #35725 Commandes non transferees                                                            */
  /* JJD 17/12/2009 #36829 Ajout traces extractions commandes                                                   */
  /* JJD 22/12/2009 #37126 Non extraction des commandes --> Ajout d'autres traces                               */
  /* JJD 22/12/2009 #35899 Mise a jour du statut en une transaction                                             */
  /* JJD 30/12/2009 #37228 Gestion des TOP dans interface commandes --> Report de modifications realisees sur   */
  /*                       la base de production                                                                */
  /*                #37231 Controle de commande ok si FdP=0 --> Report de modifications realisees sur la base   */
  /*                       de production                                                                        */
  /*                                                                                                            */
  /**************************************************************************************************************/
  TYPE trecproduit IS RECORD(
     codeproduit               produits.codeproduit%TYPE
    ,nomproduit                produits.nomproduit%TYPE
    ,libproduit                produits.libproduit%TYPE
    ,codesaison                produits.codesaison%TYPE
    ,codeclassprod3            produits.codeclassprod3%TYPE
    ,codegrilletaille          produits.codegrilletaille%TYPE
    ,codetypeetiquette         produits.codetypeetiquette%TYPE
    ,codedouanier              produits.codedouanier%TYPE
    ,codetypestockage          produits.codetypestockage%TYPE
    ,poidsproduit              produits.poidsproduit%TYPE
    ,volumeproduit             produits.volumeproduit%TYPE
    ,epaisseurproduit          produits.epaisseurproduit%TYPE
    ,observations              produits.observations%TYPE
    ,codeutilisateur           produits.codeutilisateur%TYPE
    ,datecreation              produits.datecreation%TYPE
    ,datemodification          produits.datemodification%TYPE
    ,codegrillevariante        produits.codegrillevariante%TYPE
    ,datesuppression           produits.datesuppression%TYPE
    ,codecolorissel            produits.codecolorissel%TYPE
    ,produitgratuit            produits.produitgratuit%TYPE
    ,aucatalogueweb            produits.aucatalogueweb%TYPE
    ,datefinvie                produits.datefinvie%TYPE
    ,poids                     produits.poids%TYPE
    ,jauge                     produits.jauge%TYPE
    ,unitelogistique           produits.unitelogistique%TYPE
    ,typeproduit               produits.typeproduit%TYPE
    ,codetypereassort          produits.codetypereassort%TYPE
    ,codepaysorigine           produits.codepaysorigine%TYPE
    ,observationssurbc         produits.observationssurbc%TYPE
    ,codepaysoriginematiere    produits.codepaysoriginematiere%TYPE
    ,longueurproduit           produits.longueurproduit%TYPE
    ,hauteurproduit            produits.hauteurproduit%TYPE
    ,codetypeemballage         produits.codetypeemballage%TYPE
    ,delaireassort             produits.delaireassort%TYPE
    ,dureedevie                produits.dureedevie%TYPE
    ,codetypemethodereassort   produits.codetypemethodereassort%TYPE
    ,zonededoute               produits.zonededoute%TYPE
    ,datefincdedirecte         produits.datefincdedirecte%TYPE
    ,codeunitepresentation     produits.codeunitepresentation%TYPE
    ,nbpieceparunitepresent    produits.nbpieceparunitepresent%TYPE
    ,datemodificationassort    produits.datemodificationassort%TYPE
    ,exclusionfidelite         produits.exclusionfidelite%TYPE
    ,codedouanier2             produits.codedouanier2%TYPE
    ,codeunitegestionvente     produits.codeunitegestionvente%TYPE
    ,codeunitegestionstock     produits.codeunitegestionstock%TYPE
    ,codeunitegestionachat     produits.codeunitegestionachat%TYPE
    ,indicetaillebase          produits.indicetaillebase%TYPE
    ,datemodificationtfj       produits.datemodificationtfj%TYPE
    ,nbpiecesparuniterangement produits.nbpiecesparuniterangement%TYPE);

  TYPE trecproduitcoloris IS RECORD(
     codeproduit                produits_coloris.codeproduit%TYPE
    ,codecoloris                produits_coloris.codecoloris%TYPE
    ,libcolorismodifie          produits_coloris.libcolorismodifie%TYPE
    ,codecourbedevie            produits_coloris.codecourbedevie%TYPE
    ,codeetat                   produits_coloris.codeetat%TYPE
    ,datecreation               produits_coloris.datecreation%TYPE
    ,datemodification           produits_coloris.datemodification%TYPE
    ,codesaisongestion          produits_coloris.codesaisongestion%TYPE
    ,datesuppression            produits_coloris.datesuppression%TYPE
    ,codecibleimplantation      produits_coloris.codecibleimplantation%TYPE
    ,datemodifcibleimplantation produits_coloris.datemodifcibleimplantation%TYPE
    ,datedebutsaisongestion     produits_coloris.datedebutsaisongestion%TYPE
    ,dateimplantationprevue     produits_coloris.dateimplantationprevue%TYPE
    ,areimplanter               produits_coloris.areimplanter%TYPE
    ,codeetatimplantation       produits_coloris.codeetatimplantation%TYPE
    ,codeetatpourpalmares       produits_coloris.codeetatpourpalmares%TYPE);

  TYPE trecarticle IS RECORD(
     codeinternearticle articles.codeinternearticle%TYPE
    ,codeproduit        articles.codeproduit%TYPE
    ,codecoloris        articles.codecoloris%TYPE
    ,codegrilletaille   articles.codegrilletaille%TYPE
    ,indice             articles.indice%TYPE
    ,codebarres         articles.codebarres%TYPE
    ,qtetotaleachetee   articles.qtetotaleachetee%TYPE
    ,qteacheteereinit   articles.qteacheteereinit%TYPE
    ,valtotaleachatht   articles.valtotaleachatht%TYPE
    ,valachathtreinit   articles.valachathtreinit%TYPE
    ,codedevise         articles.codedevise%TYPE
    ,codeetat           articles.codeetat%TYPE
    ,arretreassort      articles.arretreassort%TYPE
    ,datecreation       articles.datecreation%TYPE
    ,datemodification   articles.datemodification%TYPE
    ,codegrillevariante articles.codegrillevariante%TYPE
    ,indicevariante     articles.indicevariante%TYPE
    ,gereenstock        articles.gereenstock%TYPE
    ,nonremise          articles.nonremise%TYPE
    ,stkoptimalmini     articles.stkoptimalmini%TYPE
    ,stkoptimalmaxi     articles.stkoptimalmaxi%TYPE
    ,articlecentrale    articles.articlecentrale%TYPE
    ,prixrevientind     articles.prixrevientind%TYPE
    ,pcb                articles.pcb%TYPE
    ,datesuppression    articles.datesuppression%TYPE
    ,codenature         articles.codenature%TYPE);

  TYPE trectvaproduitpays IS RECORD(
     codepays    tva_produit_pays.codepays%TYPE
    ,codeproduit tva_produit_pays.codeproduit%TYPE
    ,codetva     tva_produit_pays.codetva%TYPE);

  TYPE trecean IS RECORD(
     codefournisseur     histo_cb_frn.codefournisseur%TYPE
    ,codeinternearticle  histo_cb_frn.codeinternearticle%TYPE
    ,datefinapplication  histo_cb_frn.datefinapplication%TYPE
    ,codebarres          histo_cb_frn.codebarres%TYPE
    ,reffournisseur      histo_cb_frn.reffournisseur%TYPE
    ,colorisfournisseur  histo_cb_frn.colorisfournisseur%TYPE
    ,taillefournisseur   histo_cb_frn.taillefournisseur%TYPE
    ,variantefournisseur histo_cb_frn.variantefournisseur%TYPE
    ,datecreation        histo_cb_frn.datecreation%TYPE);

  TYPE trectarif IS RECORD(
     codepays           tarifs.codepays%TYPE
    ,codeinternearticle tarifs.codeinternearticle%TYPE
    ,datedebut          tarifs.datedebut%TYPE
    ,datefin            tarifs.datefin%TYPE
    ,codetypetarif      tarifs.codetypetarif%TYPE
    ,pvttc              tarifs.pvttc%TYPE
    ,codeopecomm        tarifs.codeopecomm%TYPE
    ,datecreation       tarifs.datecreation%TYPE
    ,datemodification   tarifs.datemodification%TYPE
    ,pveuro             tarifs.pveuro%TYPE);

  TYPE trectariffutur IS RECORD(
     codepays           int_tarifs_futurs.codepays%TYPE
    ,codeinternearticle int_tarifs_futurs.codeinternearticle%TYPE
    ,codetypetarif      int_tarifs_futurs.codetypetarif%TYPE
    ,datedebut          int_tarifs_futurs.datedebut%TYPE
    ,datefin            int_tarifs_futurs.datefin%TYPE
    ,pvttc              int_tarifs_futurs.pvttc%TYPE
    ,datecreation       int_tarifs_futurs.datecreation%TYPE
    ,datemodification   int_tarifs_futurs.datemodification%TYPE
    ,pveuro             int_tarifs_futurs.pveuro%TYPE
    ,dateenvoi          int_tarifs_futurs.dateenvoi%TYPE
    ,codegroupemagasin  int_tarifs_futurs.codegroupemagasin%TYPE);

  TYPE trectarifgroupemag IS RECORD(
     codegroupemagasin    tarifs_groupe_magasin.codegroupemagasin%TYPE
    ,codeinternearticle   tarifs_groupe_magasin.codeinternearticle%TYPE
    ,datedebut            tarifs_groupe_magasin.datedebut%TYPE
    ,datefin              tarifs_groupe_magasin.datefin%TYPE
    ,codetypetarif        tarifs_groupe_magasin.codetypetarif%TYPE
    ,pvttc                tarifs_groupe_magasin.pvttc%TYPE
    ,codeopecomm          tarifs_groupe_magasin.codeopecomm%TYPE
    ,datecreation         tarifs_groupe_magasin.datecreation%TYPE
    ,datemodification     tarifs_groupe_magasin.datemodification%TYPE
    ,pveuro               tarifs_groupe_magasin.pveuro%TYPE
    ,transfertversmagasin tarifs_groupe_magasin.transfertversmagasin%TYPE
    ,tauxremise           tarifs_groupe_magasin.tauxremise%TYPE);

  --DLA le 01/03/2007 : la recherche se fait sur le libelle (le code n'est pas descendu), ceuli ci est UNIQUE
  TYPE ttabcodesopecomm IS TABLE OF operations_commerciales.libopecomm%TYPE INDEX BY BINARY_INTEGER;

  --TYPE TTabCodesOpeComm IS TABLE OF OPERATIONS_COMMERCIALES.CodeOpeComm%TYPE INDEX BY BINARY_INTEGER;
  TYPE trechierarchieprod IS RECORD(
     codeclassprod    classprod3.codeclassprod3%TYPE
    ,libclassprod     classprod3.libclassprod3%TYPE
    ,codepere         classprod3.codeclassprod2%TYPE
    ,datecreation     classprod3.datecreation%TYPE
    ,datemodification classprod3.datemodification%TYPE
    ,elementniv       lbm_hierarchie.elementniv%TYPE);

  TYPE treclbmventeentete IS RECORD(
     stecaisse        lbm_vente_entete.stecaisse%TYPE
    ,datehtrans       lbm_vente_entete.datehtrans%TYPE
    ,numcaisse        lbm_vente_entete.numcaisse%TYPE
    ,numcaissiertrans lbm_vente_entete.numcaissiertrans%TYPE
    ,numticket        lbm_vente_entete.numticket%TYPE
    ,export           lbm_vente_entete.export%TYPE
    ,numclt           lbm_vente_entete.numclt%TYPE
    ,canetttc         lbm_vente_entete.canetttc%TYPE
    ,escpt            lbm_vente_entete.escpt%TYPE
    ,numcartepriv     lbm_vente_entete.numcartepriv%TYPE
    ,datehtopca       lbm_vente_entete.datehtopca%TYPE
    ,datemaj          lbm_vente_entete.datemaj%TYPE
    ,delaiarticle     histo_tic_entete.elementn%TYPE
    ,delaipaiement    histo_tic_entete.elementn%TYPE);

  TYPE treclbmventeposte IS RECORD(
     stecaisse    lbm_vente_poste.stecaisse%TYPE
    ,datehtrans   lbm_vente_poste.datehtrans%TYPE
    ,numcaisse    lbm_vente_poste.numcaisse%TYPE
    ,numticket    lbm_vente_poste.numticket%TYPE
    ,numligne     lbm_vente_poste.numligne%TYPE
    ,codevend     lbm_vente_poste.codevend%TYPE
    ,eansaisie    lbm_vente_poste.eansaisie%TYPE
    ,departement  lbm_vente_poste.departement%TYPE
    ,cp           lbm_vente_poste.cp%TYPE
    ,prixttcart   lbm_vente_poste.prixttcart%TYPE
    ,prixhtart    lbm_vente_poste.prixttcart%TYPE
    ,canetligne   lbm_vente_poste.canetligne%TYPE
    ,canetligneht lbm_vente_poste.canetligne%TYPE
    ,appl         lbm_vente_poste.appl%TYPE
    ,typegest     lbm_vente_poste.typegest%TYPE
    ,numcdeclt    lbm_vente_poste.numcdeclt%TYPE
    ,totremred    lbm_vente_poste.totremred%TYPE
    ,totremredht  lbm_vente_poste.totremred%TYPE
    ,tvataux      lbm_vente_poste.tvataux%TYPE
    ,tvamont      lbm_vente_poste.tvamont%TYPE
    ,qte          lbm_vente_poste.qte%TYPE
    ,pr           lbm_vente_poste.pr%TYPE
    ,reductotal   lbm_vente_poste.reductotal%TYPE
    ,escmont      lbm_vente_poste.escmont%TYPE
    ,
    --DLA le 13/03/2007
    expmont           lbm_vente_poste.expmont%TYPE
    ,montactmark       lbm_vente_poste.montactmark%TYPE
    ,montactmarkht     lbm_vente_poste.montactmark%TYPE
    ,reductype         lbm_vente_poste.reductype%TYPE
    ,remisetype        lbm_vente_poste.remisetype%TYPE
    ,remmanuelle       lbm_vente_poste.remmanuelle%TYPE
    ,numplan           lbm_vente_poste.numplan%TYPE
    ,hca               lbm_vente_poste.hca%TYPE
    ,actmarklibreduit  lbm_vente_poste.actmarklibreduit%TYPE
    ,actmarkcodedutype lbm_vente_poste.actmarkcodedutype%TYPE
    ,dathtopgu         lbm_vente_poste.dathtopgu%TYPE
    ,toparch           lbm_vente_poste.toparch%TYPE
    ,datemaj           lbm_vente_poste.datemaj%TYPE
    ,expart            lbm_vente_poste.expart%TYPE
    ,expremise         lbm_vente_poste.expremise%TYPE
    ,motifretour       lbm_vente_poste.motifretour%TYPE);

  TYPE tablignevente IS TABLE OF treclbmventeposte INDEX BY BINARY_INTEGER;

  TYPE treclbmventereglement IS RECORD(
     stecaisse        lbm_vente_reglement.stecaisse%TYPE
    ,datehtransac     lbm_vente_reglement.datehtransac%TYPE
    ,numcaisse        lbm_vente_reglement.numcaisse%TYPE
    ,numcaissiertrans lbm_vente_reglement.numcaissiertrans%TYPE
    ,numticket        lbm_vente_reglement.numticket%TYPE
    ,numligpaie       lbm_vente_reglement.numligpaie%TYPE
    ,numcertifchq     lbm_vente_reglement.numcertifchq%TYPE
    ,numautocb        lbm_vente_reglement.numautocb%TYPE
    ,paiemode         lbm_vente_reglement.paiemode%TYPE
    ,paiemontdev      lbm_vente_reglement.paiemontdev%TYPE
    ,dev              lbm_vente_reglement.dev%TYPE
    ,paiemontdevste   lbm_vente_reglement.paiemontdevste%TYPE
    ,numidmoypaie     lbm_vente_reglement.numidmoypaie%TYPE
    ,datemaj          lbm_vente_reglement.datemaj%TYPE
    ,ticketchange     lbm_vente_reglement.ticketchange%TYPE
    ,numfacture       lbm_vente_reglement.numfacture%TYPE
    ,transacoffline   lbm_vente_reglement.transacoffline%TYPE);

  TYPE ttablignereglement IS TABLE OF treclbmventereglement INDEX BY BINARY_INTEGER;

  TYPE treclbmtyperemise IS RECORD(
     remisetype lbm_type_remise.remisetype%TYPE
    ,remiselib  lbm_type_remise.remiselib%TYPE
    ,datemaj    lbm_type_remise.datemaj%TYPE);

  TYPE treclbmactionmarketing IS RECORD(
     actmarkcodetype  lbm_action_marketing.actmarkcodetype%TYPE
    ,actmarklibdutype lbm_action_marketing.actmarklibdutype%TYPE
    ,datemaj          lbm_action_marketing.datemaj%TYPE);

  -- Ajout ERI le 18/12/20103: Gestion des actions marketing par ticket
  TYPE treclbmventeactmkt IS RECORD(
     stecaisse     lbm_vente_act_mkt.stecaisse%TYPE
    ,datehtransac  lbm_vente_act_mkt.datehtransac%TYPE
    ,numcaisse     lbm_vente_act_mkt.numcaisse%TYPE
    ,numticket     lbm_vente_act_mkt.numticket%TYPE
    ,numligamkt    lbm_vente_act_mkt.numligamkt%TYPE
    ,codeactionmkt lbm_vente_act_mkt.codeactionmkt%TYPE
    ,remredttcmkt  lbm_vente_act_mkt.remredttcmkt%TYPE
    ,datemaj       lbm_vente_act_mkt.datemaj%TYPE);

  TYPE ttabligneactmkt IS TABLE OF treclbmventeactmkt INDEX BY BINARY_INTEGER;

  --Fin ajout ERI le 18/12/20103

  --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
  TYPE treclbmventeactmktrep IS RECORD(
     stecaisse     lbm_vente_act_mkt_reponses.stecaisse%TYPE
    ,datehtransac  lbm_vente_act_mkt_reponses.datehtransac%TYPE
    ,numcaisse     lbm_vente_act_mkt_reponses.numcaisse%TYPE
    ,numticket     lbm_vente_act_mkt_reponses.numticket%TYPE
    ,codeactionmkt lbm_vente_act_mkt_reponses.codeactionmkt%TYPE
    ,codequestion  lbm_vente_act_mkt_reponses.codequestion%TYPE
    ,codeclient    lbm_vente_act_mkt_reponses.codeclient%TYPE
    ,codeelement   lbm_vente_act_mkt_reponses.codeelement%TYPE
    ,valeur        lbm_vente_act_mkt_reponses.valeur%TYPE
    ,datemaj       lbm_vente_act_mkt_reponses.datemaj%TYPE);

  TYPE ttabligneactmktrep IS TABLE OF treclbmventeactmktrep INDEX BY BINARY_INTEGER;

  --Fin Ajout ERI le 19/09/2014
  --Ajout ERI le 02/01/2016: Gestion des attributs tickets
  TYPE treclbmventeattributs IS RECORD(
     stecaisse      lbm_vente_attributs.stecaisse%TYPE
    ,datehtrans     lbm_vente_attributs.datehtrans%TYPE
    ,numcaisse      lbm_vente_attributs.numcaisse%TYPE
    ,numticket      lbm_vente_attributs.numticket%TYPE
    ,numattribut    lbm_vente_attributs.numattribut%TYPE
    ,valeurattribut lbm_vente_attributs.valeur%TYPE
    ,datemaj        lbm_vente_attributs.datemaj%TYPE);
  TYPE ttabligneattribut IS TABLE OF treclbmventeattributs INDEX BY BINARY_INTEGER;
  --Fin ajout ERI le 02/01/2016
  PROCEDURE lbm_integrationreferencement;

  PROCEDURE lbm_finintegreferencement;

  PROCEDURE lbm_integrationcommandes; -- BP #27260

  PROCEDURE lbm_extractions;

  PROCEDURE lbm_extractionscommandes; -- BP #27260

  PROCEDURE lbm_integrationclient;
  --AJOUT ERI 11/09/2012: nouevlle procedure d'integration des clients
END pk_lbm;


create PACKAGE BODY PK_LBM IS
  LeCodeTraitementBizTalk        VARCHAR(50);
  LeCodeTraitementBizTalkNegatif VARCHAR(50);

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
  /*  AD 08/04/2009 LeCodeTraitementBizTalk en parametre             */
  /*                Tracker 31480                                    */
  /*                                                                 */
  /*  GD 03/06/2009 #32418 Correction divers (voir fiche)            */
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
    BEGIN
      Tampon := TO_NUMBER(Valeur);
    EXCEPTION
      WHEN others THEN
        RETURN 99999999;
    END;
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
    Resultat NUMBER;
  BEGIN
    BEGIN
      SELECT count(*)
        INTO Resultat
        FROM lbm_vente_entete a
       WHERE a.Numticket = LeNumTicket
         and a.numcaisse = LeNumCaisse
         and a.stecaisse = LaSteCaisse
         and a.datehtrans = LaDateHtTrans
       GROUP BY a.stecaisse
               ,a.numcaisse
               ,a.numticket
               ,a.datehtrans
      HAVING sum(CANETTTC) = (SELECT sum(paiemontdevste)
                                FROM lbm_vente_reglement b
                               WHERE a.datehtrans = b.datehtransac
                                 AND a.numcaisse = b.numcaisse
                                 AND a.stecaisse = b.stecaisse
                                 AND a.numticket = b.numticket) AND sum(CANETTTC) = (SELECT sum(canetligne)
                                                                                       FROM LBM_VENTE_POSTE c
                                                                                      WHERE a.datehtrans = c.datehtrans
                                                                                        AND a.numcaisse = c.numcaisse
                                                                                        AND a.stecaisse = c.stecaisse
                                                                                        AND a.numticket = c.numticket);
      IF Resultat = 1 THEN
        --LE TICKET EXISTE ET EST EQUILIBRE
        COMMIT;
      ELSE
        -- LE TICKET EST DESEQUILIBRE OU N'EXISTE PAS
        ROLLBACK;
        Ajouter_Log(1
                   ,'BIZ-0005'
                   ,'Erreur : ticket incoherent : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1
                   ,'BIZ-0005'
                   ,'Erreur : pendant le controle du ticket : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse || CHR(13) || SQLERRM(SQLCODE));
    END;
  END;

  --
  --   BEGIN
  --     BEGIN
  --       SELECT count(*) INTO Resultat
  --       FROM
  --         (SELECT a.stecaisse, a.numcaisse, a.datehtrans, a.numticket , sum(a.CANETTTC) E,
  --            (SELECT sum(paiemontdevste)
  --             FROM  lbm_vente_reglement b
  --             WHERE a.datehtrans = b.datehtransac
  --             AND    a.numcaisse = b.numcaisse
  --             AND    a.stecaisse = b.stecaisse
  --             AND    a.numticket = b.numticket
  --            ) P,
  --            (SELECT sum(CANETLIGNE)
  --             from  LBM_VENTE_POSTE c
  --             where a.datehtrans = c.datehtrans
  --             AND    a.numcaisse = c.numcaisse
  --             AND    a.stecaisse = c.stecaisse
  --             AND    a.numticket = c.numticket
  --             ) L
  --          FROM lbm_vente_entete a
  --          WHERE a.Numticket    = LeNumTicket
  --          and   a.numcaisse      = LeNumCaisse
  --          and   a.stecaisse      = LaSteCaisse
  --          and   a.datehtrans    = LaDateHtTrans
  --          GROUP BY a.stecaisse, a.numcaisse, a.numticket, a.datehtrans
  --          HAVING
  --          sum(CANETTTC) <>
  --             (
  --             SELECT sum(paiemontdevste)
  --             FROM  lbm_vente_reglement b
  --             WHERE a.datehtrans = b.datehtransac
  --             AND    a.numcaisse = b.numcaisse
  --             AND    a.stecaisse = b.stecaisse
  --             AND    a.numticket = b.numticket
  --             )
  --             OR
  --             (
  --             SELECT sum(paiemontdevste)
  --             FROM  lbm_vente_reglement b
  --             WHERE a.datehtrans = b.datehtransac
  --             AND    a.numcaisse = b.numcaisse
  --             AND    a.stecaisse = b.stecaisse
  --             AND    a.numticket = b.numticket
  --             ) IS NULL
  --             OR
  --             sum(CANETTTC) <>
  --             (
  --             SELECT sum(canetligne)
  --             FROM  LBM_VENTE_POSTE c
  --             WHERE a.datehtrans = c.datehtrans
  --             AND    a.numcaisse = c.numcaisse
  --             AND    a.stecaisse = c.stecaisse
  --             AND    a.numticket = c.numticket
  --             )
  --             OR
  --             (
  --             SELECT sum(canetligne)
  --             FROM  LBM_VENTE_POSTE c
  --             WHERE a.datehtrans = c.datehtrans
  --             AND      a.numcaisse = c.numcaisse
  --             AND    a.stecaisse = c.stecaisse
  --             AND    a.numticket = c.numticket
  --             ) IS NULL
  --         );
  --       IF Resultat <> 0 then
  --       ROLLBACK;
  --        Ajouter_Log(1, 'BIZ-0005', 'Erreur : ticket incoherent : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);
  --       ELSE
  --     COMMIT;
  --       END IF;
  --   EXCEPTION
  --     WHEN OTHERS THEN
  --       ROLLBACK;
  --        Ajouter_Log(1, 'BIZ-0005', 'Erreur : pendant le controle du ticket : ticket ' || LeNumTicket || ', caisse ' || LeNumCaisse);
  --   END;
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

  PROCEDURE Ajouter_Log_LBM(LeTypeFlux         VARCHAR2
                           ,LeIdMessage        VARCHAR2
                           ,LaPhase            NUMBER
                           ,LeMsgErreur        VARCHAR2
                           ,LeIdEnregistrement VARCHAR2) IS
    pragma autonomous_transaction;
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
          Ajouter_Log_LBM('STL_Article'
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
            SELECT NomProduit INTO LeNomProduit FROM INT_PRODUITS WHERE CodeProduit = Ligne.CodeProduit;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                SELECT NomProduit INTO LeNomProduit FROM PRODUITS WHERE codeProduit = Ligne.CodeProduit;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
          Ajouter_Log_LBM('STL_Article'
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
              FROM INT_PRODUITS p
                  ,INT_ARTICLES a
             WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
               AND p.codeProduit = a.CodeProduit;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                SELECT p.NomProduit
                  INTO LeNomProduit
                  FROM PRODUITS p
                      ,ARTICLES a
                 WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
                   AND p.codeProduit = a.CodeProduit;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
          Ajouter_Log_LBM('STL_Article'
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
            -- SELECT p.NomProduit INTO LeNomProduit
            --   FROM INT_PRODUITS p, INT_TARIFS a
            --  WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
            --    AND p.codeProduit = a.CodeProduit;
            NULL;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              BEGIN
                -- SELECT p.NomProduit INTO LeNomProduit
                --   FROM PRODUITS p, TARIFS a
                --  WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
                --    AND p.codeProduit = a.CodeProduit;
                NULL;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  RAISE;
              END;
          END;
          Ajouter_Log_LBM('STL_Article'
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
            FROM INT_PRODUITS p
                ,INT_ARTICLES a
           WHERE a.CodeInterneArticle = Ligne.CodeInterneArticle
             AND a.codeProduit = p.CodeProduit;
        
          Ajouter_Log_LBM('STL_Article'
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
          SELECT NomProduit INTO LeNomProduit FROM INT_PRODUITS WHERE codeProduit = Ligne.CodeProduit;
        
          Ajouter_Log_LBM('STL_Article'
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
          Ajouter_Log_LBM('STL_Hierarchie'
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
          Ajouter_Log_LBM('STL_Hierarchie'
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
          Ajouter_Log_LBM('STL_Hierarchie'
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
          Ajouter_Log_LBM('STL_Hierarchie'
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
      --Ajout ERI le 18/05/2016: Gestion des axes statistiques produits (Mantis 7562)
      DELETE from INT_STATS_PRODUIT_LBM;
      --Fin Ajout ERI le 18/05/2016
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
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0005';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de l''integration des codes postaux par LBM_CP');
    FOR Ligne IN (SELECT * FROM LBM_CP WHERE MessageId = CodeTraitement) LOOP
      UPDATE LBM_CP_HISTO
         SET CPLIB    = Ligne.CPLIB
            ,HCA      = Ligne.HCA
            ,APPL     = Ligne.APPL
            ,TYPEGEST = Ligne.TYPEGEST
            ,DATEMAJ  = Ligne.DATEMAJ
       WHERE CP = Ligne.CP;
      IF SQL%NOTFOUND THEN
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
          WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20001
                                   ,'Erreur lors de l''integration du CP ' || Ligne.CP || CHR(13) || SQLERRM(SQLCODE));
        END;
      END IF;
    END LOOP;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des codes postaux par LBM_CP');
  END;

  /******************************************************************/
  /*  Procedure PRC_LBM_HIERARCHIE                                   */
  /*                                                                 */
  /*  Integration des ClassProd                                      */
  /*    depuis la table LBM_HIERARCHIE                               */
  /*                                                                 */
  /*  PB 06/11/2006 #20104 Creation                                  */
  /*  BFU 29/01/2009 Modifications                                   */
  /*******************************************************************/

  PROCEDURE PRC_LBM_HIERARCHIE IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock         TTabLock;
    ElementAnomalie NUMBER(1);
    NomTable        VARCHAR2(60);
  BEGIN
    LeCodeMsg := 'BIZ-0004';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de l''integration des articles par LBM_HIERARCHIE');
  
    -- On pose un verrou pour eviter les modifications
    NomTable := 'LBM_HIERARCHIE';
    SELECT ElementCode BULK COLLECT
      INTO TabLock
      FROM LBM_HIERARCHIE lh
     INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                  and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       FOR UPDATE;
  
    -- Quelques controles prealables : pas de code element a NULL ou trop de niveaux
    BEGIN
      SELECT 1
        INTO ElementAnomalie
        FROM LBM_HIERARCHIE lh
       INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                    and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       WHERE ElementCode is NULL
         and ROWNUM = 1
      UNION
      SELECT 1
        FROM LBM_HIERARCHIE lh
       INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                    and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       WHERE ElementNIV not between 0 and 3
         and ROWNUM = 1;
      -- S'il n'y a pas d'exception generee, il y a un pb !
      RAISE_APPLICATION_ERROR(-20001
                             ,'Le champ ELEMENTCODE n''est pas renseigne.');
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        NULL;
    END;
  
    --CodeClassProd0
    NomTable := 'INT_CLASSPROD0';
    INSERT INTO INT_CLASSPROD0
      (SELECT lh.ElementCode
             ,lh.ElementLib
             ,NVL(c0.DateCreation
                 ,TRUNC(SYSDATE))
             ,TRUNC(SYSDATE)
             ,NULL
             ,NULL
             ,0
         FROM LBM_HIERARCHIE lh
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         LEFT JOIN CLASSPROD0 c0 ON c0.CodeClassProd0 = lh.ElementCode
        WHERE lh.ElementNiv = 0);
    --CodeClassProd1
    NomTable := 'INT_CLASSPROD1';
    INSERT INTO INT_CLASSPROD1
      (SELECT lh.ElementCode
             ,lh.ElementLib
             ,NVL(c1.DateCreation
                 ,TRUNC(SYSDATE))
             ,TRUNC(SYSDATE)
             ,0
             ,lh.PereCode
             ,0
             ,NULL
             ,0
         FROM LBM_HIERARCHIE lh
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         LEFT JOIN CLASSPROD1 c1 ON c1.CodeClassProd1 = lh.ElementCode
        WHERE lh.ElementNiv = 1);
    --CodeClassProd2
    NomTable := 'INT_CLASSPROD2';
    INSERT INTO INT_CLASSPROD2
      (SELECT lh.ElementCode
             ,lh.PereCode
             ,lh.ElementLib
             ,NVL(c2.DateCreation
                 ,TRUNC(SYSDATE))
             ,TRUNC(SYSDATE)
             ,NULL
         FROM LBM_HIERARCHIE lh
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         LEFT JOIN CLASSPROD2 c2 ON c2.CodeClassProd2 = lh.ElementCode
        WHERE lh.ElementNiv = 2);
    --CodeClassProd3
    NomTable := 'INT_CLASSPROD3';
    INSERT INTO INT_CLASSPROD3
      (SELECT lh.ElementCode
             ,lh.PereCode
             ,lh.ElementLib
             ,NVL(c3.DateCreation
                 ,TRUNC(SYSDATE))
             ,TRUNC(SYSDATE)
             ,2 NbDimProduit
             ,1 GestionEnStock
             ,1 CodeTypeProduit
             ,0
             ,0
             ,0
             ,0
             ,1 CodeTypeReassort
             ,1 CodeTypeStockage
             ,0
             ,0
             ,0
             ,0
             ,1 CodeTypeEtiquette
             ,1 GestionParUniteGestion
             ,'0'
             ,'0'
             ,'0'
             ,0
             ,0
             ,NULL
             ,NULL
             ,NULL
         FROM LBM_HIERARCHIE lh
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lh.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         LEFT JOIN CLASSPROD3 c3 ON c3.CodeClassProd3 = lh.ElementCode
        WHERE lh.ElementNiv = 3);
    --LBM_CP_HISTO
    NomTable := 'LBM_CP_HISTO';
    -- Les mises a jour
    UPDATE LBM_CP_HISTO lh
       SET (CPLIB, HCA, APPL, TYPEGEST, DATEMAJ) = (select lc.CPLIB
                                                          ,lc.HCA
                                                          ,lc.APPL
                                                          ,lc.TYPEGEST
                                                          ,lc.DATEMAJ
                                                      FROM LBM_CP lc
                                                     INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lc.MessageId
                                                                                  and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
                                                     where lc.CP = lh.CP)
     WHERE Exists (select lc.CPLIB
                  ,lc.HCA
                  ,lc.APPL
                  ,lc.TYPEGEST
                  ,lc.DATEMAJ
              FROM LBM_CP lc
             INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lc.MessageId
                                          and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
             where lc.CP = lh.CP);
    -- Les ajouts
    INSERT INTO LBM_CP_HISTO
      (CP
      ,CPLIB
      ,HCA
      ,APPL
      ,TYPEGEST
      ,DATEMAJ)
      (SELECT lc.CP
             ,lc.CPLIB
             ,lc.HCA
             ,lc.APPL
             ,lc.TYPEGEST
             ,lc.DATEMAJ
         FROM LBM_CP lc
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lc.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         LEFT JOIN LBM_CP_HISTO lh on lh.CP = lc.CP
        WHERE lh.CP is NULL);
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des articles par LBM_HIERARCHIE');
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001
                             ,'Erreur lors de l''integration de la hierarchie : table ' || NomTable || CHR(13) || SQLERRM(SQLCODE));
  END;

  /*******************************************************************/
  /*  Procedure LBM_STATUTS                                          */
  /*                                                                 */
  /*  Integratrion des statuts de commandes client                   */
  /*                                                                 */
  /*  BP 28/10/2008 #27260 Creation                                  */
  /*  BF 17/04/2009 #32418 Corrections (Verrouillage et limiter la   */
  /*                maj aux nouveaux statuts envoyes). Mail de BFU   */
  /*                a POL le 24/4/2009 a 18h21.                      */
  /* JJD 23/12/2009 #35899 Gestion des transactions. Point 4 de L'AF */
  /*                                                                 */
  /*******************************************************************/
  PROCEDURE PRC_LBM_STATUTS IS
    -- Definition des Constantes
    NoRubriqueCdeLockee CONSTANT NUMBER := 100;
    LockLBM_STATUS      CONSTANT NUMBER := 999;
    NoStatut1           CONSTANT NUMBER := 3;
    NoStatut2           CONSTANT NUMBER := 10;
    LeCodeMsg           LOG_TRAITEMENTS.CodeMsg%TYPE;
    bContinue           BOOLEAN;
    LaRubriqueCdeLockee NUMBER;
  
  BEGIN
    LeCodeMsg := 'BIZ-0013';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement des statuts de commandes clients par LBM_STATUTS');
    BEGIN
      BEGIN
        UPDATE LBM_COMMANDE_RETOUR_STATUT
           SET TOPSTOR      = 2
              ,DATEHTOPSTOR = SYSDATE
         WHERE TOPSTOR = 0;
      
        FOR LigneTete IN (SELECT DISTINCT NUMCDECLI FROM LBM_COMMANDE_RETOUR_STATUT WHERE TOPSTOR = 2) LOOP
          BEGIN
            LaRubriqueCdeLockee := 1;
            INSERT INTO RESAZONEVAL_WST
              (NUMRESERVATION
              ,CODEPROFIL
              ,CODEELEMENT
              ,VALEURELEMENT)
            VALUES
              (LigneTete.NUMCDECLI
              ,NoRubriqueCdeLockee
              ,0
              ,LockLBM_STATUS);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              LaRubriqueCdeLockee := 0;
            WHEN OTHERS THEN
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Une erreur s''est produite lors de la generation des commandes clients. RubriqueCdeLockee Valeur non Entiere sur Reservation ' || LigneTete.NUMCDECLI || CHR(13) || SQLERRM(SQLCODE));
              Ajouter_Log_LBM('LBM_COMMANDES'
                             ,LeCodeTraitementBizTalk
                             ,1
                             ,'RubriqueCdeLockee Valeur non Entiere sur Reservation ' || LigneTete.NUMCDECLI || CHR(13) || SQLERRM(SQLCODE)
                             ,'');
          END;
        
          IF LaRubriqueCdeLockee = 0 THEN
            UPDATE LBM_COMMANDE_RETOUR_STATUT
               SET TOPSTOR      = 0
                  ,DATEHTOPSTOR = NULL
             WHERE TOPSTOR = 2
               AND NUMCDECLI = LigneTete.NUMCDECLI;
            -- Sinon on met a jour les statuts, on supprime le verrou puis on met a jour le top
          ELSE
            -- On commit le lock tant que Winstore ne pose pas un lock avant de prendre la commande en modification
            COMMIT;
            -- Maj statuts
            BEGIN
              FOR Ligne IN (SELECT DISTINCT NUMPOSTE
                                           ,STATUT
                                           ,DATEMAJ
                              FROM LBM_COMMANDE_RETOUR_STATUT
                             WHERE NUMCDECLI = LigneTete.NUMCDECLI
                               AND TOPSTOR = 2 -- BF Ajout clause TOPSTOR
                             ORDER BY DATEMAJ) LOOP
                IF Ligne.Statut = 1 THEN
                  UPDATE RESERVATIONS_WST
                     SET STATUT           = NoStatut1
                        ,DATEMODIFICATION = sysdate
                   WHERE NUMRESERVATION = LigneTete.NUMCDECLI
                     AND NUMLIGNE = Ligne.NUMPOSTE
                     AND STATUT < NoStatut1;
                ELSIF Ligne.Statut = 2 THEN
                  UPDATE RESERVATIONS_WST
                     SET STATUT           = NoStatut2
                        ,DATEMODIFICATION = sysdate
                   WHERE NUMRESERVATION = LigneTete.NUMCDECLI
                     AND NUMLIGNE = Ligne.NUMPOSTE
                     AND STATUT < NoStatut2;
                END IF;
              END LOOP;
              -- Maj du top pour signaler la fin de traitement
              UPDATE LBM_COMMANDE_RETOUR_STATUT
                 SET TOPSTOR      = 1
                    ,DATEHTOPSTOR = sysdate
               WHERE TOPSTOR = 2
                 AND NUMCDECLI = LigneTete.NUMCDECLI;
            EXCEPTION
              WHEN OTHERS THEN
                ROLLBACK;
            END;
            -- Suppression du verrou
            DELETE FROM RESAZONEVAL_WST
             WHERE NUMRESERVATION = LigneTete.NUMCDECLI
               and CODEPROFIL = NoRubriqueCdeLockee
               and VALEURELEMENT = LockLBM_STATUS;
            COMMIT;
          END IF;
        END LOOP;
      END;
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de la generation des statuts de commandes clients.' || CHR(13) || SQLERRM(SQLCODE));
        Ajouter_Log_LBM('LBM_STATUTS'
                       ,LeCodeTraitementBizTalk
                       ,1
                       ,SQLERRM(SQLCODE)
                       ,'');
    END;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la generation des statuts de commandes clients par LBM_STATUTS');
  END;

  /*******************************************************************/
  /*  Procedure LBM_COMMANDES                                        */
  /*                                                                 */
  /*  Integratrion des portefeuilles de RESERVATIONS                 */
  /*                                                                 */
  /*  BP 28/10/2008 #27260 Creation                                  */
  /*  JB 01/04/2009 #31100 Alimentation de TopGU                     */
  /*  AD 06/04/2009 #31045 Identification TVA                        */
  /*  AD 06/04/2009 #31057 CodeMagasin sur 4 caracteres              */
  /*  GD  03/06/2009 #32418 Correctifs divers                        */
  /*  BF 21/04/2009 #32418 Mail de BFU a POL le 24/4/2009 a 18h21    */
  /*  FT 12/05/2009 #32418 Mail de FTR a POL le 13/5/2009 a 17h08    */
  /* JJD 29/10/2009 #35737 le commit global n'inclue pas les frais   */
  /*                       de port                                   */
  /* JJD 30/10/2009 #35725 Commandes non transferees                 */
  /* JJD 22/12/2009 #35899 Blocage Tranfert des reservations bloquees*/
  /*                                                                 */
  /*******************************************************************/
  PROCEDURE PRC_LBM_COMMANDES IS
    -- Definition des Constantes
    NoRubrique_Magasin         CONSTANT NUMBER := 1002;
    NoRubrique_InfoVendeur     CONSTANT NUMBER := 1001;
    NoRubrique_PortArticle     CONSTANT NUMBER := 1004;
    NoRubrique_PortMontant     CONSTANT NUMBER := 1005;
    NoRubrique_CdeMeuble       CONSTANT NUMBER := 1003;
    NoRubrique_ReducGeste      CONSTANT NUMBER := 1006;
    NoRubrique_TypeEnlevement  CONSTANT NUMBER := 1007;
    NoRubrique_CondiLivr1      CONSTANT NUMBER := 1008;
    NoRubrique_CondiLivr2      CONSTANT NUMBER := 1009;
    NoRubrique_CondiLivr3      CONSTANT NUMBER := 1010;
    NoRubrique_Escompte        CONSTANT NUMBER := 1011;
    NoRubrique_DateModifStatut CONSTANT NUMBER := 1012;
    NoRubrique_Lock            CONSTANT NUMBER := 100;
    --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
    NoRubrique_DateConfirm CONSTANT NUMBER := 1017;
    --Fin ajout FTR le 15/11/2010
    LeCodeMsg               LOG_TRAITEMENTS.CodeMsg%TYPE;
    LeTOPCA                 LBM_COMMANDE_ENTETE.TOPCA%TYPE;
    LeTOPLM                 LBM_COMMANDE_ENTETE.TOPLM%TYPE;
    LeTOPGU                 LBM_COMMANDE_POSTE.TOPGU%TYPE;
    LeSTATUT                LBM_COMMANDE_POSTE.STATUT%TYPE;
    LeEscMont               LBM_COMMANDE_POSTE.ESCMONT%TYPE;
    LeMagasin               RESAZONEVAL_WST.VALEURELEMENT%TYPE; --VARCHAR2(40);
    LeInfoVendeur           RESAZONEVAL_WST.VALEURELEMENT%TYPE; --VARCHAR2(40);
    LeCondiLivr1            RESAZONEVAL_WST.VALEURELEMENT%TYPE; --VARCHAR2(40);
    LeCondiLivr2            RESAZONEVAL_WST.VALEURELEMENT%TYPE; --VARCHAR2(40);
    LeCondiLivr3            RESAZONEVAL_WST.VALEURELEMENT%TYPE; --VARCHAR2(40);
    LeOldNumReservation     RESERVATIONS_WST.NumReservation%TYPE;
    LeDepartement           CLASSPROD2.CODECLASSPROD1%TYPE;
    LeGereEnStock           ARTICLES.GEREENSTOCK%TYPE;
    LeCodeEtat              ARTICLES.CODEETAT%TYPE;
    LeCodeNature            ARTICLES.CODENATURE%TYPE;
    LeCP                    PRODUITS.CODECLASSPROD3%TYPE;
    LeNomProduit            PRODUITS.NOMPRODUIT%TYPE;
    LeCODEUNITEGESTIONVENTE PRODUITS.CODEUNITEGESTIONVENTE%TYPE;
    LeHCA                   LBM_CP_HISTO.HCA%TYPE;
    LeAPPL                  LBM_CP_HISTO.APPL%TYPE;
    LeTYPEGEST              LBM_CP_HISTO.TYPEGEST%TYPE;
    LeTVATaux               TVA_Pays.TAUXTVA%TYPE;
    LeCodeMagasinEmetteur   HISTO_OSCC.CODEMAGASINEMETTEUR%TYPE;
    LeEANSaisieFdP          HISTO_CB_FRN.CODEBARRES%TYPE;
    LeNumPoste              NUMBER;
    LePortArticle           NUMBER(8);
    LePortMontant           NUMBER(10
                                  ,2);
    LeCdeMeuble             NUMBER(1);
    --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
    LeDateConfirm VARCHAR2(4);
    --Fin ajout FTR le 15/11/2010
    LeReducGeste NUMBER(10
                       ,2);
    --GD
    -- AJout BF  pour ventilation ReducGeste et gestion de la meilleure remise
    ReducGesteIntermediaire NUMBER(10
                                  ,2);
    LeReducGesteLigne       NUMBER(10
                                  ,2);
    CodeRemiseComplementaire CONSTANT NUMBER := 55;
    CodeRemiseEscompte       CONSTANT NUMBER := 99;
    NoDpt_LBM                CONSTANT NUMBER := 14;
    --fin GD
    LeTypeEnlevement             NUMBER(4);
    LeEscompte                   NUMBER(10
                                       ,2);
    EscompteNbLigne              NUMBER(8);
    EscompteMtTotal              NUMBER(10
                                       ,2);
    EscompteMtIntermediaire      NUMBER(10
                                       ,2);
    EscompteNbLigneIntermediaire NUMBER(8);
    EscompteCATicketTotal        NUMBER(10
                                       ,2);
    LeTauxEscompte               NUMBER(10
                                       ,2);
    LeTypeArt                    NUMBER(3);
    LeStatutEnTete               NUMBER;
    LaDateOSCC                   DATE;
    LaDateModifStatus            DATE;
    bTrouve                      BOOLEAN;
    bTraiteLigne                 BOOLEAN;
    fLock                        ResaZoneVal_WST.ValeurElement%Type;
    fCommandeATransferer         BOOLEAN;
  
    PROCEDURE Maj_LBM_COMMANDE_ENTETE(LeSTECAISSE     VARCHAR2
                                     ,LaDATEHTRANS    DATE
                                     ,LeNUMCAISSE     NUMBER
                                     ,LeCODEVENDEUR   NUMBER
                                     ,LeNUMCDECLI     VARCHAR2
                                     ,LeNUMCLT        VARCHAR2
                                     ,LeDPTCDE        VARCHAR2
                                     ,LeMAGASIN       VARCHAR2
                                     ,LeSTATUT        NUMBER
                                     ,LaDATELIVR      DATE
                                     ,LeTYPENLEVEMENT NUMBER
                                     ,LeINFOVENDEUR   VARCHAR2
                                     ,LePORTMONTANT   NUMBER
                                     ,LeCDEMEUBLE     NUMBER
                                     ,LaREDUCGESTE    NUMBER
                                     ,LeEXPORT        VARCHAR2
                                     ,LaREMARQUES     VARCHAR2
                                     ,LeNOMCLT        VARCHAR2
                                     ,LePRENOMCLT     VARCHAR2
                                     ,LaCONDILIVR     VARCHAR2
                                     ,LaADRESSLIVR    VARCHAR2
                                     ,LeCODEPOSTLIVR  VARCHAR2
                                     ,LaVILLELIVR     VARCHAR2
                                     ,LePAYSLIVR      VARCHAR2
                                     ,LaADRESSFACT    VARCHAR2
                                     ,LeCODEPOSFACT   VARCHAR2
                                     ,LaVILLEFACT     VARCHAR2
                                     ,LePAYSFACT      VARCHAR2
                                     ,LaDATEMAJCDE    DATE
                                     ,LeTOPCA         NUMBER
                                     ,LaDATEHTOPCA    DATE
                                     ,
                                      --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
                                      --LaDATEMODIFSTATUT DATE, LeTOPLM NUMBER, LaDATEHTOPLM DATE) IS
                                      LaDATEMODIFSTATUT DATE
                                     ,LeTOPLM           NUMBER
                                     ,LaDATEHTOPLM      DATE
                                     ,LeDATECONFIRM     VARCHAR2) IS
      --Fin ajout FTR le 15/11/2010
      --GD
      --Ajout BF : Liste de mariage
      LaValStatut             NUMBER;
      LaValTOPLM              NUMBER;
      LaValDateHTopLM         DATE;
      LaValTOPLMAncienne      NUMBER;
      LaValDateHTopLMAncienne DATE;
      --fin GD
    BEGIN
      BEGIN
        SELECT STATUT
              ,TOPLM
              ,DATEHTOPLM
          INTO LaValStatut
              ,LaValTOPLMAncienne
              ,LaValDateHTopLMAncienne
          FROM LBM_COMMANDE_ENTETE
         WHERE NUMCDECLI = LeNUMCDECLI;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LaValStatut := -9999;
      END;
      BEGIN
        IF LaValStatut = -9999 THEN
          --FTR01 le 21/12/2009 Gestion du TOPLM a l'insertion
          BEGIN
            IF LeDPTCDE = NoDpt_LBM THEN
              LaValTOPLM := 0;
            ELSE
              LaValTOPLM := NULL;
            END IF;
            --Fin FTR01
          
            INSERT INTO LBM_COMMANDE_ENTETE
              (STECAISSE
              ,DATEHTRANS
              ,NUMCAISSE
              ,CODEVENDEUR
              ,NUMCDECLI
              ,NUMCLT
              ,DPTCDE
              ,MAGASIN
              ,STATUT
              ,DATELIVR
              ,TYPENLEVEMENT
              ,INFOVENDEUR
              ,PORTMONTANT
              ,CDEMEUBLE
              ,REDUCGESTE
              ,EXPORT
              ,REMARQUES
              ,NOMCLT
              ,PRENOMCLT
              ,CONDILIVR
              ,ADRESSLIVR
              ,CODEPOSTLIVR
              ,VILLELIVR
              ,PAYSLIVR
              ,ADRESSFACT
              ,
               --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
               --CODEPOSFACT, VILLEFACT, PAYSFACT, DATEMAJCDE, TOPCA, DATEHTOPCA, DATEMODIFSTATUT, TOPLM, DATEHTOPLM)
               CODEPOSFACT
              ,VILLEFACT
              ,PAYSFACT
              ,DATEMAJCDE
              ,TOPCA
              ,DATEHTOPCA
              ,DATEMODIFSTATUT
              ,TOPLM
              ,DATEHTOPLM
              ,DATELIVRECONFIRM)
            --Fin ajout FTR le 15/11/2010
            VALUES
              (LeSTECAISSE
              ,LaDATEHTRANS
              ,LeNUMCAISSE
              ,LeCODEVENDEUR
              ,LeNUMCDECLI
              ,LeNUMCLT
              ,LeDPTCDE
              ,LPAD(LeMAGASIN
                   ,4
                   ,'0')
              ,LeSTATUT
              ,LaDATELIVR
              ,LeTYPENLEVEMENT
              ,LeINFOVENDEUR
              ,LePORTMONTANT
              ,LeCDEMEUBLE
              ,LaREDUCGESTE
              ,LeEXPORT
              ,LaREMARQUES
              ,LeNOMCLT
              ,LePRENOMCLT
              ,LaCONDILIVR
              ,LaADRESSLIVR
              ,LeCODEPOSTLIVR
              ,LaVILLELIVR
              ,LePAYSLIVR
              ,LaADRESSFACT
              ,
               --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
               --LeCODEPOSFACT, LaVILLEFACT, LePAYSFACT, LaDATEMAJCDE, LeTOPCA, LaDATEHTOPCA, LaDATEMODIFSTATUT, LaValTOPLM, LaDATEHTOPLM);
               LeCODEPOSFACT
              ,LaVILLEFACT
              ,LePAYSFACT
              ,LaDATEMAJCDE
              ,LeTOPCA
              ,LaDATEHTOPCA
              ,LaDATEMODIFSTATUT
              ,LaValTOPLM
              ,LaDATEHTOPLM
              ,LeDATECONFIRM);
            --Fin ajout FTR le 15/11/2010
          END;
        ELSE
          IF LaValStatut <> LeSTATUT THEN
            IF LeDPTCDE = NoDpt_LBM THEN
              LaValTOPLM := 0;
            ELSE
              LaValTOPLM := NULL;
            END IF;
            LaValDateHTopLM := NULL;
          ELSE
            LaValTOPLM      := LaValTOPLMAncienne;
            LaValDateHTopLM := LaValDateHTopLMAncienne;
          END IF;
          UPDATE LBM_COMMANDE_ENTETE
             SET STECAISSE     = LeSTECAISSE
                ,DATEHTRANS    = LaDATEHTRANS
                ,NUMCAISSE     = LeNUMCAISSE
                ,CODEVENDEUR   = LeCODEVENDEUR
                ,NUMCLT        = LeNUMCLT
                ,DPTCDE        = LeDPTCDE
                ,MAGASIN       = LPAD(LeMAGASIN
                                     ,4
                                     ,'0')
                ,STATUT        = LeSTATUT
                ,DATELIVR      = LaDATELIVR
                ,TYPENLEVEMENT = LeTYPENLEVEMENT
                ,INFOVENDEUR   = LeINFOVENDEUR
                ,PORTMONTANT   = LePORTMONTANT
                ,CDEMEUBLE     = LeCDEMEUBLE
                ,REDUCGESTE    = LaREDUCGESTE
                ,EXPORT        = LeEXPORT
                ,REMARQUES     = LaREMARQUES
                ,NOMCLT        = LeNOMCLT
                ,PRENOMCLT     = LePRENOMCLT
                ,CONDILIVR     = LaCONDILIVR
                ,ADRESSLIVR    = LaADRESSLIVR
                ,CODEPOSTLIVR  = LeCODEPOSTLIVR
                ,VILLELIVR     = LaVILLELIVR
                ,PAYSLIVR      = LePAYSLIVR
                ,ADRESSFACT    = LaADRESSFACT
                ,CODEPOSFACT   = LeCODEPOSFACT
                ,VILLEFACT     = LaVILLEFACT
                ,PAYSFACT      = LePAYSFACT
                ,DATEMAJCDE    = LaDATEMAJCDE
                ,
                 --FTR02 le 22/12/2009 utilisation des variables initialisees + haut
                 --TOPCA = 0, DATEHTOPCA = LaDATEHTOPCA, DATEMODIFSTATUT = LaDATEMODIFSTATUT, TOPLM = LeTOPLM, DATEHTOPLM = LaDATEHTOPLM
                 TOPCA           = 0
                ,DATEHTOPCA      = LaDATEHTOPCA
                ,DATEMODIFSTATUT = LaDATEMODIFSTATUT
                ,TOPLM           = LaValTOPLM
                ,DATEHTOPLM      = LaValDateHTopLM
                 --Fin FTR02
                 --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
                ,DATELIVRECONFIRM = LeDATECONFIRM
          --Fin ajout FTR le 15/11/2010
           WHERE NUMCDECLI = LeNUMCDECLI;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement PRC_LBM_COMMANDES, INSERT INTO LBM_COMMANDE_ENTETE, numero reservation ' || LeNUMCDECLI || CHR(13) || SQLERRM(SQLCODE));
      END;
    END;
  
    PROCEDURE Maj_LBM_COMMANDE_POSTE(LeSTECAISSE   VARCHAR2
                                    ,LaDATEHTRANS  DATE
                                    ,LeNUMCDECLI   VARCHAR2
                                    ,lNUMPOSTE     NUMBER
                                    ,LeCDEACHAT    VARCHAR2
                                    ,LeDEPARTEMENT VARCHAR2
                                    ,LeCP          VARCHAR2
                                    ,LeTYPEART     VARCHAR2
                                    ,LeEANSAISIE   VARCHAR2
                                    ,LeNUMART      VARCHAR2
                                    ,LaQTE         NUMBER
                                    ,LaUNITEVENTE  VARCHAR2
                                    ,LePRIXTTCART  NUMBER
                                    ,LeCANETLIGNE  NUMBER
                                    ,LeAPPL        VARCHAR2
                                    ,LeTYPEGEST    VARCHAR2
                                    ,LeTOTREMRED   NUMBER
                                    ,LeTVATAUX     NUMBER
                                    ,LeESCMONT     NUMBER
                                    ,LaREDUCTYPE   NUMBER
                                    ,LaREMISETYPE  NUMBER
                                    ,LeHCA         VARCHAR2
                                    ,LeEXPMONT     NUMBER
                                    ,LePR          VARCHAR2
                                    ,LeAGPRIX      NUMBER
                                    ,LeAGTEXT      VARCHAR2
                                    ,LeSTATUT      NUMBER
                                    ,LaDATEMAJ     DATE) IS
      LaValStatut             NUMBER;
      LaValTOPGU              NUMBER;
      LaValDateHTopGU         DATE;
      LaValTOPGUAncienne      NUMBER;
      LaValDateHTopGUAncienne DATE;
    BEGIN
      BEGIN
        SELECT STATUT
              ,TOPGU
              ,DATEHTOPGU
          INTO LaValStatut
              ,LaValTOPGUAncienne
              ,LaValDateHTopGUAncienne
          FROM LBM_COMMANDE_POSTE
         WHERE NUMCDECLI = LeNUMCDECLI
           AND NUMPOSTE = lNUMPOSTE;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LaValStatut := -9999;
      END;
      BEGIN
        IF LaValStatut = -9999 THEN
        
          INSERT INTO LBM_COMMANDE_POSTE
            (STECAISSE
            ,DATEHTRANS
            ,NUMCDECLI
            ,NUMPOSTE
            ,CDEACHAT
            ,DEPARTEMENT
            ,CP
            ,TYPEART
            ,EANSAISIE
            ,NUMART
            ,QTE
            ,UNITEVENTE
            ,PRIXTTCART
            ,CANETLIGNE
            ,APPL
            ,TYPEGEST
            ,TOTREMRED
            ,TVATAUX
            ,ESCMONT
            ,REMISETYPE
            ,HCA
            ,EXPMONT
            ,PR
            ,AGPRIX
            ,AGTEXT
            ,STATUT
            ,DATEMAJ
            ,TOPGU
            ,DATEHTOPGU
            ,REDUCTYPE)
          VALUES
            (LeSTECAISSE
            ,LaDATEHTRANS
            ,LeNUMCDECLI
            ,lNUMPOSTE
            ,LeCDEACHAT
            ,LeDEPARTEMENT
            ,LeCP
            ,LeTYPEART
            ,LeEANSAISIE
            ,LeNUMART
            ,LaQTE
            ,LaUNITEVENTE
            ,LePRIXTTCART
            ,LeCANETLIGNE
            ,LeAPPL
            ,LeTYPEGEST
            ,LeTOTREMRED
            ,LeTVATAUX
            ,LeESCMONT
            ,LaREMISETYPE
            ,LeHCA
            ,LeEXPMONT
            ,LePR
            ,LeAGPRIX
            ,LeAGTEXT
            ,LeSTATUT
            ,LaDATEMAJ
            ,0
            ,NULL
            ,LaREDUCTYPE);
        ELSE
          IF LaValStatut <> LeSTATUT THEN
            LaValTOPGU      := 0;
            LaValDateHTopGU := NULL;
          ELSE
            LaValTOPGU      := LaValTOPGUAncienne;
            LaValDateHTopGU := LaValDateHTopGUAncienne;
          END IF;
        
          UPDATE LBM_COMMANDE_POSTE
             SET STECAISSE   = LeSTECAISSE
                ,DATEHTRANS  = LaDATEHTRANS
                ,CDEACHAT    = LeCDEACHAT
                ,DEPARTEMENT = LeDEPARTEMENT
                ,CP          = LeCP
                ,TYPEART     = LeTYPEART
                ,EANSAISIE   = LeEANSAISIE
                ,NUMART      = LeNUMART
                ,QTE         = LaQTE
                ,UNITEVENTE  = LaUNITEVENTE
                ,PRIXTTCART  = LePRIXTTCART
                ,CANETLIGNE  = LeCANETLIGNE
                ,APPL        = LeAPPL
                ,TYPEGEST    = LeTYPEGEST
                ,TOTREMRED   = LeTOTREMRED
                ,TVATAUX     = LeTVATAUX
                ,ESCMONT     = LeESCMONT
                ,REMISETYPE  = LaREMISETYPE
                ,HCA         = LeHCA
                ,EXPMONT     = LeEXPMONT
                ,PR          = LePR
                ,AGPRIX      = LeAGPRIX
                ,AGTEXT      = LeAGTEXT
                ,STATUT      = LeSTATUT
                ,DATEMAJ     = LaDATEMAJ
                ,TOPGU       = LaValTOPGU
                ,DATEHTOPGU  = LaValDateHTopGU
                ,REDUCTYPE   = LaREDUCTYPE
           WHERE NUMCDECLI = LeNUMCDECLI
             AND NUMPOSTE = lNUMPOSTE;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement PRC_LBM_COMMANDES, INSERT INTO LBM_COMMANDE_POSTE, numero reservation ' || LeNUMCDECLI || CHR(13) || SQLERRM(SQLCODE));
      END;
    END;
  
    PROCEDURE AlimenteParametre(LeCIA NUMBER) IS
    BEGIN
      BEGIN
        SELECT cp2.codeclassprod1
              ,p.codeclassprod3
              ,art.GEREENSTOCK
              ,art.CODEETAT
              ,p.NomProduit
              ,p.CODEUNITEGESTIONVENTE
              ,NVL(CODENATURE
                  ,0) CODENATURE
          INTO LeDepartement
              ,LeCP
              ,LeGereEnStock
              ,LeCodeEtat
              ,LeNomProduit
              ,LeCODEUNITEGESTIONVENTE
              ,LeCodeNature
          FROM produits   p
              ,classprod2 cp2
              ,classprod3 cp3
              ,articles   art
         WHERE art.CODEINTERNEARTICLE = LeCIA
           AND p.codeproduit = art.CODEPRODUIT
           AND cp3.codeclassprod3 = p.codeclassprod3
           AND cp2.codeclassprod2 = cp3.codeclassprod2;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement PRC_LBM_COMMANDES, recherche du Centre de profit / departement, reservation ' || LeOldNumReservation || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      BEGIN
        SELECT HCA
              ,APPL
              ,TYPEGEST
          INTO LeHCA
              ,LeAPPL
              ,LeTYPEGEST
          FROM LBM_CP_HISTO
         WHERE CP = LeCP;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement PRC_LBM_COMMANDES, recherche du HCA, APPL et TYPEGEST, reservation ' || LeOldNumReservation || CHR(13) || SQLERRM(SQLCODE));
      END;
      -- TVA
      BEGIN
        SELECT DISTINCT NVL(tp.TauxTVA
                           ,0)
          INTO LeTVATaux
          FROM TVA_Pays         tp
              ,TVA_Produit_Pays tpp
              ,ARTICLES         art
         WHERE tp.CodePays = tpp.CodePays
           AND tp.CodeTVA = tpp.CodeTVA
           AND tpp.CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS')
           AND tpp.CodeProduit = art.CodeProduit
           AND art.CODEINTERNEARTICLE = LeCIA
           AND ROWNUM = 1;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement change, recherche du taux de TVA, reservation ' || LeOldNumReservation || CHR(13) || SQLERRM(SQLCODE));
      END;
    END;
  
    FUNCTION RetourneNumPoste(LeNumReservation NUMBER) RETURN NUMBER IS
      LeNumPoste NUMBER;
    BEGIN
      BEGIN
        SELECT NUMPOSTE
          INTO LeNumPoste
          FROM LBM_COMMANDE_POSTE
         WHERE NUMCDECLI = LeNumReservation
           AND TYPEART = 98;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LeNumPoste := 0;
      END;
      IF LeNumPoste = 0 THEN
        SELECT NVL(MAX(NUMPOSTE)
                  ,0)
          INTO LeNumPoste
          FROM LBM_COMMANDE_POSTE
         WHERE NUMCDECLI = LeOldNumReservation;
        LeNumPoste := LeNumPoste + 1;
      END IF;
      RETURN LeNumPoste;
    END;
  
    -- Ajout BF : recuperation des commentaires du poste de la commande
    FUNCTION RetourneCommPoste(LeNumReservation NUMBER
                              ,LeNumPoste       NUMBER) RETURN VARCHAR2 IS
      LeCommentairePoste VARCHAR2(800);
      NumLigneIdent      NUMBER(4);
    BEGIN
      LeCommentairePoste := '';
      FOR LigneCom IN (SELECT Commentaire
                         FROM COMMENTAIRE_WST
                        WHERE TypeIdent = 1
                          AND CodeIdent = LeNumReservation
                          AND NumLigIdent = LeNumPoste
                        ORDER BY NumLigComm) LOOP
        LeCommentairePoste := LeCommentairePoste || LigneCom.Commentaire || CHR(13) || CHR(10);
      END LOOP;
      RETURN LeCommentairePoste;
    END;
  
    FUNCTION ControleCommandeValide(LeNumReservation NUMBER) RETURN BOOLEAN IS
      NbCmd        NUMBER;
      NbLigCmd     NUMBER;
      NbLigAttendu NUMBER;
    BEGIN
      BEGIN
        SELECT 1 INTO NbCmd FROM Lbm_Commande_Entete WHERE NumCdeCli = LeNumReservation;
      EXCEPTION
        WHEN OTHERS THEN
          NbCmd := 0;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Commande non valide [CTRL 1] n? ' || LeNumReservation);
          Ajouter_Log_LBM('LBM_COMMANDES'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,'Commande non valide [CTRL 1] n? ' || LeNumReservation
                         ,'');
      END;
    
      BEGIN
        SELECT SUM(Nb)
          INTO NbLigAttendu
          FROM (SELECT COUNT(*) Nb
                  FROM Reservations_Wst
                 WHERE NumReservation = LeNumReservation
                UNION ALL
                SELECT 1 Nb
                  FROM ResaZoneVal_Wst
                 WHERE NumReservation = LeNumReservation
                      -- AJOUT BF 21/12/2009 : on ne tient pas compte de la zone si le code article frais de port est a 0
                   AND CodeElement <> 0
                   AND CodeProfil = NoRubrique_PortArticle);
      EXCEPTION
        WHEN OTHERS THEN
          NbLigAttendu := 0;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Commande non valide [CTRL 2] n? ' || LeNumReservation);
          Ajouter_Log_LBM('LBM_COMMANDES'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,'Commande non valide [CTRL 2] n? ' || LeNumReservation
                         ,'');
      END;
    
      BEGIN
        SELECT COUNT(*) INTO NbLigCmd FROM Lbm_Commande_Poste WHERE NumCdeCli = LeNumReservation;
      EXCEPTION
        WHEN OTHERS THEN
          NbLigCmd := 0;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Commande non valide [CTRL 3] n? ' || LeNumReservation);
          Ajouter_Log_LBM('LBM_COMMANDES'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,'Commande non valide [CTRL 3] n? ' || LeNumReservation
                         ,'');
      END;
    
      IF NbCmd <> 1 THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbCmd = ' || to_char(NbCmd));
        Ajouter_Log_LBM('LBM_COMMANDES'
                       ,LeCodeTraitementBizTalk
                       ,1
                       ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbCmd = ' || to_char(NbCmd)
                       ,'');
      END IF;
    
      IF NbLigAttendu = 0 THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbLigAttendu = ' || to_char(NbLigAttendu));
        Ajouter_Log_LBM('LBM_COMMANDES'
                       ,LeCodeTraitementBizTalk
                       ,1
                       ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbLigAttendu = ' || to_char(NbLigAttendu)
                       ,'');
      END IF;
    
      IF NbLigCmd <> NbLigAttendu THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbLigAttendu <> NbLigCmd : NbLigAttendu = ' || to_char(NbLigAttendu) || ' NbLigCmd = ' || to_char(NbLigCmd));
        Ajouter_Log_LBM('LBM_COMMANDES'
                       ,LeCodeTraitementBizTalk
                       ,1
                       ,'Commande non valide ' || LeNumReservation || ' Erreur ctrl cmd sur NbLigAttendu <> NbLigCmd : NbLigAttendu = ' || to_char(NbLigAttendu) || ' NbLigCmd = ' || to_char(NbLigCmd)
                       ,'');
      END IF;
    
      RETURN(NbCmd = 1) AND(NbLigAttendu > 0) AND(NbLigCmd = NbLigAttendu);
    END;
  
  BEGIN
    LeCodeMsg := 'BIZ-0012';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de la generation des commandes client par LBM_COMMANDES');
    LeOldNumReservation := ' ';
    LePortArticle       := 0; -- pour creation port article
    BEGIN
      -- Recuperation du taux escompte
      BEGIN
        SELECT tr.VALEURDEFAUT / 100
          INTO LeTauxEscompte
          FROM TYPES_REMISE        tr
              ,LBM_PARAM_INTERFACE p
         WHERE tr.codetyperemise = p.coderemiseescompte
           AND ROWNUM = 1;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Probleme lors du traitement PRC_LBM_COMMANDES, du taux escompte.');
      END;
      -- Entete Resa
      FOR LigneTete IN (SELECT lr.NUMRESERVATION
                              ,DateOSCC
                              ,CodeMagasinEmetteur
                              ,CODECAISSE
                              ,CodeClient
                              ,MIN(lr.STATUT) StatutEnTete
                          FROM RESERVATIONS_WST            lr
                              ,HISTO_OSCC                  ho
                              ,LBM_RESERVATIONS_A_EXTRAIRE lrae
                         WHERE lr.NUMRESERVATION = ho.CODEOSCC
                           AND lrae.NUMRESERVATION = lr.NUMRESERVATION
                         GROUP BY lr.NUMRESERVATION
                                 ,DateOSCC
                                 ,CodeMagasinEmetteur
                                 ,CODECAISSE
                                 ,CodeClient) LOOP
        /*
        -- Modif BF gestion des TOP
        --IF (NOT bTrouve) OR ((LETOPCA = 1) AND ((LeTOPLM = 1) OR (LeTOPLM IS NULL)) AND (LeTOPGU = 1)) THEN
        IF fCommandeAtransferer THEN
        IF (LeOldNumReservation <> LigneTete.NUMRESERVATION) AND (LePortArticle <> 0) THEN
        LeNumPoste:= RetourneNumPoste(LeOldNumReservation);
        AlimenteParametre(LePortArticle);
        
        -- Recuperation CodeBarre FdP
        BEGIN
        SELECT CODEBARRES INTO LeEANSaisieFdP
        FROM HISTO_CB_FRN
        WHERE CODEINTERNEARTICLE = LePortArticle
        AND   ROWNUM = 1;
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
        LeEANSaisieFdP:= '';
        END;
        
        IF LeStatutEnTete < 10 THEN
        LeStatut:= 10;
        ELSE
        LeStatut:= LeStatutEnTete;
        END IF;
        Maj_LBM_COMMANDE_POSTE(LeCodeMagasinEmetteur, LaDateOSCC, LeOldNumReservation, LeNumPoste, 0,
        LeDEPARTEMENT, LeCP, 98, LeEANSaisieFdP, LeNomProduit, 1, LeCODEUNITEGESTIONVENTE,
        0, LePortMontant, LeAPPL, LeTYPEGEST, 0, LeTVATaux, 0, 0,
        0, LeHCA, NULL, LeCodeNature, NULL, NULL, LeStatut, sysdate);
        END IF;
        END IF;
        */
        --FTR le 26/11/2010 bug sur la remontee des frais de port si nomalie sur la commande suivante
        LeOldNumReservation := ' ';
        --Fin FTR le 26/11/2010
        LeCodeMagasinEmetteur := LigneTete.CodeMagasinEmetteur;
        LaDateOSCC            := LigneTete.DateOSCC;
        LeStatutEnTete        := LigneTete.StatutEnTete;
        LeMagasin             := ' ';
        LeInfoVendeur         := ' ';
        LePortArticle         := 0;
        LePortMontant         := 0;
        LeCdeMeuble           := 0;
        --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
        LeDateConfirm := 'NON';
        --Fin ajout FTR le 15/11/2010
        LeReducGeste      := 0;
        LeTypeEnlevement  := 0;
        LeCondiLivr1      := ' ';
        LeCondiLivr2      := ' ';
        LeCondiLivr3      := ' ';
        LeEscompte        := 0;
        LaDateModifStatus := sysdate;
        fLock             := 0;
        -- Recuperation des parametres de la reservation
        FOR LigneRubLibre IN (SELECT CODEPROFIL
                                    ,VALEURELEMENT
                                    ,CODEELEMENT
                                FROM RESAZONEVAL_WST
                               WHERE NUMRESERVATION = LigneTete.NUMRESERVATION) LOOP
          CASE LigneRubLibre.CODEPROFIL
            WHEN NoRubrique_Magasin THEN
              LeMagasin := LigneRubLibre.CODEELEMENT;
            WHEN NoRubrique_InfoVendeur THEN
              LeInfoVendeur := LigneRubLibre.VALEURELEMENT;
            WHEN NoRubrique_PortArticle THEN
              BEGIN
                LePortArticle := TO_NUMBER(LigneRubLibre.CODEELEMENT);
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. PortArticle Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'PortArticle Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
            WHEN NoRubrique_PortMontant THEN
              BEGIN
                LePortMontant := TO_NUMBER(LigneRubLibre.VALEURELEMENT) / 100;
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. PortMontant Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'PortMontant Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
            WHEN NoRubrique_CdeMeuble THEN
              BEGIN
                LeCdeMeuble := TO_NUMBER(LigneRubLibre.VALEURELEMENT);
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. CdeMeuble Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'CdeMeuble Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
              --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
            WHEN NoRubrique_DateConfirm THEN
              BEGIN
                CASE TO_NUMBER(LigneRubLibre.CODEELEMENT)
                  WHEN 1 THEN
                    LeDateConfirm := 'OUI';
                  WHEN 2 THEN
                    LeDateConfirm := 'NON';
                END CASE;
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. DateConfirm Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'DateConfirm Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
              --Fin ajout FTR le 15/11/2010
            WHEN NoRubrique_ReducGeste THEN
              BEGIN
                LeReducGeste := TO_NUMBER(LigneRubLibre.VALEURELEMENT) / 100;
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. ReducGeste Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'ReducGeste Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
            WHEN NoRubrique_TypeEnlevement THEN
              BEGIN
                LeTypeEnlevement := TO_NUMBER(LigneRubLibre.CODEELEMENT);
              EXCEPTION
                WHEN OTHERS THEN
                  Ajouter_Log(1
                             ,LeCodeMsg
                             ,'Une erreur s''est produite lors de la generation des commandes clients. TypeEnlevement Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                  Ajouter_Log_LBM('LBM_COMMANDES'
                                 ,LeCodeTraitementBizTalk
                                 ,1
                                 ,'TypeEnlevement Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                 ,'');
              END;
            WHEN NoRubrique_CondiLivr1 THEN
              LeCondiLivr1 := LigneRubLibre.VALEURELEMENT;
            WHEN NoRubrique_CondiLivr2 THEN
              LeCondiLivr2 := LigneRubLibre.VALEURELEMENT;
            WHEN NoRubrique_CondiLivr3 THEN
              LeCondiLivr3 := LigneRubLibre.VALEURELEMENT;
            WHEN NoRubrique_Escompte THEN
              IF LigneRubLibre.VALEURELEMENT IS NULL THEN
                LeEscompte := 0;
              ELSE
                BEGIN
                  LeEscompte := TO_NUMBER(LigneRubLibre.VALEURELEMENT) / 100;
                EXCEPTION
                  WHEN OTHERS THEN
                    Ajouter_Log(1
                               ,LeCodeMsg
                               ,'Une erreur s''est produite lors de la generation des commandes clients. Escompte Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE));
                    Ajouter_Log_LBM('LBM_COMMANDES'
                                   ,LeCodeTraitementBizTalk
                                   ,1
                                   ,'Escompte Valeur non Entiere sur Reservation ' || LigneTete.NUMRESERVATION || CHR(13) || SQLERRM(SQLCODE)
                                   ,'');
                END;
              END IF;
            WHEN NoRubrique_DateModifStatut THEN
              LaDateModifStatus := LigneRubLibre.VALEURELEMENT;
            WHEN NoRubrique_Lock THEN
              fLock := LigneRubLibre.ValeurElement;
            ELSE
              NULL;
          END CASE; END LOOP;
        BEGIN
          SELECT TOPCA
                ,TOPLM
                ,lce.STATUT
                ,MIN(TOPGU)
            INTO LeTOPCA
                ,LeTOPLM
                ,LeStatut
                ,LeTOPGU
            FROM LBM_COMMANDE_ENTETE lce
                ,LBM_COMMANDE_POSTE  lcp
           WHERE lce.NUMCDECLI = LigneTete.NUMRESERVATION
             AND lcp.NUMCDECLI = lce.NUMCDECLI
           GROUP BY TOPCA
                   ,TOPLM
                   ,lce.STATUT;
          bTrouve := true;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN
            LETOPCA := 0;
            LeTOPLM := 0;
            LeTOPLM := 0;
            LeTOPGU := 0;
            bTrouve := false;
        END;
      
        fCommandeATransferer := (LETOPCA <> 2 AND (LeTOPLM <> 2 or LeTOPLM IS NULL) AND LeTOPGU <> 2 AND fLock = 0);
      
        FOR Ligne IN (SELECT lr.EANSAISI
                            ,lr.CODEINTERNEARTICLE
                            ,lr.NUMLIGNE
                            ,lr.PRIXACHAT
                            ,DateDispo
                            ,lr.Remarque
                            ,DECODE(tr.APPLICABLEEN
                                   ,1
                                   ,lr.NUMREMISE
                                   ,0) ReducType
                            ,DECODE(tr.APPLICABLEEN
                                   ,0
                                   ,lr.NUMREMISE
                                   ,0) RemiseType
                            ,
                             -- Modif BF Qte/VALUV
                             --CMDFOUR, MATVENDEUR, QTERESERVE, PRIXVENTEDEP, PRIXVENTE, MONTANTREM, NUMREMISE, clt.CODECLIENT, lr.DateModification,
                             CMDFOUR
                            ,MATVENDEUR
                            ,QTERESERVE / VALUV as QTERESERVE
                            ,PRIXVENTEDEP
                            ,PRIXVENTE
                            ,MONTANTREM
                            ,NUMREMISE
                            ,clt.CODECLIENT
                            ,lr.DateModification
                            ,
                             -- Modif BF du 28/11/10 suppression typevoie, bister et numerovoie
                             lr.TYPERESERVATION
                            ,lr.STATUT
                            ,clt.NOM
                            ,clt.PRENOM
                            , --tva1.LIBTYPEVOIEADRESSE LIBTYPEVOIEADRESSELiv, tva2.LIBTYPEVOIEADRESSE LIBTYPEVOIEADRESSEFact,
                             --adr1.LIEUDIT||' '||adr1.COMPLEMENTNOM||' '||adr1.COMPLEMENTADRESSE||' '||adr1.NUMEROVOIE||' '||adr1.BISTER||' '||tva1.LIBTYPEVOIEADRESSE||' '||adr1.LibelleVoie AdresseLiv,
                             adr1.LIEUDIT || ' ' || adr1.COMPLEMENTNOM || ' ' || adr1.COMPLEMENTADRESSE || ' ' || adr1.LibelleVoie AdresseLiv
                            ,
                             --adr2.LIEUDIT||' '||adr2.COMPLEMENTNOM||' '||adr2.COMPLEMENTADRESSE||' '||adr2.NUMEROVOIE||' '||adr2.BISTER||' '||tva2.LIBTYPEVOIEADRESSE||' '||adr2.LibelleVoie AdresseFact,
                             adr2.LIEUDIT || ' ' || adr2.COMPLEMENTNOM || ' ' || adr2.COMPLEMENTADRESSE || ' ' || adr2.LibelleVoie AdresseFact
                            ,adr1.CodePostal CodePostalLiv
                            ,adr1.Ville VilleLiv
                            ,p1.CodePays PaysLiv
                            ,adr2.CodePostal CodePostalFact
                            ,adr2.Ville VilleFact
                            ,p2.CodePays PaysFact
                        FROM RESERVATIONS_WST lr
                            ,ADRESSES_WST     adr1
                            ,ADRESSES_WST     adr2
                            ,CLIENTS          clt
                            ,
                             --TYPES_VOIE_ADRESSE tva1,  TYPES_VOIE_ADRESSE tva2, PAYS p1, PAYS p2, TYPES_REMISE tr
                             PAYS         p1
                            ,PAYS         p2
                            ,TYPES_REMISE tr
                       WHERE lr.NUMRESERVATION = LigneTete.NUMRESERVATION
                         AND clt.CodeClient = LigneTete.CodeClient
                         AND adr1.NUMRESERVATION = lr.NUMRESERVATION
                         AND adr1.TYPEADRESSE = 1
                            --AND   adr1.CODETYPEVOIE = tva1.CODEENMAGASIN
                         AND adr1.CODEPAYS = p1.CODEENMAGASIN
                         AND adr2.NUMRESERVATION = lr.NUMRESERVATION
                         AND adr2.TYPEADRESSE = 0
                            --AND   adr2.CODETYPEVOIE = tva2.CODEENMAGASIN
                         AND adr2.CODEPAYS = p2.CODEENMAGASIN
                         AND tr.CodeTypeRemise(+) = lr.NUMREMISE
                       ORDER BY NUMLIGNE) LOOP
          -- 1er ligne de la reservation recuperation info + creation en tete  articles
          IF (LeOldNumReservation <> LigneTete.NUMRESERVATION) THEN
            LeOldNumReservation := LigneTete.NUMRESERVATION;
            bTraiteLigne        := true;
            -- si l'entete n'existe pas ou est modifiable
            --IF (NOT bTrouve) OR ((LETOPCA = 1) AND ((LeTOPLM = 1) OR (LeTOPLM IS NULL)) AND (LeTOPGU = 1)) THEN
            IF fCommandeATransferer THEN
              Maj_LBM_COMMANDE_ENTETE(LeCodeMagasinEmetteur
                                     ,LaDateOSCC
                                     ,LigneTete.CodeCaisse
                                     ,Ligne.MATVENDEUR
                                     ,LigneTete.NUMRESERVATION
                                     ,Ligne.CODECLIENT
                                     ,SUBSTR(Ligne.TYPERESERVATION
                                            ,LENGTH(Ligne.TYPERESERVATION) - 1
                                            ,2)
                                     ,LeMagasin
                                     ,LigneTete.StatutEntete
                                     ,Ligne.DateDispo
                                     ,LeTypeEnlevement
                                     ,LeInfoVendeur
                                     ,LePortMontant
                                     ,LeCdeMeuble
                                     ,LeReducGeste
                                     ,NULL
                                     ,Ligne.Remarque
                                     ,Ligne.Nom
                                     ,Ligne.Prenom
                                     ,LeCondiLivr1 || ' ' || LeCondiLivr2 || ' ' || LeCondiLivr3
                                     ,Ligne.AdresseLiv
                                     ,Ligne.CodePostalLiv
                                     ,Ligne.VilleLiv
                                     ,Ligne.PaysLiv
                                     ,Ligne.AdresseFact
                                     ,Ligne.CodePostalFact
                                     ,Ligne.VilleFact
                                     ,Ligne.PaysFact
                                     ,
                                      --Ajout FTR le 15/11/2010 pour envoi de la confirmation de date de livr dans le decisionnel
                                      --Ligne.DateModification, 0, NULL, LaDateModifStatus, NULL, NULL);
                                      Ligne.DateModification
                                     ,0
                                     ,NULL
                                     ,LaDateModifStatus
                                     ,NULL
                                     ,NULL
                                     ,LeDateConfirm);
              --Fin ajout FTR le 15/11/2010
              -- Calcul de l'escompte
              EscompteNbLigne         := 0;
              EscompteMtTotal         := 0;
              EscompteMtIntermediaire := 0;
              -- AJout BF  pour ventilation ReducGeste
              ReducGesteIntermediaire      := 0;
              EscompteNbLigneIntermediaire := 0;
              EscompteCATicketTotal        := 0;
              -- Modif BF ventilation ReducGeste
              IF LeEscompte <> 0
                 or LeReducGeste > 0 THEN
                -- Modif BF Qte/VALUV
                SELECT SUM(QTERESERVE * PRIXVENTE / VALUV)
                      ,COUNT(*)
                  INTO EscompteCATicketTotal
                      ,EscompteNbLigne
                  FROM RESERVATIONS_WST
                 WHERE NUMRESERVATION = LigneTete.NUMRESERVATION
                      -- Modif BF arrondi au cts superieur de l'escompte
                   AND CODEINTERNEARTICLE <> LePortArticle;
                -- Modif FTR le 13/05/2009 on ne calcul l'escompte total que si il existe
                IF LeEscompte <> 0 THEN
                  EscompteMtTotal := CEIL(100 * (EscompteCATicketTotal - LeReducGeste) * LeTauxEscompte) / 100;
                END IF;
              END IF;
            ELSE
              bTraiteLigne := false;
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Trace issue de la generation des commandes clients. Ligne d''entete non modifiable ' || LigneTete.NUMRESERVATION);
              Ajouter_Log_LBM('LBM_COMMANDES'
                             ,LeCodeTraitementBizTalk
                             ,1
                             ,'Ligne d''entete non modifiable ' || LigneTete.NUMRESERVATION
                             ,'');
            END IF;
          END IF; -- rupture numresa
        
          -- Gestion des lignes
          IF bTraiteLigne THEN
            AlimenteParametre(Ligne.CODEINTERNEARTICLE);
            -- Calcul du TypeArt
            IF LeGereEnStock = 0 THEN
              LeTypeArt := 100;
            ELSE
              IF LeCodeEtat < 10 THEN
                LeTypeArt := 1;
              ELSE
                LeTypeArt := LeCodeEtat;
              END IF;
            END IF;
            --calcul de l'escompte
            -- Modif BF ventilation ReducGeste
            IF (LeEscompte <> 0 OR LeReducGeste > 0)
               AND (Ligne.CODEINTERNEARTICLE <> LePortArticle) THEN
              IF EscompteNbLigneIntermediaire < EscompteNbLigne THEN
                IF EscompteMtIntermediaire < EscompteMtTotal THEN
                  LeEscMont := ceil(100 * EscompteMtTotal * Ligne.QTERESERVE * Ligne.PRIXVENTE / EscompteCATicketTotal) / 100;
                ELSE
                  LeEscMont := 0;
                END IF;
                IF EscompteMtTotal - EscompteMtIntermediaire - LeEscMont < 0 THEN
                  LeEscMont := EscompteMtTotal - EscompteMtIntermediaire;
                END IF;
                EscompteMtIntermediaire      := EscompteMtIntermediaire + LeEscMont;
                EscompteNbLigneIntermediaire := EscompteNbLigneIntermediaire + 1;
                -- Ajout BF ventilation ReducGeste
                IF ReducGesteIntermediaire < LeReducGeste THEN
                  LeReducGesteLigne := ceil(100 * LeReducGeste * Ligne.QTERESERVE * Ligne.PRIXVENTE / EscompteCATicketTotal) / 100;
                ELSE
                  LeReducGesteLigne := 0;
                END IF;
                IF LeReducGeste - ReducGesteIntermediaire - LeReducGesteLigne < 0 THEN
                  LeReducGesteLigne := LeReducGeste - ReducGesteIntermediaire;
                END IF;
                ReducGesteIntermediaire := ReducGesteIntermediaire + LeReducGesteLigne;
              END IF;
            ELSE
              LeEscMont := 0;
              -- Ajout BF ventilation ReducGeste
              LeReducGesteLigne := 0;
            END IF;
            -- Ajout FTR le 13/05/2009 multiplication du montant remise unitaire par la quantite
          
            Ligne.MONTANTREM := Ligne.MONTANTREM * Ligne.QTERESERVE;
            -- Ajout BF chgt coderemise en fonction du montant le plus important
            IF LeReducGesteLigne > Ligne.MONTANTREM
               AND LeReducGesteLigne > LeEscMont THEN
              Ligne.RemiseType := CodeRemiseComplementaire;
              Ligne.ReducType  := 0;
              -- Ajout FTR le 13/05/2009 si on met un type remise on passe le type reduction a 0
            ELSIF LeEscMont > Ligne.MONTANTREM
                  AND LeEscMont > LeReducGesteLigne THEN
              Ligne.RemiseType := CodeRemiseEscompte;
              -- Ajout FTR le 13/05/2009 si on met un type remise on passe le type reduction a 0
              Ligne.ReducType := 0;
            END IF;
          
            Maj_LBM_COMMANDE_POSTE(LeCodeMagasinEmetteur
                                  ,LaDateOSCC
                                  ,LigneTete.NUMRESERVATION
                                  ,Ligne.NumLigne
                                  ,Ligne.CmdFour
                                  ,LeDEPARTEMENT
                                  ,LeCP
                                  ,LeTYPEART
                                  ,Ligne.EANSAISI
                                  ,LeNomProduit
                                  ,Ligne.QTERESERVE
                                  ,LeCODEUNITEGESTIONVENTE
                                  ,
                                   -- Modif BF : ajout de la ReducGeste et de l'escompte dans le total des remises lignes et calcul CAnetligne
                                   -- FTR le 29/07/2010 on arrondi au centime inferieur avec la fonction TRUNC
                                   --Ligne.PRIXVENTEDEP, Ligne.QTERESERVE*Ligne.PRIXVENTE-(LeReducGesteLigne+LeEscMont), LeAPPL, LeTYPEGEST,
                                   Ligne.PRIXVENTEDEP
                                  ,TRUNC(Ligne.QTERESERVE * Ligne.PRIXVENTE
                                        ,2) - (LeReducGesteLigne + LeEscMont)
                                  ,LeAPPL
                                  ,LeTYPEGEST
                                  ,
                                   -- Fin FTR le29/07/2010
                                   Ligne.MONTANTREM + LeReducGesteLigne + LeEscMont
                                  ,LeTVATaux
                                  ,LeEscMont
                                  ,Ligne.ReducType
                                  ,Ligne.RemiseType
                                  ,LeHCA
                                  ,NULL
                                  ,LeCodeNature
                                  ,Ligne.PRIXACHAT
                                  ,
                                   -- Modif BF : ajout du commentaire
                                   RetourneCommPoste(LigneTete.NUMRESERVATION
                                                    ,Ligne.NumLigne)
                                  ,Ligne.Statut
                                  ,sysdate);
          END IF;
        END LOOP;
      
        --Trace les enregistrements pour lesquels une jointure n'est pas satisfaite
        FOR Ligne IN (SELECT DISTINCT lr.NUMRESERVATION
                                     ,clt.CODECLIENT
                                     ,adr1.NumReservation Numad1
                                     ,tva1.CodeEnMagasin TVA1
                                     ,adr1.CODETYPEVOIE CODETYPEVOIE1
                                     ,p1.CODEENMAGASIN MAG1
                                     ,adr1.CODEPAYS PAYS1
                                     ,adr2.NumReservation Numad0
                                     ,tva2.CodeEnMagasin TVA0
                                     ,adr2.CODETYPEVOIE CODETYPEVOIE0
                                     ,p2.CODEENMAGASIN MAG0
                                     ,adr2.CODEPAYS PAYS0
                        FROM RESERVATIONS_WST   lr
                            ,ADRESSES_WST       adr1
                            ,ADRESSES_WST       adr2
                            ,CLIENTS            clt
                            ,TYPES_VOIE_ADRESSE tva1
                            ,TYPES_VOIE_ADRESSE tva2
                            ,PAYS               p1
                            ,PAYS               p2
                       WHERE lr.NUMRESERVATION = LigneTete.NUMRESERVATION
                         AND clt.CodeClient(+) = LigneTete.CodeClient
                         AND adr1.NUMRESERVATION(+) = lr.NUMRESERVATION
                         AND adr1.TYPEADRESSE(+) = 1
                         AND tva1.CODEENMAGASIN(+) = adr1.CODETYPEVOIE
                         AND p1.CODEENMAGASIN(+) = adr1.CODEPAYS
                         AND adr2.NUMRESERVATION(+) = lr.NUMRESERVATION
                         AND adr2.TYPEADRESSE(+) = 0
                         AND tva2.CODEENMAGASIN(+) = adr2.CODETYPEVOIE
                         AND p2.CODEENMAGASIN(+) = adr2.CODEPAYS) LOOP
          IF Ligne.CodeClient IS NULL THEN
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Trace issue de la generation des commandes clients. Client non trouve sur CLIENTS ' || Ligne.NumReservation);
            Ajouter_Log_LBM('LBM_COMMANDES'
                           ,LeCodeTraitementBizTalk
                           ,1
                           ,'Client non trouve sur CLIENTS ' || Ligne.NumReservation
                           ,'');
          END IF;
          IF Ligne.Numad1 IS NULL THEN
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Trace issue de la generation des commandes clients. Adresse de type 1 non trouvee ' || Ligne.NumReservation);
            Ajouter_Log_LBM('LBM_COMMANDES'
                           ,LeCodeTraitementBizTalk
                           ,1
                           ,'Adresse de type 1 non trouvee ' || Ligne.NumReservation
                           ,'');
          ELSE
            IF Ligne.TVA1 IS NULL THEN
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Trace issue de la generation des commandes clients. type de voie d''adresse ' || Ligne.CodeTypeVoie1 || ' non trouvee ' || Ligne.NumReservation);
              Ajouter_Log_LBM('LBM_COMMANDES'
                             ,LeCodeTraitementBizTalk
                             ,1
                             ,'Adresse de type 1, type de voie d''adresse ' || Ligne.CodeTypeVoie1 || ' non trouvee ' || Ligne.NumReservation
                             ,'');
            ELSE
              IF Ligne.MAG1 IS NULL THEN
                Ajouter_Log(1
                           ,LeCodeMsg
                           ,'Trace issue de la generation des commandes clients. Adresse de type 1, pays ' || Ligne.PAYS1 || ' non trouve  ' || Ligne.NumReservation);
                Ajouter_Log_LBM('LBM_COMMANDES'
                               ,LeCodeTraitementBizTalk
                               ,1
                               ,'Adresse de type 1, pays ' || Ligne.PAYS1 || ' non trouve ' || Ligne.NumReservation
                               ,'');
              END IF;
            END IF;
          END IF;
          IF Ligne.Numad0 IS NULL THEN
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Trace issue de la generation des commandes clients. Adresse de type 0 non trouvee ' || Ligne.NumReservation);
            Ajouter_Log_LBM('LBM_COMMANDES'
                           ,LeCodeTraitementBizTalk
                           ,1
                           ,'Adresse de type 0 non trouvee ' || Ligne.NumReservation
                           ,'');
          ELSE
            IF Ligne.TVA0 IS NULL THEN
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Trace issue de la generation des commandes clients. Adresse de type 0, type de voie d''adresse ' || Ligne.CodeTypeVoie1 || ' non trouvee ' || Ligne.NumReservation);
              Ajouter_Log_LBM('LBM_COMMANDES'
                             ,LeCodeTraitementBizTalk
                             ,1
                             ,'Adresse de type 0, type de voie d''adresse ' || Ligne.CodeTypeVoie1 || ' non trouvee ' || Ligne.NumReservation
                             ,'');
            ELSE
              IF Ligne.MAG0 IS NULL THEN
                Ajouter_Log(1
                           ,LeCodeMsg
                           ,'Trace issue de la generation des commandes clients. Adresse de type 0, pays ' || Ligne.PAYS0 || ' non trouve  ' || Ligne.NumReservation);
                Ajouter_Log_LBM('LBM_COMMANDES'
                               ,LeCodeTraitementBizTalk
                               ,1
                               ,'Adresse de type 0, pays ' || Ligne.PAYS0 || ' non trouve ' || Ligne.NumReservation
                               ,'');
              END IF;
            END IF;
          END IF;
        END LOOP;
      
        -- Modif BF gestion des TOP
        --IF (NOT bTrouve) OR ((LETOPCA = 1) AND ((LeTOPLM = 1) OR (LeTOPLM IS NULL)) AND (LeTOPGU = 1)) THEN
        --FTR le 26/11/2010 bug sur la remontee des frais de port si nomalie sur la commande suivante
        --IF fCommandeATransferer THEN
        IF fCommandeATransferer
           AND LeOldNumReservation <> ' ' THEN
          --Fin FTR le 26/11/2010
          IF (LePortArticle <> 0) THEN
            LeNumPoste := RetourneNumPoste(LeOldNumReservation);
            AlimenteParametre(LePortArticle);
          
            -- Recuperation CodeBarre FdP
            /*
            BEGIN
            SELECT CODEBARRES INTO LeEANSaisieFdP
            FROM HISTO_CB_FRN
            WHERE CODEINTERNEARTICLE = LePortArticle
            AND   ROWNUM = 1;
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            LeEANSaisieFdP:= '';
            END;
            */
            --Recupere code barres founisseur, si non present code barres article
            LeEANSaisieFdP := Retourne_CodeEanSite(lePortArticle
                                                  ,3
                                                  ,0);
          
            IF LeStatutEnTete < 10 THEN
              LeStatut := 10;
            ELSE
              LeStatut := LeStatutEnTete;
            END IF;
            Maj_LBM_COMMANDE_POSTE(LeCodeMagasinEmetteur
                                  ,LaDateOSCC
                                  ,LeOldNumReservation
                                  ,LeNumPoste
                                  ,0
                                  ,LeDEPARTEMENT
                                  ,LeCP
                                  ,98
                                  ,LeEANSaisieFdP
                                  ,LeNomProduit
                                  ,1
                                  ,LeCODEUNITEGESTIONVENTE
                                  ,0
                                  ,LePortMontant
                                  ,LeAPPL
                                  ,LeTYPEGEST
                                  ,0
                                  ,LeTVATaux
                                  ,0
                                  ,0
                                  ,0
                                  ,LeHCA
                                  ,NULL
                                  ,LeCodeNature
                                  ,NULL
                                  ,NULL
                                  ,LeStatut
                                  ,sysdate);
          ELSE
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Trace issue de la generation des commandes clients. PortArticle=0 ' || LeOldNumReservation);
            Ajouter_Log_LBM('LBM_COMMANDES'
                           ,LeCodeTraitementBizTalk
                           ,1
                           ,'PortArticle=0 ' || LeOldNumReservation
                           ,'');
          END IF;
        END IF;
      
        IF ControleCommandeValide(LigneTete.NumReservation) THEN
          --IF (NOT bTrouve) OR ((LETOPCA = 1) AND ((LeTOPLM = 1) OR (LeTOPLM IS NULL)) AND (LeTOPGU = 1)) THEN -- Insert ou peut t'on modif?
          IF fCommandeATransferer THEN
            -- On valide Resa par Resa
            DELETE FROM LBM_RESERVATIONS_A_EXTRAIRE WHERE NUMRESERVATION = LigneTete.NUMRESERVATION;
            COMMIT;
          END IF;
        ELSE
          Rollback;
        END IF;
      END LOOP;
    
      --Trace les enregistrements avec jointures non satisfaites
      FOR LigneTete IN (SELECT lrae.NumReservation NumLRAE
                              ,lr.NumReservation NumLR
                              ,ho.CodeOscc
                          FROM LBM_RESERVATIONS_A_EXTRAIRE lrae
                              ,RESERVATIONS_WST            lr
                              ,HISTO_OSCC                  ho
                         WHERE lr.NUMRESERVATION(+) = lrae.NUMRESERVATION
                           AND ho.CODEOSCC(+) = lr.NUMRESERVATION) LOOP
        IF LigneTete.NumLR IS NULL THEN
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Trace issue de la generation des commandes clients. Reservation non presente sur RESERVATIONS_WST ' || LigneTete.NumLRAE);
          Ajouter_Log_LBM('LBM_COMMANDES'
                         ,LeCodeTraitementBizTalk
                         ,1
                         ,'Reservation non presente sur RESERVATIONS_WST ' || LigneTete.NumLRAE
                         ,'');
        ELSE
          IF LigneTete.CodeOscc IS NULL THEN
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Trace issue de la generation des commandes clients. Reservation non presente sur HISTO_OSCC ' || LigneTete.NumLRAE);
            Ajouter_Log_LBM('LBM_COMMANDES'
                           ,LeCodeTraitementBizTalk
                           ,1
                           ,'Reservation non presente sur HISTO_OSCC ' || LigneTete.NumLRAE
                           ,'');
          END IF;
        END IF;
      END LOOP;
      /*
      --IF (NOT bTrouve) OR ((LETOPCA = 1) AND ((LeTOPLM = 1) OR (LeTOPLM IS NULL)) AND (LeTOPGU = 1)) THEN -- Insert ou peut t'on modif?
      IF fCommandeAtranferer THEN
      IF (LePortArticle <> 0) THEN
      LeNumPoste:= RetourneNumPoste(LeOldNumReservation);
      AlimenteParametre(LePortArticle);
      -- Recuperation CodeBarre FdP
      BEGIN
      SELECT CODEBARRES INTO LeEANSaisieFdP
      FROM HISTO_CB_FRN
      WHERE CODEINTERNEARTICLE = LePortArticle
      AND   ROWNUM = 1;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
      LeEANSaisieFdP:= '';
      END;
      
      IF LeStatutEnTete < 10 THEN
      LeStatut:= 10;
      ELSE
      LeStatut:= LeStatutEnTete;
      END IF;
      
      Maj_LBM_COMMANDE_POSTE(LeCodeMagasinEmetteur, LaDateOSCC, LeOldNumReservation, LeNumPoste, 0,
      LeDEPARTEMENT, LeCP, 98, LeEANSaisieFdP, LeNomProduit, 1, LeCODEUNITEGESTIONVENTE,
      0, LePortMontant, LeAPPL, LeTYPEGEST, 0, LeTVATaux, 0, 0,
      0, LeHCA, NULL, LeCodeNature, NULL, NULL, LeStatut, sysdate);
      COMMIT;
      END IF;
      END IF;*/
    EXCEPTION
      WHEN OTHERS THEN
        ROLLBACK;
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de la generation des commandes clients.' || CHR(13) || SQLERRM(SQLCODE));
        Ajouter_Log_LBM('LBM_COMMANDES'
                       ,LeCodeTraitementBizTalk
                       ,1
                       ,SQLERRM(SQLCODE)
                       ,'');
    END;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la generation des commandes client par LBM_COMMANDES');
  END;

  /*******************************************************************/
  /*  Procedure LBM_Article                                          */
  /*                                                                 */
  /*  Integratrion en masse des ARTICLES, PRODUITS, PRODUITS_COLORIS */
  /*    depuis la table LBM_ARTICLES                                 */
  /*                                                                 */
  /*  JSC 15/07/2008 #25887 Creation                                 */
  /*  BFU 29/01/2009 Modifications                                   */
  /*  AD  08/04/2009 Correction integration du type article          */
  /*                Tracker 31480                                    */
  /*  GD  03/06/2009 #32418 Correctifs divers                        */
  /*  BFU 12/04/2009 Modifications GereEnStock pour ajouter les Null */
  /*                Tracker 32418 (mail BFU le 13/5/2009 a 10h00)    */
  /*******************************************************************/

  PROCEDURE PRC_LBM_ARTICLE IS
    LeCodeMsg            LOG_TRAITEMENTS.CodeMsg%TYPE;
    LeCodeProduit        INT_ARTICLES.CodeProduit%TYPE;
    LeCodeInterneArticle INT_ARTICLES.CodeInterneArticle%TYPE;
    LeCodeBarre          INT_ARTICLES.CodeBarres%TYPE;
    LeCodePaysDuSite     PAYS.CodePays%TYPE;
    LAxeStatMarque       AXES_STATISTIQUES.CodeAxeStat%TYPE;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock  TTabLock;
    NomTable VARCHAR2(60);
  BEGIN
    LeCodeMsg := 'BIZ-0001';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de l''integration en masse des articles par LBM_ARTICLE');
  
    LeCodePaysDuSite := PK_SITE.RetourneParametreSiteVarchar('CODEPAYS');
    LAxeStatMarque   := PK_SITE.RetourneParametreSiteNumber('AXESTATMARQUE');
  
    ------------------------------------------------------------------------
    -- 5.4.1)  poser un verrou Oracle sur les articles a traiter (select for update) pour eviter les mises a jour de Biztalk en cours de traitement des articles, de leurs eans et des prix.
    ------------------------------------------------------------------------
    SELECT la.ArtCode BULK COLLECT
      INTO TabLock
      FROM LBM_ARTICLE la
     INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = la.MessageId
                                  and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       FOR UPDATE;
  
    ------------------------------------------------------------------------
    -- 5.4.2) Insert global dans INT_PRODUITS, INT_ARTICLES puis attribution de nouveaux codes pour les nouveaux articles
    ------------------------------------------------------------------------
    -- gestion des erreurs globalement au niveau de ce begin
    BEGIN
      -- Insertion en masse dans INT_PRODUITS
      NomTable := 'INT_PRODUITS';
      INSERT INTO INT_PRODUITS
        (SELECT NVL(p.CodeProduit
                   ,-1 * RowNum)
               , -- CodeProduit
                la.ArtCode
               , -- NomProduit
                REPLACE(la.ArtDes
                       ,'|'
                       ,' ')
               , -- LibProduit
                'PERM'
               , -- Code Saison
                la.CP
               , -- CodeClassProd3
                1
               , -- CodeGrilleTaille
                1
               , -- CodeTypeEtiquette
                NULL
               , -- CodeDouanier
                1
               , -- CodeTypeStockage
                0
               , -- PoidsProduit
                0
               , -- VolumeProduit
                0
               , -- EpaisseurProduit
                NULL
               , -- Observation
                0
               , -- CodeUtilisateur
                NVL(p.DateCreation
                   ,TRUNC(SYSDATE))
               , -- DateCreation
                TRUNC(SYSDATE)
               , -- DateModification
                0
               , -- CodeGrilleVariante
                DECODE(la.CodeMaj
                      ,3
                      ,TRUNC(SYSDATE)
                      ,NULL)
               , -- DateSuppression
                1
               , -- CodeColorisSel
                --Modif ERI le 27/05/2015: gestion des articles gratuit
                --0,                            -- ProduitGratuit
                NVL(p.PRODUITGRATUIT
                   ,0)
               , -- ProduitGratuit
                --Fin Modif ERI le 27/05/2015
                0
               , -- AuCatalogueWeb
                NULL
               , -- DateFinVie
                0
               , -- Poids
                0
               , -- Jauge
                1
               , -- Unite logistique
                1
               , -- TypeProduit
                1
               , -- CodeTypeReassort
                LeCodePaysDuSite
               , -- CodePaysOrigine
                NULL
               , -- ObservationSurBC
                LeCodePaysDuSite
               , -- CodePaysOrigineMatiere
                0
               , -- LongueurProduit
                0
               , -- HauteurProduit
                0
               , -- CodeTypeEmballage
                NULL
               , -- DelaiReassort
                NULL
               , -- DureeDeVie
                NULL
               , -- CodeTypeMethodeReassort
                NULL
               , -- ZoneDeDoute
                NULL
               , -- DateFinCdeDirecte
                NULL
               , -- CodeUnitePresentation
                0
               , -- NbPieceParUnitePresent
                NULL
               , -- DateModificationAssort
                0
               , -- ExclusionFidelite
                NULL
               , -- CodeDouanier2
                DECODE(la.UniteVT
                      ,'PCE'
                      ,0
                      ,'CT'
                      ,1
                      ,'KG'
                      ,2
                      ,'L'
                      ,3
                      ,'MTR'
                      ,4)
               , -- CodeUniteGestionVente
                DECODE(la.UniteVT
                      ,'PCE'
                      ,0
                      ,'CT'
                      ,1
                      ,'KG'
                      ,2
                      ,'L'
                      ,3
                      ,'MTR'
                      ,4)
               , -- CodeUniteGestionStock
                DECODE(la.UniteVT
                      ,'PCE'
                      ,0
                      ,'CT'
                      ,1
                      ,'KG'
                      ,2
                      ,'L'
                      ,3
                      ,'MTR'
                      ,4)
               , -- CodeUniteGestionAchat
                1
               , -- IndiceTailleBase
                SYSDATE
               , -- DateModificationTFJ
                0 -- NbPiecesParUniteRangement
           FROM LBM_ARTICLE la
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = la.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
           LEFT JOIN PRODUITS p ON p.NomProduit = la.ArtCode);
    
      -- Insertion en masse dans INT_ARTICLES
      NomTable := 'INT_ARTICLES';
      INSERT INTO INT_ARTICLES
        (SELECT NVL(a.CodeInterneArticle
                   ,-1 || RowNum)
               ,ip.CodeProduit
               ,1
               , -- CodeColoris
                1
               , -- CodeGrilleTaille
                1
               , --Indice
                NVL(a.CodeBarres
                   ,'B' || RowNum)
               ,0
               , -- QteTotaleAchetee
                0
               , -- QteAcheteeReinit
                0
               , -- ValTotaleAchatHt
                0
               , -- ValAchatHtReinit
                NULL
               , -- CodeDevise
                Case
                  when la.CodeMaj = 3 then
                   9
                  when la.ArtType = 'ZCDE' then
                   97
                  when la.ArtType = 'ZPOR' then
                   98
                  when la.ArtType = 'ZILL' then
                   99
                  else
                   3
                end
               , -- CodeEtat
                Case
                  when la.CodeMaj = 3 then
                   1
                  else
                   0
                end
               , -- ArretReassort
                NVL(ip.DateCreation
                   ,TRUNC(SYSDATE))
               ,TRUNC(SYSDATE)
               , -- DateModification
                0
               , -- CodeGrilleVariante
                0
               , -- IndiceVariante
                --GD tracker 32418
                -- Modif BF du 12/04/09
                --Decode(la.ARTTYPE,'ZGER',0,'ZLOV',0,'ZCEG',0,'ZTIT',0,'ZGIM',0,'ZSER',0,1), -- GereEnStock
                --Modif ERI le 26/11/201 : Gestion unitaire GOLD
                --Decode(La.Arttype,'ZGER',0,'ZLOV',0,'ZCEG',0,'ZTIT',0,'ZGIM',0,'ZSER',0,Null,0,1), -- GereEnStock
                Decode(La.Arttype
                      ,'ZGER'
                      ,0
                      ,'ZLOV'
                      ,0
                      ,'ZCEG'
                      ,0
                      ,'ZTIT'
                      ,0
                      ,'ZGIM'
                      ,0
                      ,'ZSER'
                      ,0
                      ,'ZGEP'
                      ,0
                      ,Null
                      ,0
                      ,1)
               , -- GereEnStock
                --Modif ERI le 26/11/201 : Gestion unitaire GOLD
                0
               , -- NonRemise
                0
               , -- StkOptimalMini
                0
               , -- StkOptimalMaxi
                0
               , -- ArticleCentrale
                0
               , -- PrixRevientInd
                NULL
               , -- Pcb
                Case
                  when la.CodeMaj = 3 then
                   TRUNC(SYSDATE)
                  else
                   NULL
                end
               , -- DateSuppression
                DECODE(la.PR
                      ,'PR'
                      ,1
                      ,NULL) -- CodeNature
           FROM LBM_ARTICLE la
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = la.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = la.ArtCode
           LEFT JOIN ARTICLES a ON a.CodeProduit = ip.CodeProduit
                               and a.CodeColoris = 1
                               and a.Indice = 1
                               and a.IndiceVariante = 0);
    
      -- Traitement des nouveaux Produits (Attribution d'un nouveau CodeProduit,
      -- d'un nouveau CodeInterneArticle et d'un nouveau CodeBarres dans INT_ARTICLES et INT_PRODUITS)
      BEGIN
        FOR Ligne IN (SELECT CodeInterneArticle
                            ,CodeProduit
                            ,CodeBarres
                        FROM INT_ARTICLES
                       WHERE CodeInterneArticle < 0) LOOP
          IF Ligne.CodeProduit < 0 THEN
            LeCodeProduit := RETOURNE_CODESUIVANT('PRODUITS'
                                                 ,NULL);
            UPDATE INT_PRODUITS SET CodeProduit = LeCodeProduit WHERE CodeProduit = Ligne.CodeProduit;
          ELSE
            LeCodeProduit := Ligne.CodeProduit;
          END IF;
          LeCodeInterneArticle := RETOURNE_CODESUIVANT('ARTICLES'
                                                      ,NULL);
          LeCodeBarre          := CONSTRUIRE_CODEBARRES_ARTICLE(LeCodeProduit
                                                               ,1
                                                               ,LeCodeInterneArticle
                                                               ,1
                                                               ,1
                                                               ,0);
        
          UPDATE INT_ARTICLES
             SET CodeInterneArticle = LeCodeInterneArticle
                ,CodeProduit        = LeCodeProduit
                ,CodeBarres         = LeCodeBarre
           WHERE CodeInterneArticle = Ligne.CodeInterneArticle;
        
        END LOOP;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de l''attribution d''un nouveau CodeProduit, CodeInterneArticle, CodeBarres dans INT_PRODUITS, INT_ARTICLES.' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      -- Insertion en masse dans tables derivees de Produits : INT_PRODUITS_COLORIS
      NomTable := 'INT_PRODUITS_COLORIS';
      INSERT INTO INT_PRODUITS_COLORIS
        (SELECT CodeProduit
               ,1
               , -- CodeColoris
                NULL
               , -- LibColorisModifie
                NULL
               , -- CodeCourbeDeVie
                3
               , -- CodeEtat
                NVL(DateCreation
                   ,TRUNC(SYSDATE))
               , --DateCreation
                TRUNC(SYSDATE)
               , -- DateModification
                'PERM'
               , -- CodeSaisonGestion
                DateSuppression
               ,99
               , -- CodeCibleImplantation
                TRUNC(SYSDATE)
               , -- DateModifCibleImplantation
                TRUNC(SYSDATE)
               , -- DateDebutSaisonGestion
                TRUNC(SYSDATE)
               , -- DateImplantationPrevue
                0
               , -- AReimplanter
                NULL
               , -- CodeEtatImplantation
                NULL --CodeEtatPourPalmares
           FROM INT_PRODUITS);
    
      -- Insertion en masse dans INT_TVA_PRODUIT_PAYS
      NomTable := 'INT_TVA_PRODUIT_PAYS';
      INSERT INTO INT_TVA_PRODUIT_PAYS
        (SELECT LeCodePaysDuSite
               ,ip.CodeProduit
               ,la.CodeTva
           FROM INT_PRODUITS ip
          INNER JOIN LBM_ARTICLE la ON ip.NomProduit = la.ArtCode);
    
      -- Insertion en masse dans INT_DESCRIPTIONS_PRODUIT_WEB
      NomTable := 'INT_DESCRIPTIONS_PRODUIT_WEB';
      INSERT INTO INT_DESCRIPTIONS_PRODUIT_WEB
        (SELECT ip.CodeProduit
               ,SUBSTR(ip.CodeClassProd3
                      ,-5
                      ,5) || ' ' || REPLACE(la.ArtLib
                                           ,'|'
                                           ,' ') LibCourt
               ,NULL LibLong
               ,1 CodeLangue
           FROM INT_PRODUITS ip
          INNER JOIN LBM_ARTICLE la ON ip.NomProduit = la.ArtCode);
    
      -- Insertion en masse dans INT_STATS_PRODUIT_COLORIS
      NomTable := 'INT_STATS_PRODUIT_COLORIS';
      INSERT INTO INT_STATS_PRODUIT_COLORIS
        (SELECT CodeProduit
               ,0
               ,LAxeStatMarque
               ,NVL(c1.CodeClassProd0
                   ,i1.CodeClassProd0)
               ,TRUNC(SYSDATE)
           FROM INT_PRODUITS ip
           LEFT JOIN CLASSPROD3 c3 on c3.CodeClassProd3 = ip.CodeClassProd3
           LEFT JOIN CLASSPROD2 c2 on c2.CodeClassProd2 = c3.CodeClassProd2
           LEFT JOIN CLASSPROD1 c1 on c1.CodeClassProd1 = c2.CodeClassProd1
           LEFT JOIN INT_CLASSPROD3 i3 on i3.CodeClassProd3 = ip.CodeClassProd3
           LEFT JOIN INT_CLASSPROD2 i2 on i2.CodeClassProd2 = i3.CodeClassProd2
           LEFT JOIN INT_CLASSPROD1 i1 on i1.CodeClassProd1 = i2.CodeClassProd1);
      --Ajout ERI le 18/05/2016: Gestion des axes statistiques produits (Mantis 7562)
      -- Insertion en masse dans INT_STATS_PRODUIT_LBM
      NomTable := 'INT_STATS_PRODUIT_LBM';
      INSERT INTO INT_STATS_PRODUIT_LBM
        (SELECT ia.CODEINTERNEARTICLE
               ,lsp.CODEAXESTAT
               ,lsp.CODEELEMENTSTAT
               ,TRUNC(SYSDATE)
               ,lsp.DATEFINVALIDITE
               ,lsp.ENSEIGNE
           FROM LBM_STATS_PRODUIT lsp
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lsp.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON lsp.ARTCODE = ip.NOMPRODUIT
          INNER JOIN INT_ARTICLES ia ON ia.CODEPRODUIT = ip.CODEPRODUIT);
      -- Gestion des erreurs par defaut dans le bloc begin-end
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001
                               ,'Erreur de violation de contrainte unique lors de l''insertion en masse dans ' || NomTable || '. ' || CHR(13) || SQLERRM(SQLCODE));
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001
                               ,'Erreur lors de l''insertion en masse dans ' || NomTable || '. ' || CHR(13) || SQLERRM(SQLCODE));
    END;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration en masse des articles par LBM_ARTICLE');
  END;

  /*******************************************************************/
  /*  Procedure LBM_EAN                                              */
  /*                                                                 */
  /*  Integratrion en masse des EAN articles depuis la table LBM_EAN */
  /*                                                                 */
  /*  JSC 15/07/2008 #25887 Creation                                 */
  /*  BFU 29/01/2009 Modifications                                   */
  /*******************************************************************/

  PROCEDURE PRC_LBM_EAN IS
    LeCodeMsg LOG_TRAITEMENTS.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0002';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration en masse des articles par LBM_EAN');
    --CodeClassProd0
    INSERT INTO INT_HISTO_CB_FRN
      (SELECT 1 CodeFournisseur
             ,ia.CodeInterneArticle
             ,le.EanDateFin
             ,le.Ean
             ,NULL RefFournisseur
             ,NULL ColorisFournisseur
             ,NULL TailleFournisseur
             ,NULL VarianteFournisseur
             ,ia.DateCreation
         FROM LBM_EAN le
        INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = le.MessageId
                                     and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
        INNER JOIN INT_PRODUITS ip ON ip.NomProduit = le.ArtCode
        INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit);
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration des articles par LBM_EAN');
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      RAISE_APPLICATION_ERROR(-20001
                             ,'Erreur de violation de contrainte unique lors de l''insertion en masse dans INT_HISTO_CB_FRN.' || CHR(13) || SQLERRM(SQLCODE));
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001
                             ,'Erreur lors de l''insertion en masse dans INT_HISTO_CB_FRN.' || CHR(13) || SQLERRM(SQLCODE));
  END;

  /*******************************************************************/
  /*  Procedure LBM_Tarif                                            */
  /*                                                                 */
  /*  Integratrion en masse des tarifs                               */
  /*    depuis la table LBM_tarif                                    */
  /*                                                                 */
  /*  JSC 16/07/2008       Creation                                  */
  /*  BFU 29/01/2009 Modifications                                   */
  /*  BFU 22/06/2009 Corrections sur la creation des OP_COMM         */
  /*******************************************************************/
  PROCEDURE PRC_LBM_TARIF IS
    LeCodePaysDuSite           PAYS.CodePays%TYPE;
    LeCodeMsg                  LOG_TRAITEMENTS.CodeMsg%TYPE;
    LeCodeOpeComm              OPERATIONS_COMMERCIALES.CodeOpeComm%TYPE;
    LeNbJourDescenteTarifFutur PARAMETRES_GENERAUX_SITE.ValeurNumber%TYPE;
    NomTable                   VARCHAR2(60);
  BEGIN
    LeCodeMsg := 'BIZ-0003';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration des tarifs par LBM_Tarif');
  
    LeCodePaysDuSite           := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS');
    LeNbJourDescenteTarifFutur := PK_SITE.RETOURNEPARAMETRESITENUMBER('NBJOURDESCENTETARIFFUTUR');
  
    BEGIN
      -- Insertion en masse dans INT_TARIFS : on prend le tarif en cours et le premier tarif futur
      NomTable := 'INT_TARIFS';
      INSERT INTO INT_TARIFS
      -- Tarif en cours
        (SELECT LeCodePaysDuSite CodePays
               ,ia.CodeInterneArticle CIA
               ,1 CodeTypeTarif
               ,DECODE(lt.DateDebut
                      ,TO_DATE('31/12/1899'
                              ,'DD/MM/YYYY')
                      ,TRUNC(SYSDATE)
                      ,lt.DateDebut)
               ,DECODE(lt.DateFin
                      ,TO_DATE('31/12/9999'
                              ,'DD/MM/YYYY')
                      ,NULL
                      ,lt.DateFin)
               ,lt.Montantoutaux PvTTC
               ,NULL CodeOpecomm
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,lt.Montantoutaux PVEuro
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = lt.ArtCode
          INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit
          WHERE lt.DateDebut <= TRUNC(SYSDATE)
            and (lt.DateFin >= TRUNC(SYSDATE) or lt.DateFin is null)
            and lt.TypeCond = 'VKP0'
            and lt.PlanLib is null
         UNION ALL
         -- 1er Tarif futur
         SELECT LeCodePaysDuSite CodePays
               ,ia.CodeInterneArticle CIA
               ,1 CodeTypeTarif
               ,DECODE(lt.DateDebut
                      ,TO_DATE('31/12/1899'
                              ,'DD/MM/YYYY')
                      ,TRUNC(SYSDATE)
                      ,lt.DateDebut)
               ,DECODE(lt.DateFin
                      ,TO_DATE('31/12/9999'
                              ,'DD/MM/YYYY')
                      ,NULL
                      ,lt.DateFin)
               ,lt.Montantoutaux PvTTC
               ,NULL CodeOpecomm
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,lt.Montantoutaux PVEuro
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = lt.ArtCode
          INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit
          INNER JOIN (SELECT ArtCode
                            ,MIN(DateDebut) as MinDebut
                        FROM LBM_TARIF lt
                       INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                                    and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
                       WHERE DateDebut > TRUNC(SYSDATE)
                         and lt.TypeCond = 'VKP0'
                         and lt.PlanLib is null
                       GROUP BY ArtCode) x ON x.ArtCode = lt.ArtCode
                                          and x.MinDebut = lt.DateDebut
          WHERE DateDebut > TRUNC(SYSDATE)
            and lt.TypeCond = 'VKP0'
            and lt.PlanLib is null);
    
      -- Ajout dans INT_TARIF du prix solde en cours si aucun tarif de base
      -- (pour traitement des promo remise qui necessitent un prix de reference dans la table Article de Winstore)
      INSERT INTO INT_TARIFS
      -- Tarif en cours
        (SELECT LeCodePaysDuSite CodePays
               ,ia.CodeInterneArticle CIA
               ,1 CodeTypeTarif
               ,DECODE(lt.DateDebut
                      ,TO_DATE('31/12/1899'
                              ,'DD/MM/YYYY')
                      ,TRUNC(SYSDATE)
                      ,lt.DateDebut)
               ,DECODE(lt.DateFin
                      ,TO_DATE('31/12/9999'
                              ,'DD/MM/YYYY')
                      ,NULL
                      ,lt.DateFin)
               ,lt.Montantoutaux PvTTC
               ,NULL CodeOpecomm
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,lt.Montantoutaux PVEuro
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = lt.ArtCode
          INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit
         -- Semi jointure avec les tarifs de base actifs (ie sans planlib)
           LEFT JOIN LBM_TARIF lta ON lta.ArtCode = lt.ArtCode
                                  and lta.PlanLib is null
                                  and lta.DateDebut <= TRUNC(SYSDATE)
                                  and (lta.DateFin >= TRUNC(SYSDATE) or lta.DateFin is null)
          WHERE lt.DateDebut <= TRUNC(SYSDATE)
            and (lt.DateFin >= TRUNC(SYSDATE) or lt.DateFin is null)
            and lt.TypeCond = 'VKP0'
            and lt.PlanLib is NOT null
            and
               -- On elimine ceux qui ont deja un tarif de base actif
                lta.ArtCode is null);
    
      -- Insertion en masse dans INT_TARIFS_FUTURS : on prend les tarifs futurs sauf le premier
      NomTable := 'INT_TARIFS_FUTURS';
      INSERT INTO INT_TARIFS_FUTURS
        (SELECT DECODE(LeNbJourDescenteTarifFutur
                      ,0
                      ,TRUNC(SYSDATE)
                      ,TRUNC(lt.DateDebut) - LeNbJourDescenteTarifFutur) DateEnvoi
               ,LeCodePaysDuSite CodePays
               ,4 CodeGroupeMagasin
               ,ia.CodeInterneArticle CIA
               ,1 CodeTypeTarif
               ,DECODE(lt.DateDebut
                      ,TO_DATE('31/12/1899'
                              ,'DD/MM/YYYY')
                      ,TRUNC(SYSDATE)
                      ,lt.DateDebut)
               ,DECODE(lt.DateFin
                      ,TO_DATE('31/12/9999'
                              ,'DD/MM/YYYY')
                      ,NULL
                      ,lt.DateFin)
               ,lt.Montantoutaux PvTTC
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,lt.Montantoutaux PVEuro
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = lt.ArtCode
          INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit
           LEFT JOIN (SELECT ArtCode
                           ,MIN(DateDebut) as MinDebut
                       FROM LBM_TARIF lt
                      INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                                   and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
                      WHERE DateDebut > TRUNC(SYSDATE)
                        and lt.TypeCond = 'VKP0'
                        and lt.PlanLib is null
                      GROUP BY ArtCode) x ON x.ArtCode = lt.ArtCode
                                         and x.MinDebut = lt.DateDebut
          WHERE DateDebut > TRUNC(SYSDATE)
            and lt.TypeCond = 'VKP0'
            and lt.PlanLib is null
            and x.MinDebut is null);
    
      -- Insertion en masse dans INT_OPERATIONS_COMMERCIALES
      -- Attention : + opcom peuvent convenir car si l'opcom des deja commence, SAP renvoie comme date de debut la date du jour
      --             dans ces cas de figure, la premiere opcom convient...
      NomTable := 'INT_OPERATIONS_COMMERCIALES';
      INSERT INTO INT_OPERATIONS_COMMERCIALES
        (SELECT DISTINCT NVL(oc.CodeOpeComm
                            ,-1)
                        ,lt.PlanLib
                        ,LeCodePaysDuSite
                        ,4 CodeEtatOpeComm
                        ,CASE
                           WHEN lt.TypeCond = 'VKP0' THEN
                            4
                           ELSE
                            3
                         END CodeTypeTarif
                        ,1 NiveauOpeComm
                        ,NVL(oc.DateDebut
                            ,lt.DateDebut)
                        ,NVL(TRUNC(lt.DateFin)
                            ,TO_DATE('31/12/2098'
                                    ,'DD/MM/YYYY'))
                        ,NULL DateFinPreparation
                        ,TRUNC(SYSDATE) DateEnvoiMag
                        ,NULL Observations
                        ,TRUNC(SYSDATE) DateCreation
                        ,TRUNC(SYSDATE) DateModification
                        ,
                         -- On donne la priorite a la promo remise
                         DECODE(NVL(x.TypeCond
                                   ,lt.TypeCond)
                               ,'VKP0'
                               ,1
                               ,'VKA0'
                               ,1
                               ,'KA02'
                               ,2
                               ,'ZA02'
                               ,2
                               ,0) CodeTypeOpeComm
                        ,0 NumPoste
                        ,NULL CodeRegleConversion
                        ,NULL CodeOpeCommPrincipal
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
         -- Semi jointure pour voir si c'est une promo remise
           LEFT JOIN LBM_TARIF x ON x.ArtCode = lt.ArtCode
                                and x.PlanLib = lt.Planlib
                                and x.DateDebut = lt.DateDebut
                                and x.DateFin = lt.DateFin
                                and x.TypeCond in ('KA02', 'ZA02')
                                and NVL(x.DateFin
                                       ,TO_DATE('31/12/2098'
                                               ,'DD/MM/YYYY')) = NVL(lt.DateFin
                                                                    ,TO_DATE('31/12/2098'
                                                                            ,'DD/MM/YYYY'))
                                and x.TypeCond in ('KA02', 'ZA02')
           LEFT JOIN OPERATIONS_COMMERCIALES oc ON oc.LibOpeComm = lt.Planlib
                                               and CASE WHEN lt.DateFin = TO_DATE('31/12/9999'
                                                                       ,'DD/MM/YYYY')
                                                or lt.DateFin is NULL THEN TO_DATE('31/12/2098', 'DD/MM/YYYY') ELSE lt.DateFin END = oc.DateFin and CASE WHEN oc.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE oc.DateDebut END = CASE WHEN lt.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE lt.DateDebut END and oc.CodeTypeTarif = CASE WHEN lt.TypeCond = 'VKP0' THEN 4 ELSE 3 END and oc.CodeTypeOpeComm = DECODE(NVL(x.TypeCond, lt.TypeCond), 'VKP0', 1, 'VKA0', 1, 'KA02', 2, 'ZA02', 2, 0)
          WHERE lt.PlanLib is not null
            and lt.TypeCond in ('VKP0', 'VKA0')
            and (lt.DateFin >= TRUNC(SYSDATE) or lt.DateFin is null));
    
      UPDATE INT_OPERATIONS_COMMERCIALES ioc SET ioc.CODEOPECOMM = ioc.CODEOPECOMM * RowNum WHERE CODEOPECOMM < 0;
    
      -- Attribution d'un nouveau code OPCom
      BEGIN
        FOR Ligne IN (SELECT CodeOpeComm FROM INT_OPERATIONS_COMMERCIALES WHERE CodeOpeComm < 0) LOOP
          LeCodeOpeComm := Retourne_CodeSuivant('OPERATIONS_COMMERCIALES'
                                               ,'CODEOPECOM');
          UPDATE INT_OPERATIONS_COMMERCIALES SET CodeOpeComm = LeCodeOpeComm WHERE CodeOpeComm = Ligne.CodeOpeComm;
        END LOOP;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de l''attribution d''un nouveau CodeOpeComm dans INT_OPERATIONS_COMMERCIALES.' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      -- Insertion en masse dans INT_DATES_OPE_COMM
      NomTable := 'INT_DATES_OPE_COMM';
      INSERT INTO INT_DATES_OPE_COMM
        (SELECT CodeOpeComm
               ,LeCodePaysDuSite
               ,4
               ,DateDebut
               ,DateFin
               ,TRUNC(SYSDATE)
               ,4
               ,NULL
               ,TRUNC(SYSDATE)
               ,TRUNC(SYSDATE)
           FROM INT_OPERATIONS_COMMERCIALES);
    
      -- Insertion en masse dans INT_TARIFS_GROUPE_MAGASIN
      -- Attention : + opcom peuvent convenir car si l'opcom des deja commence, SAP renvoie comme date de debut la date du jour
      --             dans ces cas de figure, la premiere opcom convient...
      NomTable := 'INT_TARIFS_GROUPE_MAGASIN';
      INSERT INTO INT_TARIFS_GROUPE_MAGASIN
        (SELECT 4 CodeGroupeMagasin
               ,ia.CodeInterneArticle CIA
               ,lt.DateDebut
               ,CASE
                  WHEN lt.DateFin = TO_DATE('31/12/9999'
                                           ,'DD/MM/YYYY')
                       or lt.DateFin is NULL THEN
                   TO_DATE('31/12/2098'
                          ,'DD/MM/YYYY')
                  ELSE
                   lt.datefin
                END DateFin
               ,CASE
                  WHEN lt.TypeCond = 'VKP0' THEN
                   4
                  ELSE
                   3
                END CodeTypeTarif
               ,lt.Montantoutaux PvTtc
               ,min(ioc.CodeOpeComm)
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,lt.Montantoutaux PvEuro
               ,NULL TransfertVersMagasin
               ,x.Montantoutaux TauxRemise
           FROM LBM_TARIF lt
          INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lt.MessageId
                                       and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip ON ip.NomProduit = lt.ArtCode
          INNER JOIN INT_ARTICLES ia ON ia.CodeProduit = ip.CodeProduit
         -- Semi jointure pour voir si c'est une promo remise
           LEFT JOIN LBM_TARIF x ON x.ArtCode = lt.ArtCode
                                and x.PlanLib = lt.Planlib
                                and x.DateDebut = lt.DateDebut
                                and NVL(x.DateFin
                                       ,TO_DATE('31/12/2098'
                                               ,'DD/MM/YYYY')) = NVL(lt.DateFin
                                                                    ,TO_DATE('31/12/2098'
                                                                            ,'DD/MM/YYYY'))
                                and x.TypeCond in ('KA02', 'ZA02')
         -- semi jointure car les conditions dependent de la semi jointure pour promo remise
           LEFT JOIN INT_OPERATIONS_COMMERCIALES ioc ON ioc.LibOpeComm = lt.Planlib
                                                    and CASE WHEN lt.DateFin = TO_DATE('31/12/9999'
                                                                            ,'DD/MM/YYYY')
                                                     or lt.DateFin is NULL THEN TO_DATE('31/12/2098', 'DD/MM/YYYY') ELSE lt.DateFin END = ioc.DateFin and CASE WHEN ioc.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE ioc.DateDebut END = CASE WHEN lt.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE lt.DateDebut END and ioc.CodeTypeTarif = CASE WHEN lt.TypeCond = 'VKP0' THEN 4 ELSE 3 END and ioc.CodeTypeOpeComm = DECODE(NVL(x.TypeCond, lt.TypeCond), 'VKP0', 1, 'VKA0', 1, 'KA02', 2, 'ZA02', 2, 0)
          WHERE lt.PlanLib is not null
            and lt.TypeCond in ('VKP0', 'VKA0')
            and (lt.DateFin >= TRUNC(SYSDATE) or lt.DateFin is null)
          GROUP BY ia.CodeInterneArticle
                  ,lt.DateDebut
                  ,lt.DateFin
                  ,lt.TypeCond
                  ,lt.Montantoutaux
                  ,x.Montantoutaux
         --Ajout ERI le 02/05/2017: Gestion tarif GEP Rive droite
         UNION ALL
         SELECT ltg.CodeGroupeMagasin CodeGroupeMagasin
               ,ia2.CodeInterneArticle CIA
               ,ltg.DateDebut
               ,CASE
                  WHEN ltg.DateFin = TO_DATE('31/12/9999'
                                            ,'DD/MM/YYYY')
                       or ltg.DateFin is NULL THEN
                   TO_DATE('31/12/2098'
                          ,'DD/MM/YYYY')
                  ELSE
                   ltg.datefin
                END DateFin
               ,CASE
                  WHEN ltg.TypeCond = 'VKP0' THEN
                   1
                  ELSE
                   3
                END CodeTypeTarif
               ,ltg.Montantoutaux PvTtc
               ,min(ioc2.CodeOpeComm)
               ,TRUNC(SYSDATE) DateCreation
               ,TRUNC(SYSDATE) DateModification
               ,ltg.Montantoutaux PvEuro
               ,NULL TransfertVersMagasin
               ,NULL TauxRemise
           FROM LBM_TARIF_GROUPE_MAGASIN ltg
          INNER JOIN LBM_MESSAGE_ID lmi2 ON lmi2.Id_Message = ltg.MessageId
                                        and lmi2.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
          INNER JOIN INT_PRODUITS ip2 ON ip2.NomProduit = ltg.ArtCode
          INNER JOIN INT_ARTICLES ia2 ON ia2.CodeProduit = ip2.CodeProduit
           LEFT JOIN INT_OPERATIONS_COMMERCIALES ioc2 ON ioc2.LibOpeComm = ltg.Planlib
                                                     and CASE WHEN ltg.DateFin = TO_DATE('31/12/9999'
                                                                              ,'DD/MM/YYYY')
                                                      or ltg.DateFin is NULL THEN TO_DATE('31/12/2098', 'DD/MM/YYYY') ELSE ltg.DateFin END = ioc2.DateFin and CASE WHEN ioc2.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE ioc2.DateDebut END = CASE WHEN ltg.DateDebut < TRUNC(SYSDATE) THEN TRUNC(SYSDATE) ELSE ltg.DateDebut END and ioc2.CodeTypeTarif = CASE WHEN ltg.TypeCond = 'VKP0' THEN 1 ELSE 3 END and ioc2.CodeTypeOpeComm = DECODE(ltg.TypeCond, 'VKP0', 1, 'VKA0', 1, 0)
          GROUP BY ltg.CodeGroupeMagasin
                  ,ia2.CodeInterneArticle
                  ,ltg.DateDebut
                  ,ltg.DateFin
                  ,ltg.TypeCond
                  ,ltg.Montantoutaux
         --Fin Ajout ERI le 02/05/2017
         );
      -- Gestion des erreurs par defaut dans le bloc begin-end
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20001
                               ,'Erreur de violation de contrainte unique lors de l''insertion en masse dans ' || NomTable || '. ' || CHR(13) || SQLERRM(SQLCODE));
      WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20001
                               ,'Erreur lors de l''insertion en masse dans ' || NomTable || '. ' || CHR(13) || SQLERRM(SQLCODE));
    END;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration en masse des articles par LBM_TARIF');
  
  EXCEPTION
    WHEN OTHERS THEN
      RAISE_APPLICATION_ERROR(-20001
                             ,'Erreur dans la procedure LBM_TARIF ' || CHR(13) || SQLERRM(SQLCODE));
  END;

  /*******************************************************************************
  * Procedure LBM_CLIENT                                                         *
  *                                                                              *
  * Integration en masse des clients dans les tables INT  depuis les tables LBM  *
  * Tables LBM: - LBM_CLIENT                                                     *
  *             - LBM_GPE_MAGASIN                                                *
  *             - LBM_STATS                                                      *
  *                                                                              *
  * Tables INT : - LBM_INT_CLIENTS                                               *
  *              - LBM_INT_ADRESSES_CLIENT                                       *
  *              - LBM_INT_CLIENTS_GPE_MAGASIN                                   *
  *              - LBM_INT_CARTE_FIDELITE_CLIENT                                 *
  *              - LBM_INT_STATS_CLIENT                                          *
  *                                                                              *
  * ERI "saisir date mise en prod" Creation                                      *
  *                                                                              *
  ********************************************************************************/
  PROCEDURE PRC_LBM_CLIENT IS
    LeCodeMsg LOG_TRAITEMENTS.CodeMsg%TYPE;
    TYPE TTabLock IS TABLE OF VARCHAR2(20) INDEX BY BINARY_INTEGER;
    TabLock  TTabLock;
    nomtable VARCHAR2(60);
  
  BEGIN
  
    LeCodeMsg := 'BIZ-0014';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration en masse des clients dans table LBM_INT');
  
    ---------------------------------------------------------------------------------------------------------------------------------------------------
    -- poser un verrou Oracle sur les clients a traiter (select for update) pour eviter les mises a jour de Biztalk en cours de traitement des clients.
    ---------------------------------------------------------------------------------------------------------------------------------------------------
  
    SELECT lcli.numid BULK COLLECT
      INTO TabLock
      FROM LBM_CLIENTS lcli
     INNER JOIN LBM_MESSAGE_ID lmi ON lmi.Id_Message = lcli.MessageId
                                  and lmi.ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       FOR UPDATE;
  
    ----------------------------------------------
    --Insertion masse dans table LBM_INT_CLIENTS
    ----------------------------------------------
    nomtable := 'LBM_INT_CLIENTS';
    /*
    INSERT INTO lbm_int_clients
    -- Ajout ERI le 26/11/2013: gestion d'un meme client provenant d'application source differente
    --                          a supprimer lorsque tous les demi-flux clients seront seront repris dans l'application BIZTALK LBM.BTS.RCU
    
    SELECT CODEMAGASIN,
    CODEMAGASINCOURANT,
    CODECLIENT,
    NOM,
    NOMJEUNEFILLE,
    PRENOM,
    --Ajout ERI le 05/09/2013
    CODELANGUE,
    --Fin ajout ERI le 05/09/2013
    TELEPHONE,
    NOTELMOBILE,
    NOFAX,
    CODETITRECLIENT,
    JOURNAISSANCE,
    MOISNAISSANCE,
    ANNEENAISSANCE,
    DATEDERNIERANNIVSOUHAITE,
    CLIENTREEL,
    DATECREATION,
    DATEMODIFICATION,
    DATEMODIFICATIONSTATSCLIENT,
    DATESUPPRESSION,
    DATEDERNIERACHAT,
    EMAIL,
    --Ajout ERI le 05/09/2013
    NBECHECEMAIL,
    --Fin ajout ERI le 05/09/2013
    CODESECRET,
    DATECREATIONCARTE,
    DATEEXPIRATIONCARTE,
    DATERENOUVELLEMENT,
    MATCHCODENOM,
    MATCHCODENOMJEUNEFILLE,
    MATCHCODEPRENOM,
    CANALENTREE,
    CODEPARRAIN,
    CODEADRESSECLIENT,
    CODEREGROUPEMENTCLIENT,
    CODETYPECLIENT,
    CODETYPEVALIDITECARTE,
    CODETYPENONRENOUVELLEMENT,
    CNIL,
    PIEGE,
    --Ajout ERI le 05/09/2013
    NBECHECSMS,
    IDENTIFICATIONDEMANDEE,
    --Fin ajout ERI le 05/09/2013
    CODECLIENTEXTERNE,
    CLIENTCOMPTE,
    NBECHECFIXE,
    DATEDERNMODIFMAIL,
    DATEDERNMODIFFIXE,
    DATEDERNMODIFPORT,
    DATEDERNMODIFCNIL,
    BLOCAGEIDENTCLI,
    NUMID,
    CODEMAJ
    
    FROM
    (
    
    SELECT NVL (lcli.codemagasin, '999') codemagasin,                --CODEMAGASIN
    NVL (lcli.codemagasin, '999') codemagasincourant,  --CODEMAGASINCOURANT
    lbm_retourne_codeclient (lcli.numid,
    lcli.typerecherche,
    lcli.applisource
    ) codeclient,                      --CODECLIENT
    SUBSTR (lcli.nom, 1, 25) nom,                                     --NOM
    SUBSTR (lcli.nom2, 1, 25) nomjeunefille,
    --NOMJEUNEFILLE
    SUBSTR (lcli.prenom, 1, 20) prenom,                            --PRENOM
    --Ajout ERI le 05/09/2013
    lcli.codelangue codelangue,                                --CODELANGUE
    --Fin ajout ERI le 05/09/2013
    lcli.telephone telephone,                                   --TELEPHONE
    lcli.telmobile notelmobile,                               --NOTELMOBILE
    lcli.recruteur nofax,                                           --NOFAX
    lcli.civilite codetitreclient,                        --CODETITRECLIENT
    SUBSTR (TO_CHAR (lcli.datenaissance, 'DD/MM/YYYY'), 1,
    2) journaissance,                               --JOURNAISSANCE
    SUBSTR (TO_CHAR (lcli.datenaissance, 'DD/MM/YYYY'), 4,
    2) moisnaissance,                               --MOISNAISSANCE
    SUBSTR (TO_CHAR (lcli.datenaissance, 'DD/MM/YYYY'),
    7,
    4
    ) anneenaissance,                               --ANNEENAISSANCE
    NULL datedernierannivsouhaite,               --DATEDERNIERANNIVSOUHAITE
    NULL clientreel,                                           --CLIENTREEL
    lcli.datecreation datecreation,
    --TO_DATE (lcli.datecreation, 'dd/mm/yyyy'),                   --DATECREATION
    SYSDATE datemodification,                            --DATEMODIFICATION
    CASE lcli.codemajstat
    WHEN 1
    THEN SYSDATE
    --TO_DATE (SYSDATE, 'dd/mm/yyyy HH24:mi:ss')
    ELSE NULL
    END datemodificationstatsclient,          --DATEMODIFICATIONSTATSCLIENT
    --lcli.datesuppression,
    CASE
    WHEN lcli.datesuppression <= TRUNC (SYSDATE)
    THEN lcli.datesuppression
    ELSE NULL
    END datesuppression,                                  --DATESUPPRESSION
    NULL datedernierachat,                               --DATEDERNIERACHAT
    lcli.email email,                                               --EMAIL
    --Ajout ERI le 05/09/2013
    lcli.nbechecemail nbechecemail,                          --NBECHECEMAIL
    --Fin ajout ERI le 05/09/2013
    NULL codesecret,                                           --CODESECRET
    lcli.datecreacarte datecreationcarte,               --DATECREATIONCARTE
    CASE
    WHEN lcli.codemajcarte = 1
    AND lcli.datesuppression > TRUNC (SYSDATE)
    THEN lcli.datesuppression
    --          WHEN  lcli.codemajcarte = 1 AND lcli.datesuppression IS NULL
    --            THEN TO_DATE('31/12/2099', 'DD/MM/YYYY')
    ELSE TO_DATE ('31/12/2099', 'DD/MM/YYYY')                        --NULL
    END dateexpirationcarte,                          --DATEEXPIRATIONCARTE
    NULL daterenouvellement,                           --DATERENOUVELLEMENT
    pk_biblio.retournematchcode (lcli.nom) matchcodenom,     --MATCHCODENOM
    NULL matchcodenomjeunefille,                   --MATCHCODENOMJEUNEFILLE
    pk_biblio.retournematchcode (lcli.prenom) matchcodeprenom,
    --MATCHCODEPRENOM
    NULL canalentree,                                         --CANALENTREE
    NULL codeparrain,                                         --CODEPARRAIN
    lbm_retourne_codeadresse (lcli.numid,
    lcli.typerecherche,
    lcli.applisource
    ) codeadresseclient,       --CODEADRESSECLIENT
    NULL coderegroupementclient,                   --CODEREGROUPEMENTCLIENT
    NULL codetypeclient,                                   --CODETYPECLIENT
    
    --       CASE
    --          WHEN lcli.codecarte IS NOT NULL
    --             THEN 'VAL'
    --          ELSE 'NCA'
    --       END CODETYPEVALIDITECARTE,
    --
    CASE
    WHEN lcli.datesuppcarte <= TRUNC (SYSDATE) OR lcli.codecarte IS NULL
    THEN 'NCA'
    ELSE 'VAL'
    END CODETYPEVALIDITECARTE,                      --CODETYPEVALIDITECARTE
    NULL codetypenonrenouvellement,             --CODETYPENONRENOUVELLEMENT
    NULL cnil,                                                       --CNIL
    NULL piege,                                                     --PIEGE
    --Ajout ERI le 05/09/2013
    lcli.nbechecsms nbechecsms,                                --NBECHECSMS
    lcli.identificationdemandee identificationdemandee,
    --IDENTIFICATIONDEMANDEE
    
    --Fin ajout ERI le 05/09/2013
    lcli.codeclientexterne codeclientexterne,           --CODECLIENTEXTERNE
    lcli.clientcompte clientcompte,                          --CLIENTCOMPTE
    NULL nbechecfixe,                                         --NBECHECFIXE
    NULL datedernmodifmail,                             --DATEDERNMODIFMAIL
    NULL datedernmodiffixe,                             --DATEDERNMODIFFIXE
    NULL datedernmodifport,                             --DATEDERNMODIFPORT
    NULL datedernmodifcnil,                             --DATEDERNMODIFCNIL
    lcli.blocageidentcli blocageidentcli,                 --BLOCAGEIDENTCLI
    lcli.numid numid,                                               --NUMID
    lcli.codemajclient codemaj,                  --CODEMAJ
    ROW_NUMBER () OVER (PARTITION BY lbm_retourne_codeclient
    (lcli.numid,
    lcli.typerecherche,
    lcli.applisource
    ) ORDER BY applisource)
    rang
    FROM lbm_clients lcli INNER JOIN lbm_message_id lmi
    ON lcli.messageid = lmi.id_message
    AND lmi.id_batch_stl = lecodetraitementbiztalknegatif
    
    ) T0
    WHERE T0.rang = 1 ;
    --Fin ajout ERI le 26/11/2013
    
    */
  
    --Modif ERI le 26/11/2013: A dcommenter lorsque tous les demi-flux clients seront seront repris dans l'application BIZTALK LBM.BTS.RCU
  
    INSERT INTO lbm_int_clients
      SELECT NVL(lcli.codemagasin
                ,'999')
            , --CODEMAGASIN
             NVL(lcli.codemagasin
                ,'999')
            , --CODEMAGASINCOURANT
             lbm_retourne_codeclient(lcli.numid
                                    ,lcli.typerecherche
                                    ,lcli.applisource)
            , --CODECLIENT
             SUBSTR(lcli.nom
                   ,1
                   ,25)
            , --NOM
             SUBSTR(lcli.nom2
                   ,1
                   ,25)
            , --NOMJEUNEFILLE
             SUBSTR(lcli.prenom
                   ,1
                   ,20)
            , --PRENOM
             --Ajout ERI le 05/09/2013
             lcli.CODELANGUE
            , --CODELANGUE
             --Fin ajout ERI le 05/09/2013
             lcli.telephone
            , --TELEPHONE
             lcli.telmobile
            , --NOTELMOBILE
             lcli.recruteur
            , --NOFAX
             lcli.civilite
            , --CODETITRECLIENT
             SUBSTR(TO_CHAR(lcli.datenaissance
                           ,'DD/MM/YYYY')
                   ,1
                   ,2)
            , --JOURNAISSANCE
             SUBSTR(TO_CHAR(lcli.datenaissance
                           ,'DD/MM/YYYY')
                   ,4
                   ,2)
            , --MOISNAISSANCE
             SUBSTR(TO_CHAR(lcli.datenaissance
                           ,'DD/MM/YYYY')
                   ,7
                   ,4)
            , --ANNEENAISSANCE
             NULL
            , --DATEDERNIERANNIVSOUHAITE
             NULL
            , --CLIENTREEL
             lcli.datecreation
            , --TO_DATE (lcli.datecreation, 'dd/mm/yyyy'),                   --DATECREATION
             SYSDATE
            , --DATEMODIFICATION
             CASE lcli.codemajstat
               WHEN 1 THEN
                SYSDATE --TO_DATE (SYSDATE, 'dd/mm/yyyy HH24:mi:ss')
               ELSE
                NULL
             END
            , --DATEMODIFICATIONSTATSCLIENT
             --lcli.datesuppression,
             --Modif ERI la 17/04/2014: on ne supprime pas les clients car risque de perte de donnees pour les commande clients
             NULL
            , --DATESUPPRESSION
             /*
                          CASE WHEN lcli.datesuppression <= TRUNC(sysdate) THEN lcli.datesuppression
                          ELSE NULL
                          END,
                          */
             --Fin  Modif ERI la 17/04/2014
             NULL
            , --DATEDERNIERACHAT
             lcli.email
            , --EMAIL
             --Ajout ERI le 05/09/2013
             lcli.NBECHECEMAIL
            , --NBECHECEMAIL
             --Fin ajout ERI le 05/09/2013
             NULL
            , --CODESECRET
             lcli.datecreacarte
            , --DATECREATIONCARTE
             CASE
               WHEN lcli.codemajcarte = 1
                    AND lcli.datesuppression > TRUNC(sysdate) THEN
                lcli.datesuppression
             --WHEN  lcli.codemajcarte = 1 AND lcli.datesuppression IS NULL
             --THEN TO_DATE('31/12/2099', 'DD/MM/YYYY')
               ELSE
                TO_DATE('31/12/2099'
                       ,'DD/MM/YYYY') --NULL
             END
            , --DATEEXPIRATIONCARTE
             NULL
            , --DATERENOUVELLEMENT
             pk_biblio.retournematchcode(lcli.nom)
            , --MATCHCODENOM
             NULL
            , --MATCHCODENOMJEUNEFILLE
             pk_biblio.retournematchcode(lcli.prenom)
            , --MATCHCODEPRENOM
             NULL
            , --CANALENTREE
             NULL
            , --CODEPARRAIN
             lbm_retourne_codeadresse(lcli.numid
                                     ,lcli.typerecherche
                                     ,lcli.applisource)
            , --CODEADRESSECLIENT
             NULL
            , --CODEREGROUPEMENTCLIENT
             NULL
            , --CODETYPECLIENT
             --Modif ERI le 17/04/2014 : gestion de la desactivation d'une carte
             CASE
               WHEN lcli.codecarte IS NOT NULL
                    AND (lcli.DATESUPPCARTE > TRUNC(sysdate) OR lcli.DATESUPPCARTE IS NULL) THEN
                'VAL'
               WHEN lcli.codecarte IS NOT NULL
                    AND lcli.DATESUPPCARTE <= TRUNC(sysdate) THEN
                'NCA'
               ELSE
                'NCA'
             END
            ,
             /*
                          CASE
                          WHEN lcli.codecarte IS NOT NULL
                          THEN 'VAL'
                          ELSE 'NCA'
                          END,
                          */ --CODETYPEVALIDITECARTE
             --Fin Modif ERI le 17/04/2014:
             NULL
            , --CODETYPENONRENOUVELLEMENT
             NULL
            , --CNIL
             NULL
            , --PIEGE
             --Ajout ERI le 05/09/2013
             lcli.NBECHECSMS
            , --NBECHECSMS
             lcli.IDENTIFICATIONDEMANDEE
            , --IDENTIFICATIONDEMANDEE
             --Fin ajout ERI le 05/09/2013
             lcli.codeclientexterne
            , --CODECLIENTEXTERNE
             lcli.clientcompte
            , --CLIENTCOMPTE
             NULL
            , --NBECHECFIXE
             NULL
            , --DATEDERNMODIFMAIL
             NULL
            , --DATEDERNMODIFFIXE
             NULL
            , --DATEDERNMODIFPORT
             NULL
            , --DATEDERNMODIFCNIL
             lcli.blocageidentcli
            , --BLOCAGEIDENTCLI
             lcli.numid
            , --NUMID
             lcli.codemajclient --CODEMAJ
        FROM lbm_clients lcli
       INNER JOIN lbm_message_id lmi ON lcli.messageid = lmi.id_message
                                    and lmi.id_batch_stl = LeCodeTraitementBizTalkNegatif;
  
    --Fin modif ERI le 26/11/2013
    -------------------------------------------------------
    --Insertion masse dans table LBM_INT_ADRESSES_CLIENT
    -------------------------------------------------------
    nomtable := 'LBM_INT_ADRESSES_CLIENT';
  
    INSERT INTO lbm_int_adresses_client
      SELECT icli.codeadresseclient
            , --CODEADRESSECLIENT
             SUBSTR(lcli.adresse1
                   ,1
                   ,38)
            , --COMPLEMENTNOM
             SUBSTR(lcli.adresse2
                   ,1
                   ,38)
            , --COMPLEMENTADRESSE
             NULL
            , --NUMEROVOIE
             NULL
            , --BISTER
             NULL
            , --CODETYPEVOIE
             SUBSTR(lcli.adresse3
                   ,1
                   ,40)
            , --LIBELLEVOIE
             SUBSTR(lcli.adresse4
                   ,1
                   ,38)
            , --LIEUDIT
             SUBSTR(lcli.codepostal
                   ,1
                   ,10)
            , --CODEPOSTAL
             SUBSTR(lcli.ville
                   ,1
                   ,30)
            , --VILLE
             lcli.codepays
            , --CODEPAYS
             NULL
            , --MATCHCODELIBELLEVOIE
             NULL
            , --INSEE
             --Ajout ERI le 05/09/2013
             lcli.QTENPAI
            , --QTENPAI
             --Fin ajout ERI le 05/09/2013
             NULL
            , --QTEPSA
             NULL
            , --CODEQUALITEADRESSE
             lcli.datecreation
            , --DATECREATION
             --lcli.datesuppression,
             CASE
               WHEN lcli.datesuppression <= TRUNC(sysdate) THEN
                lcli.datesuppression
               ELSE
                NULL
             END
            , --DATESUPPRESSION
             SYSDATE
            , --DATEMODIFICATION
             NULL
            , --COMPLEMENTBATIMENT
             NULL --OBSERVATIONSADRESSE
        FROM lbm_clients lcli
       INNER JOIN lbm_message_id lmi ON lcli.messageid = lmi.id_message
                                    and lmi.id_batch_stl = LeCodeTraitementBizTalkNegatif
       INNER JOIN lbm_int_clients icli ON lcli.numid = icli.numid
       WHERE lcli.codemajadresse = 1;
  
    ---------------------------------------------------------
    --Insertion masse dans table LBM_INT_CLIENTS_GPE_MAGASIN
    ----------------------------------------------------------
    nomtable := 'LBM_INT_CLIENTS_GPE_MAGASIN';
  
    INSERT INTO lbm_int_clients_gpe_magasin
      SELECT icli.codeclient
            , --CODECLIENT
             lmag.enseigne
            , --CODEGROUPEMAGASIN
             --Modif ERI la 02/02/2015: on ne supprime pas les clients car risque de perte de donnees pour les commande clients
             --             CASE
             --                WHEN NVL (lmag.datesuppression, icli.datesuppression) <= TRUNC(sysdate)-- IS NOT NULL
             --                   THEN '0'
             --                ELSE '1'
             --             END,
             1
            , --STATUS
             --             CASE
             --                WHEN NVL (lmag.datesuppression, icli.datesuppression) <= TRUNC(sysdate)
             --                    THEN NVL (lmag.datesuppression, icli.datesuppression)
             --                ELSE NULL
             --             END
             NULL --DATESUPPRESSION
      --Modif ERI la 02/02/2015
        FROM lbm_gpe_magasin lmag
       INNER JOIN lbm_message_id lmi ON lmag.messageid = lmi.id_message
                                    and lmi.id_batch_stl = LeCodeTraitementBizTalkNegatif
       INNER JOIN lbm_clients lcli ON lmag.numid = lcli.numid
       INNER JOIN lbm_int_clients icli ON icli.numid = lmag.numid
       WHERE lcli.codemajgrpmag = 1;
  
    ------------------------------------------------------------
    --Insertion masse dans table LBM_INT_CARTE_FIDELITE_CLIENT
    ------------------------------------------------------------
  
    -- 1ere etape: On insert toutes les cartes pour lesquelles on autorise une MAJ
    -- Modif ERI le 10/01/2014 : Gestion mutli carte actives
    nomtable := 'LBM_INT_CARTE_FIDELITE_CLIENT';
  
    INSERT INTO lbm_int_carte_fidelite_client
      SELECT lcar.numcarte
            , --CODECARTEFIDELITECLIENT
             lcar.typecarte
            , --CODETYPECARTEFIDELITECLIENT
             lcar.datecreation
            , --DATECREATION
             lcar.datecreation
            , --DATEATTRIBUTION
             --Modif ERI le 15/06/2017 : Mantis 7593
             CASE
               WHEN lcar.statut = 'AFF' THEN
                lcar.datecreation
               ELSE
                lcar.datefinvalidite
             END
            , --DATESUPPRESSION
             /*
                          CASE
                          WHEN --Modif ERI le 16/04/2014
                          lcar.statut = 'CHG'
                          --lcar.statut = 'AFF'
                          --Fin Modif ERI le 16/04/2014
                          THEN lcar.datecreation
                          ELSE lcar.datefinvalidite
                          END,
                          */
             --Fin Modif ERI le 15/06/2017 : Mantis 7593
             icli.codeclient
            , --CODECLIENT
             --Modif ERI le 15/06/2017 : Mantis 7593
             CASE
               WHEN lcar.statut = 'AFF' THEN
                'TMP'
               WHEN lcar.statut IN ('CHG', 'ACT') THEN
                'AFF'
               ELSE
                'PER'
             END
            , --CODEETATCARTEFIDELITECLIENT
             /*
                          CASE
                          WHEN --Modif ERI le 16/04/2014
                          lcar.statut = 'CHG'
                          --lcar.statut = 'AFF'
                          --Fin Modif ERI le 16/04/2014
                          THEN 'TMP'
                          --Ajout ERI le 16/06/2014
                          WHEN lcar.statut = 'AFF' THEN lcar.statut
                          WHEN lcar.statut = 'ACT' THEN 'AFF'
                          ELSE 'PER'
                          --Fin Ajout ERI le 16/06/2014
                          END,                                        --CODEETATCARTEFIDELITECLIENT
                          */
             --Fin Modif ERI le 15/06/2017 : Mantis 7593
             CASE
               WHEN ca.codecartefideliteclient IS NOT NULL THEN
                1
               ELSE
                0
             END --CODEMAJ
        FROM lbm_cartes_clients lcar
       INNER JOIN lbm_clients lcli ON lcar.numid = lcli.numid
       INNER JOIN lbm_message_id lmi ON lcar.messageid = lmi.id_message
                                    AND lmi.id_batch_stl = lecodetraitementbiztalknegatif
       INNER JOIN lbm_int_clients icli ON lcar.numid = icli.numid
        LEFT JOIN carte_fidelite_client ca ON ca.codecartefideliteclient = lcar.numcarte
       WHERE lcli.codemajcarte = 1;
  
    /*
    INSERT INTO lbm_int_carte_fidelite_client
    SELECT lcli.codecarte,                                            --CODECARTEFIDELITECLIENT
    lcli.typecarte,                                        --CODETYPECARTEFIDELITECLIENT
    lcli.datecreacarte,                                                   --DATECREATION
    lcli.datecreacarte,                                                --DATEATTRIBUTION
    CASE
    WHEN NVL(lcli.datesuppcarte, icli.datesuppression) <= TRUNC(sysdate) --IS NOT NULL
    THEN NVL(lcli.datesuppcarte, icli.datesuppression)
    ELSE NULL
    END,                     --DATESUPPRESSION
    icli.codeclient,                                                        --CODECLIENT
    CASE
    WHEN NVL(lcli.datesuppcarte, icli.datesuppression) <= TRUNC(sysdate) --IS NOT NULL
    THEN 'PER'
    ELSE 'AFF'
    END,                                                   --CODEETATCARTEFIDELITECLIENT
    CASE
    WHEN ca.CODECARTEFIDELITECLIENT IS NOT NULL
    --NVL(lcli.datesuppcarte, icli.datesuppression) IS NOT NULL
    THEN 1
    ELSE 0
    END                                                                        --CODEMAJ
    FROM lbm_clients lcli
    INNER JOIN lbm_message_id lmi ON lcli.messageid = lmi.id_message and
    lmi.id_batch_stl = LeCodeTraitementBizTalkNegatif
    INNER JOIN lbm_int_clients icli ON lcli.numid = icli.numid
    LEFT JOIN carte_fidelite_client ca ON ca.codecartefideliteclient = lcli.CODECARTE
    WHERE lcli.codemajcarte = 1
    ;
    */
    -- Fin modif ERI le 10/01/2014
  
    -- 2eme etape: On insert les anciennes cartes des clients qui font l'objet d'un renouvellement de carte en indiquant la suppression de celles-ci
    /* Formatted on 2014/03/12 10:27 (Formatter Plus v4.8.8) */
    /* Formatted on 2014/03/12 11:38 (Formatter Plus v4.8.8) */
    /* Formatted on 2014/03/12 12:00 (Formatter Plus v4.8.8) */
    INSERT INTO lbm_int_carte_fidelite_client
      SELECT ca.codecartefideliteclient
            , --CODECARTEFIDELITECLIENT
             ca.codetypecartefideliteclient
            ,
             
             --CODETYPECARTEFIDELITECLIENT
             ca.datecreation
            , --DATECREATION
             ca.dateattribution
            , --DATEATTRIBUTION
             NVL((SELECT MAX(lca2.datecreation) FROM lbm_int_carte_fidelite_client lca2 WHERE lca2.codeclient = ca.codeclient) - 1
                ,SYSDATE)
            ,
             
             --lca.datecreation - 1,
             
             --DATESUPPRESSION
             ca.codeclient /*lca.codeclient*/
            , --CODECLIENT
             'PER'
            ,
             --CODEETATCARTEFIDELITECLIENT
             1 --CODEMAJ
        FROM carte_fidelite_client ca
      --Modif ERI le 12/03/2014
      /*
            INNER JOIN lbm_int_carte_fidelite_client lca ON lca.codeclient = ca.codeclient
            WHERE ca.codecartefideliteclient != lca.codecartefideliteclient AND
            ca.datesuppression IS NULL AND lca.codeetatcartefideliteclient != 'TMP'
            */
       INNER JOIN lbm_int_clients lcli ON ca.codeclient = lcli.codeclient
      --FTR le 27/10/2014 pour securisation suite plantage encore inexplique
       INNER JOIN (SELECT DISTINCT codeclient from lbm_int_carte_fidelite_client) lca2 on ca.codeclient = lca2.codeclient
      --Fin FTR le 27/10/2014
        LEFT JOIN lbm_int_carte_fidelite_client lca ON lca.codeclient = ca.codeclient
                                                   AND lca.codecartefideliteclient = ca.codecartefideliteclient
       WHERE lca.codecartefideliteclient IS NULL;
    --Fin modif ERI le 12/03/2014
  
    -- 3eme etape: Suppression des enregistrements pour les cas suivant: - Des nouvelles cartes qui existe deja dans STORELAND
    --                                                                   - Des cartes a supprimer mais qui n'existe pas dans STORELAND
    DELETE FROM lbm_int_carte_fidelite_client lca
     WHERE lca.codeclient IN (SELECT lca.codeclient
                                FROM lbm_int_carte_fidelite_client lca
                                LEFT JOIN carte_fidelite_client ca ON ca.codecartefideliteclient = lca.codecartefideliteclient
                               WHERE (lca.codemaj = 0 AND ca.codecartefideliteclient IS NOT NULL AND lca.codeclient = ca.codeclient)
                                  OR (lca.codemaj = 1 AND ca.codecartefideliteclient IS NULL));
  
    ----------------------------------------------------
    -- Insertion masse dans table LBM_INT_STATS_CLIENT
    ----------------------------------------------------
    nomtable := 'LBM_INT_STATS_CLIENT';
  
    INSERT INTO lbm_int_stats_client
      SELECT icli.codeclient
            , --CODECLIENT
             lst.codeaxestat
            , --CODEAXESTAT
             lst.elementstat
            , --CODEELEMENTSTAT
             NVL(lst.valeurstat
                ,est.libelementstatclient)
            , --VALEURAXESTATISTIQUECLIENT
             --Ajout ERI le 27/02/2014: gestion de l'alimentation de la table ENVOIS_MARKETING
             lst.CODEPROMO --CODEPROMO
      --Fin ajout ERI le 27/02/2014
        FROM lbm_stats lst
       INNER JOIN lbm_message_id lmi ON lst.messageid = lmi.id_message
                                    and lmi.id_batch_stl = LeCodeTraitementBizTalkNegatif
       INNER JOIN lbm_clients lcli ON lcli.numid = lst.numid
       INNER JOIN lbm_int_clients icli ON icli.numid = lst.numid
        LEFT JOIN element_statistiques_client est ON est.CODEAXESTATISTIQUECLIENT = lst.codeaxestat
                                                 AND est.CODEELEMENTSTATCLIENT = lst.elementstat
       WHERE lcli.codemajstat = 1
            -- Ajout ERI le 02/02/2015: Suppression de l'affichage du montant des bons cadeaux sur les caisses
         AND codeaxestat <> 47;
    -- Fin Ajout ERI le 02/02/2015
  
    --Ajout ERI le 13/03/2014
  
    -- Ajout du Code Axe statisitique  type de remise" (2) pour les clients ayant un axe statistique  "taux de remise" (2)
  
    /*
    INSERT INTO lbm_int_stats_client
    SELECT ilst.codeclient,                                        --CODECLIENT
    2,                                                     --CODEAXESTAT
    CASE
    WHEN ilst.codeelementstat = 6
    THEN 3
    ELSE 2
    END,                                               --CODEELEMENTSTAT
    CASE
    WHEN ilst.codeelementstat = 6
    THEN 'Remise personnel'
    ELSE 'Remise client'
    END                                     --VALEURAXESTATISTIQUECLIENT
    ,NULL                                                    --CODEPROMO
    FROM lbm_int_stats_client ilst LEFT JOIN lbm_int_stats_client ilst2
    ON ilst.codeclient = ilst2.codeclient AND ilst2.codeaxestat = 2
    WHERE ilst.codeaxestat = 3
    AND ilst.codeelementstat <> 1
    AND ilst2.codeclient IS NULL;
    
    */
    --Fin ajout ERI le 13/03/2014
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration en masse des clients dans tables LBM_INT');
    --raise_application_error(-60,'Test gestion code Erreur technique');
  
  EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      raise_application_error(-20001
                             ,'Erreur de violation de contrainte unique lors de l''insertion en masse dans ' || nomtable || '. ' || CHR(13) || SQLERRM(SQLCODE));
    WHEN OTHERS THEN
      IF SQLCODE = -1400 THEN
        raise_application_error(-20001
                               ,'Erreur lors de l''insertion en masse dans ' || nomtable || '.''Tentative d''insertion d''un client de la table LBM_CLIENTS sans n? de carte avec un "CODEMAJCARTE" a 1. ' || CHR(13) || SQLERRM(SQLCODE));
      ELSE
        raise_application_error(-20001
                               ,'Erreur lors de l''insertion en masse dans ' || nomtable || '. ' || CHR(13) || SQLERRM(SQLCODE));
      END IF;
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
  /*  BFU 29/01/2009 Modifications                                   */
  /*******************************************************************/

  PROCEDURE LBM_IntegrationReferencement IS
    LeCodeMsg         Log_Traitements.CodeMsg%TYPE;
    LockPresent       BOOLEAN;
    NbSecondes        NUMBER(4);
    NbSecondesTimeOut NUMBER(4);
    LeNbErreurs       NUMBER(10);
    ToujoursOk        BOOLEAN;
    Existe            NUMBER(1);
  
    -----------------------------------------------------------------
    -- Procedure de purges des tables temporaires pour l'integration
    -----------------------------------------------------------------
    PROCEDURE InitTableTempo IS
      Resultat NUMBER;
    BEGIN
      BEGIN
        -- Hierarachie
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_CLASSPROD0 REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_CLASSPROD1 REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_CLASSPROD2 REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_CLASSPROD3 REUSE STORAGE');
      
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_CLASSPROD1 REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_CLASSPROD2 REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_CLASSPROD3 REUSE STORAGE');
      
        -- Article
        -- TABLE INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_PRODUITS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_ARTICLES REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_PRODUITS_COLORIS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_PRODUITS_ETIQUETTE REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_TVA_PRODUIT_PAYS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_DESCRIPTIONS_PRODUIT_WEB REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_STATS_PRODUIT_COLORIS REUSE STORAGE');
        --Ajout ERI le 18/05/2016: Gestion des axes statistiques produits (Mantis 7562)
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_STATS_PRODUIT_LBM REUSE STORAGE');
        --Fin Ajout ERI le 18/05/2016
        -- TABLE TEMP_INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_PRODUITS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_ARTICLES REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_PRODUITS_COLORIS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_PRODUITS_ETIQUETTE REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_TVA_PRODUIT_PAYS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_DESC_PRODUIT_WEB REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_STATS_PRODUIT_COLORIS REUSE STORAGE');
        --Ajout ERI le 18/05/2016: Gestion des axes statistiques produits (Mantis 7562)
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_STATS_PRODUIT_LBM REUSE STORAGE');
        --Fin Ajout ERI le 18/05/2016
        -- EAN
        -- TABLE INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_HISTO_CB_FRN REUSE STORAGE');
      
        -- TABLE TEMP_INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_HISTO_CB_FRN REUSE STORAGE');
      
        -- Tarif
        -- TABLE INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_TARIFS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_TARIFS_FUTURS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_OPERATIONS_COMMERCIALES REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_DATES_OPE_COMM REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE INT_TARIFS_GROUPE_MAGASIN REUSE STORAGE');
      
        -- TABLE TEMP_INT
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_TARIFS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_TARIFS_FUTURS REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_OPE_COMM REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_DATES_OPE_COMM REUSE STORAGE');
        Resultat := SQL_DYN_PARSER('TRUNCATE TABLE TEMP_INT_TARIFS_GROUPE_MAGASIN REUSE STORAGE');
      EXCEPTION
        WHEN OTHERS THEN
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de la purge des tables INT et TEMP_INT' || CHR(13) || SQLERRM(SQLCODE));
      END;
    END;
  
  BEGIN
    LeCodeMsg := 'BIZ-0000';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut de l''integration du referencement');
  
    -- Recuperation du timeout
    BEGIN
      SELECT LeTimeOut INTO NbSecondesTimeOut FROM LBM_PARAM_INTERFACE;
    EXCEPTION
      WHEN OTHERS THEN
        NbSecondesTimeOut := 600; -- TimeOut = 10 minutes par defaut
    END;
  
    NbSecondes := 0;
    ToujoursOk := TRUE;
  
    ---------------------------------------------------------
    -- 1.) Poser un lock ; en cas d'echec apres timeout, exit
    ---------------------------------------------------------
    /*WHILE TRUE
    LOOP
    
    INSERT INTO TABLE_LOCK (NOMTABLE, ENREGISTREMENT, NUMPOSTE, CODEUTILISATEUR)
    SELECT 'PREPA_EN_JOURNEE', '1', to_char(sysdate, 'DDMMHH24MISS'), -1 FROM Dual
    WHERE not exists (SELECT NOMTABLE FROM TABLE_LOCK WHERE NOMTABLE='PREPA_EN_JOURNEE') ;
    IF SQL%ROWCOUNT<>1 THEN
    
    LockPresent := FALSE;
    dbms_Lock.Sleep(1); -- tempo de 1 seconde
    NbSecondes := NbSecondes + 1;
    IF NbSecondes >= NbSecondesTimeOut THEN
    ToujoursOk := FALSE;
    END IF;
    ELSE
    LockPresent := TRUE;
    END IF;
    
    EXIT WHEN LockPresent OR NOT ToujoursOk;
    END LOOP;*/
  
    WHILE TRUE LOOP
      BEGIN
        SELECT 1 INTO Existe FROM TABLE_LOCK WHERE NomTable = 'PREPA_EN_JOURNEE';
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
          ('PREPA_EN_JOURNEE'
          ,'1'
          ,to_char(sysdate
                  ,'DDMMHH24MISS')
          ,-1);
        ToujoursOk := TRUE;
      EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
          ToujoursOk := FALSE;
      END;
    ELSE
      ToujoursOk := FALSE;
    END IF;
  
    -- Echec apres timeout, exit, sinon on continue
    IF Not ToujoursOk THEN
      Ajouter_Log(1
                 ,LeCodeMsg
                 ,'Impossible d''inserer un lock (TimeOut).');
      -- Lock Ok
    ELSE
    
      ------------------------------------------------------------------------------------------------------------------
      ---FTR le 13/11/2014, suppression des clients de la table PREPA_JOURNEE pour ne pas les envoyer vers les caisses.
      ------------------------------------------------------------------------------------------------------------------
      DELETE prepa_journee where codeclient IS NOT NULL;
      ------------------------------------------------------------------------------------------------------------------
      ---Fin FTR le 13/11/2014,  Fin specifique temporaire
      ------------------------------------------------------------------------------------------------------------------
    
      ---------------------------------------------------------
      -- 2.)  recuperer un nouveau codetraitement (id_batch),
      ---------------------------------------------------------
      BEGIN
        SELECT NVL(CodeMsgLog
                  ,0) + 1
          INTO LeCodeTraitementBizTalk
          FROM LBM_PARAM_INTERFACE;
        LeCodeTraitementBizTalkNegatif := -LeCodeTraitementBizTalk;
        UPDATE LBM_PARAM_INTERFACE SET CodeMsgLog = LeCodeTraitementBizTalk;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          LeCodeTraitementBizTalk := -1;
      END;
    
      ---------------------------------------------------------
      -- 3.)  mettre a jour LBM_MESSAGE_ID si id_batch est null (nouveaux articles)
      --        ou id_batch est negatif (si plantage trt precedent) avec - nouveau code traitement,
      ---------------------------------------------------------
      UPDATE LBM_MESSAGE_ID
         SET ID_BATCH_STL = LeCodeTraitementBizTalkNegatif
       WHERE ((ID_BATCH_STL IS NULL) OR (ID_BATCH_STL < 0))
         AND TYPEFLUX = 'ART'; -- ERI 10/05/2012: ajout TYPEFLUX = 'ART' pour Distinction du flux client
    
      ---------------------------------------------------------
      -- 4.)  vider (truncate) toutes les tables INT_xxx et TEMP_INT_xxx
      ---------------------------------------------------------
      InitTableTempo;
    
      -- Insertion en masse (pour tous les Bloc ou le (ID_BATCH_STL = LeCodeTraitementBizTalkNegatif)
      -- des articles, des ean et des tarifs
      -- JSC #25887
      BEGIN
        -- Maj table de suivi des batch avec nb erreurs a 0
        -- voir si maj_suivi ne fait pas un commit car msgid update alors que pb ds lbm_article !!
        MAJ_SUIVI_BATCH_INTEGRATION(LeCodeTraitementBizTalk
                                   ,NULL /*DateFin*/
                                   ,0 /*NbErreur*/
                                   ,SYSDATE
                                   ,'TABLE_INT');
        ---------------------------------------------------------
        -- 5.)  Integration dans les tables INT_xxx
        ---------------------------------------------------------
        PRC_LBM_HIERARCHIE;
        PRC_LBM_ARTICLE;
        PRC_LBM_EAN;
        PRC_LBM_TARIF;
        -- 1er commit
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            ROLLBACK;
          
            UPDATE LBM_MESSAGE_ID
               SET ID_BATCH_STL = NULL
             WHERE ID_BATCH_STL < 0
               AND TYPEFLUX = 'ART'; -- ERI 10/05/2012: ajout TYPEFLUX = 'ART' pour Distinction du flux client
            COMMIT;
          
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de PK_LBM.INTEGRATION_REFERENCEMENT.' || CHR(13) || SQLERRM(SQLCODE));
            ToujoursOk := FALSE;
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
                                     ,'TABLE_STL');
        
          PK_INterface.INIT_CODETRAITEMENT(LeCodeTraitementBizTalk);
          PK_INterface.INTEGRATION_REFERENCEMENT;
          --2eme commit
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            BEGIN
              ROLLBACK;
            
              UPDATE LBM_MESSAGE_ID
                 SET ID_BATCH_STL = NULL
               WHERE ID_BATCH_STL < 0
                 AND TYPEFLUX = 'ART'; -- ERI 10/05/2012: ajout TYPEFLUX = 'ART' pour Distinction du flux client
              COMMIT;
            
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Erreur lors de PK_Interface.INTEGRATION_REFERENCEMENT.' || CHR(13) || SQLERRM(SQLCODE));
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
            FROM (Select count(*) as nberr
                    from TEMP_INT_CLASSPROD1
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_CLASSPROD2
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_CLASSPROD3
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_PRODUITS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_ARTICLES
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_PRODUITS_COLORIS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_PRODUITS_ETIQUETTE
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_TVA_PRODUIT_PAYS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_DESC_PRODUIT_WEB
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_STATS_PRODUIT_COLORIS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_HISTO_CB_FRN
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_TARIFS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_TARIFS_FUTURS
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_OPE_COMM
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr
                    from TEMP_INT_DATES_OPE_COMM
                   WHERE CodeCtrl > 0
                  UNION ALL
                  Select count(*) as nberr from TEMP_INT_TARIFS_GROUPE_MAGASIN WHERE CodeCtrl > 0);
          MAJ_SUIVI_BATCH_INTEGRATION(LeCodeTraitementBizTalk
                                     ,SYSDATE
                                     ,LeNbErreurs
                                     ,NULL
                                     ,'TABLE_STL');
        EXCEPTION
          WHEN OTHERS THEN
            ToujoursOk := FALSE;
        END;
      END IF;
      --2eme commit
      COMMIT;
    END IF;
  END;

  /******************************************************
  * Procedure  LBM_SEND_MAIL_LOG                       *
  *  Envoi d'un mail pour les logs en erreur           *
  *                                                    *
  * ERI "4/01/2014 Creation                            *
  *                                                    *
  ******************************************************/

  PROCEDURE LBM_SEND_MAIL_LOG(leExpediteur   varchar2
                             ,LeDestinataire varchar
                             ,LeObjet        varchar
                             ,LeMessage      varchar) IS
  
  BEGIN
  
    LBM_SEND_MAIL(leExpediteur
                 ,LeDestinataire
                 ,LeObjet
                 ,LeMessage);
  
  END;
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
  
    -----------------------------------------------------------------
    -- Procedure de purges des tables temporaires pour l'integration
    -----------------------------------------------------------------
    PROCEDURE InitTableTempo IS
      Resultat VARCHAR(200);
    
      --pragma autonomous_transaction;
    
    BEGIN
    
      BEGIN
      
        Resultat := 'DELETE FROM LBM_INT_CLIENTS';
        EXECUTE IMMEDIATE Resultat;
      
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de la purge de la table LBM_INT_CLIENTS' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
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
      BEGIN
      
        Resultat := 'DELETE FROM LBM_CLIENTS_INTERFACE';
        EXECUTE IMMEDIATE Resultat;
      
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Une erreur s''est produite lors de la purge de la table LBM_CLIENTS_INTERFACE' || CHR(13) || SQLERRM(SQLCODE));
      END;
      --Fin Ajout ERI le 29/01/2015
    
      COMMIT;
    
    END;
  
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
      Ajouter_Log(1
                 ,LeCodeMsg
                 ,'Impossible d''inserer un lock (TimeOut).');
      -- Lock Ok
    ELSE
      ---------------------------------------------------------
      -- 2.)  recuperer un nouveau codetraitement (id_batch),
      ---------------------------------------------------------
      BEGIN
        SELECT NVL(CodeMsgLog
                  ,0) + 1
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
                         ,'Erreur lors de PK_LBM.INTEGRATION_CLIENT.' || CHR(13) || SQLERRM(SQLCODE));
            
            ELSE
              Ajouter_Log(1
                         ,LeCodeMsg
                         ,'Erreur lors de PK_LBM.INTEGRATION_CLIENT.' || CHR(13) || SQLERRM(SQLCODE));
            
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
                         ,'Erreur lors de PK_Interface.INTEGRATION_CLIENT_LBM.' || CHR(13) || SQLERRM(SQLCODE));
            
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
          SELECT SUM(nberr) INTO LeNbErreurs FROM (Select count(*) as nberr from LBM_INT_CLIENTS_REJETS);
        
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

  /*******************************************************************/
  /*  Procedure PRC_LBM_VENTE                                        */
  /*                                                                 */
  /*  Extraction des ventes depuis Storeland vers BizTalk            */
  /*                                                                 */
  /*  SM 06/11/2006 #20104 Creation                                  */
  /*  DL 09/01/2007 ajout du departement (CP1) du produit            */
  /*  AD 06/04/2009 #30958 Ajout d'une quantite 1                    */
  /*                sur les lignes d'acompte                         */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE PRC_LBM_VENTE IS
    LeCodeMsg          Log_Traitements.CodeMsg%TYPE;
    NbJoursTickets     LBM_PARAM_INTERFACE.NbJourPourTicket%TYPE;
    CodeAxeSteCaisse   LBM_PARAM_INTERFACE.CodeAxeSteCaisse%TYPE;
    CodeRemiseEscompte LBM_PARAM_INTERFACE.CodeRemiseEscompte%TYPE;
    --Dla le 15/05/2007 : ajout du code remise OPCOMM
    CodeRemiseOpComm  LBM_PARAM_INTERFACE.CodeRemiseOpComm%TYPE;
    LaDateMiseAJour   DATE;
    LeEnteteVente     TRecLBMVenteEntete;
    LeTabLignesVentes TabLigneVente;
    LeTabLignesRegl   TTabLigneReglement;
    --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
    LeTabLignesAMKT TTabLigneActMKT;
    iLigneAMKT      NUMBER(3);
    --Fin ajout ERI le 19/12/20103
    --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
    LeTabLignesAMKTR TTabLigneActMKTRep;
    iLigneAMKTR      NUMBER(3);
    --Fin Ajout ERI le 19/09/2014
    --Ajout ERI le 02/01/2016: Gestion des attributs tickets
    LeTabLignesAttributVente TTabLigneAttribut;
    iLigneAttribut           Number(3);
    --Fin Ajout ERI le 02/01/2016
    iLigneVente NUMBER(3);
    iLigneRegl  NUMBER(3);
    LePlanLib   OPERATIONS_COMMERCIALES.LIBOPECOMM%TYPE;
    -- DLA le 13/03 /2007 : modif pour extraction des remises, escompte et export
    LeNewTicket                  HISTORIQUE_CAISSES.Numticket%TYPE;
    LeOldTicket                  HISTORIQUE_CAISSES.Numticket%TYPE;
    TicketExport                 NUMBER(1);
    TicketEscompte               NUMBER(1);
    TauxEscompte                 NUMBER(5
                                       ,2);
    EscompteNbLigne              NUMBER(8);
    EscompteMtTotal              NUMBER(10
                                       ,2);
    EscompteMtIntermediaire      NUMBER(10
                                       ,2);
    EscompteNbLigneIntermediaire NUMBER(8);
    EscompteCATicketTotal        NUMBER(10
                                       ,2);
    -- DLA le 28/03/2007 pour ne rien integrer quand un ticket est en erreur
    TicketEnErreur NUMBER(1);
    -- DLA le 13/03 /2007 : FIN modif pour extraction des remises, escompte et export
    -- DLA le 29/03/2007 si pas de paiement (ticket a 0 euro), on genere qd meme
    -- une ligne de reglement a 0, mode de reglement espece (BFU le 29/03/2007)
    -- Modif ERI 28/03/2017: Correction regression Remboursement BC
    --TicketAZero  NUMBER(1);
    TicketAZero NUMBER(2);
    -- Modif ERI 28/03/2017
    TicketChange         NUMBER(1);
    CodeRecetteChange    LBM_PARAM_INTERFACE.CodeRecetteChange%TYPE;
    CodeDepenseChange    LBM_PARAM_INTERFACE.CodeDepenseChange%TYPE;
    EANChangeLBM         LBM_PARAM_INTERFACE.EANChangeLBM%TYPE;
    EANChangeSEGEP       LBM_PARAM_INTERFACE.EANChangeSEGEP%TYPE;
    EANChangeFF          LBM_PARAM_INTERFACE.EANChangeFF%TYPE;
    TypeChange           LBM_PARAM_INTERFACE.CodeDepenseChange%TYPE;
    PRENUMEROTATION      PARAMETRES_FACTURATIONCLIENT.PRENUMEROTATION%TYPE;
    NumFacture           NUM_FACTURE_TICKET.NUMFACTURE%TYPE;
    TicketClientEnCompte Number(1);
    --Ajout pour le controle de coherence du ticket;
    LaSteCaisseEnCours  VARCHAR2(4);
    LeNumCaisseEnCours  NUMBER(10);
    LeNumTicketEnCours  NUMBER(10);
    LaDateHTransEnCours DATE;
    ControleOK          NUMBER(1);
    PromoPourcentage    NUMBER(1);
    -- PB 19/10/2007 #22884 Gestion des cartes cadeaux
    --Modif MTI  le 03/12/2012  pour ajouter NumRecCarteKDO_SEGEP et NumRecCarteKDO_FF
    --dans le cadre de l'achat des cartes CKDO SEGEP sur des caisses BM
    -- NumRecCarteKDO     LBM_PARAM_INTERFACE.NumRecCarteKDO%TYPE;
    NumRecCarteKDO       LBM_PARAM_INTERFACE.NumRecCarteKDO%TYPE;
    NumRecCarteKDO_SEGEP LBM_PARAM_INTERFACE.NumRecCarteKDO_SEGEP%TYPE;
    NumRecCarteKDO_FF    LBM_PARAM_INTERFACE.NumRecCarteKDO_FF%TYPE;
    -- Fin MTI
    --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
    NumRecBonKdoCRM     LBM_PARAM_INTERFACE.NUMRECBONKDOCRM%TYPE;
    EANBonKdoCRM        LBM_PARAM_INTERFACE.EANBONKDOCRM%TYPE;
    TicketRembBonKdoCRM NUMBER(2);
    --Fin Ajout ERI le 17/11/2015
    EANCarteKdo_BM    LBM_PARAM_INTERFACE.EANCarteKdo_BM%TYPE;
    EANCarteKdo_SEGEP LBM_PARAM_INTERFACE.EANCarteKdo_SEGEP%TYPE;
    EANCarteKdo_FF    LBM_PARAM_INTERFACE.EANCarteKdo_FF%TYPE;
    NumReglCarteKDO   LBM_PARAM_INTERFACE.NumReglCarteKDO%TYPE;
    MtTvaKdo          HISTORIQUE_CAISSES.MTTVA%TYPE;
    CANETKdo          HISTORIQUE_CAISSES.CaNetRealise%TYPE;
    CarteCadeau       NUMBER(1);
    EANSaisieKdo      HISTORIQUE_CAISSES.CodeSaisie%TYPE;
    VolVenteKdo       HISTORIQUE_CAISSES.VolVente%TYPE;
    TauxTvaKdo        TVA_PAYS.TauxTVA%TYPE;
    CodeNatureKdo     HISTORIQUE_CAISSES.CodeNature%TYPE;
    -- BP 27/10/2008 #27260
    CODE_RECETTE_ACPTE  LBM_PARAM_INTERFACE.CODE_RECETTE_ACPTE%TYPE;
    CODE_RECETTE_ACPTE2 LBM_PARAM_INTERFACE.CODE_RECETTE_ACPTE2%TYPE;
    CODE_DEPENSE_ACPTE  LBM_PARAM_INTERFACE.CODE_DEPENSE_ACPTE%TYPE;
    EAN_ACPTE_1_LBM     LBM_PARAM_INTERFACE.EAN_ACPTE_1_LBM%TYPE;
    EAN_ACPTE_1_SEGEP   LBM_PARAM_INTERFACE.EAN_ACPTE_1_SEGEP%TYPE;
    EAN_ACPTE_1_FF      LBM_PARAM_INTERFACE.EAN_ACPTE_1_FF%TYPE;
    EAN_ACPTE_2_LBM     LBM_PARAM_INTERFACE.EAN_ACPTE_2_LBM%TYPE;
    EAN_ACPTE_2_SEGEP   LBM_PARAM_INTERFACE.EAN_ACPTE_2_SEGEP%TYPE;
    EAN_ACPTE_2_FF      LBM_PARAM_INTERFACE.EAN_ACPTE_2_FF%TYPE;
    EAN_ACPTE_3_LBM     LBM_PARAM_INTERFACE.EAN_ACPTE_3_LBM%TYPE;
    EAN_ACPTE_3_SEGEP   LBM_PARAM_INTERFACE.EAN_ACPTE_3_SEGEP%TYPE;
    EAN_ACPTE_3_FF      LBM_PARAM_INTERFACE.EAN_ACPTE_3_FF%TYPE;
    NUM_REGL_ACPTE      LBM_PARAM_INTERFACE.NUM_REGL_ACPTE%TYPE;
    NumCdeClt           LBM_VENTE_POSTE.NUMCDECLT%TYPE;
    EAN_Encaissement    HISTORIQUE_CAISSES.CODESAISIE%TYPE;
    CodeSaisieLiv       HISTORIQUE_CAISSES.CODESAISIE%TYPE;
    EscompteNoLigne     HISTORIQUE_CAISSES.NUMLIGNE%TYPE;
    QteLigneAcompte     LBM_VENTE_POSTE.QTE%TYPE;
    cpt                 NUMBER(3);
    Compteur            NUMBER(6);
  
    PROCEDURE InitTicket IS
    BEGIN
      LeEnteteVente.SteCaisse        := NULL;
      LeEnteteVente.DateHTrans       := NULL;
      LeEnteteVente.NumCaisse        := NULL;
      LeEnteteVente.NumCaissierTrans := NULL;
      LeEnteteVente.NumTicket        := NULL;
      LeEnteteVente.Export           := NULL;
      LeEnteteVente.NumClt           := NULL;
      LeEnteteVente.CaNetTTC         := NULL;
      LeEnteteVente.Escpt            := NULL;
      LeEnteteVente.NumCartePriv     := NULL;
      LeEnteteVente.DateHTOPCA       := NULL;
      LeEnteteVente.DateMaj          := NULL;
      --FTR le 06/08/2010
      LeEnteteVente.DELAIPAIEMENT := NULL;
      LeEnteteVente.DELAIARTICLE  := NULL;
      --Fin FTR le 06/08/2010
      --Ajout ERI le 20/12/2016: Gestion des attributs tickets
      --LeEnteteVente.numattribut := NULL;
      --LeEnteteVente.valeurattribut := NULL;
      --Fin Ajout ERI le 20/12/2016
    
      FOR i IN 1 .. iLigneVente LOOP
        LeTabLignesVentes(i) := NULL;
      END LOOP;
    
      FOR i IN 1 .. iLigneRegl LOOP
        LeTabLignesRegl(i) := NULL;
      END LOOP;
      --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
      FOR i IN 1 .. iLigneAMKT LOOP
        LeTabLignesAMKT(i) := NULL;
      END LOOP;
      --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
      FOR i IN 1 .. iLigneAMKTR LOOP
        LeTabLignesAMKTR(i) := NULL;
      END LOOP;
      --Ajout ERI le 02/01/2016: Gestion des attributs tickets
      FOR i IN 1 .. iLigneAttribut LOOP
        LeTabLignesAttributVente(i) := NULL;
      END LOOP;
      --Fin Ajout ERI le 02/01/2016
      --Fin Ajout ERI le 19/09/2014
      iLigneAMKT := 0;
      --Fin ajout ERI le 19/12/20103
      --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
      iLigneAMKTR := 0;
      --Fin Ajout ERI le 19/09/2014
      --Ajout ERI le 02/01/2016: Gestion des attributs tickets
      iLigneAttribut := 0;
      --Fin ajout ERI le 02/01/2016
      iLigneVente := 0;
      iLigneRegl  := 0;
    END;
  
    PROCEDURE EFFACE_LBM_TICKET_A_EXTRAIRE(LeCodeMagasin NUMBER
                                          ,LeJourDeVente DATE
                                          ,LeCodeCaisse  VARCHAR2
                                          ,LeNumTicket   NUMBER) IS
    BEGIN
      DELETE FROM LBM_TICKET_A_EXTRAIRE
       WHERE CODEMAGASIN = LeCodeMagasin
         AND JOURDEVENTE = TRUNC(LeJourDeVente)
         AND CODECAISSE = LeCodeCaisse
         AND NUMTICKET = LeNumTicket;
    END;
  
    PROCEDURE EFFACE_LBM_TICKET_A_EXTRAIRE_A(LeCodeMagasin NUMBER
                                            ,LeJourDeVente DATE
                                            ,LeCodeCaisse  VARCHAR2
                                            ,LeNumTicket   NUMBER) IS
      pragma autonomous_transaction;
    BEGIN
      EFFACE_LBM_TICKET_A_EXTRAIRE(LeCodeMagasin
                                  ,LeJourDeVente
                                  ,LeCodeCaisse
                                  ,LeNumTicket);
      COMMIT;
    END;
  
  BEGIN
    LeCodeMsg := 'BIZ-0005';
    --DLA le 01/01/2007
  
    LePlanLib := NULL;
    -- DLA le 13/03 /2007 : modif pour extraction des remises, escompte et export
    LeOldTicket          := -1;
    LeNewTicket          := -1;
    TicketExport         := 0;
    TicketEscompte       := 0;
    TicketEnErreur       := 0;
    TicketAZero          := 0;
    TicketChange         := 0;
    TypeChange           := 0;
    TicketClientEnCompte := 0;
  
    LaSteCaisseEnCours  := NULL;
    LeNumCaisseEnCours  := 0;
    LeNumTicketEnCours  := 0;
    LaDateHTransEnCours := NULL;
    -- DLA le 13/03 /2007 : FIN modif pour extraction des remises, escompte et export
  
    --Modif MTI le 03/12/2012 dans le cadre de la mise en place de l'achat
    --et de l'encaissement des carte CKDO segep sur des caisses LBM
    --NumRecCarteKDO    := 0;
    NumRecCarteKDO       := 0;
    NumRecCarteKDO_SEGEP := 0;
    NumRecCarteKDO_FF    := 0;
    -- fin MTI
    --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
    NumRecBonKdoCRM     := 0;
    EANBonKdoCRM        := 0;
    TicketRembBonKdoCRM := 0;
    --Fin Ajout ERI le 17/11/2015
    EANCarteKdo_BM    := 0;
    EANCarteKdo_SEGEP := 0;
    EANCarteKdo_FF    := 0;
    NumReglCarteKDO   := 0;
    -- BP #27260
    CODE_RECETTE_ACPTE  := 0;
    CODE_RECETTE_ACPTE2 := 0;
    CODE_DEPENSE_ACPTE  := 0;
    EAN_ACPTE_1_LBM     := ' ';
    EAN_ACPTE_1_SEGEP   := ' ';
    EAN_ACPTE_1_FF      := ' ';
    EAN_ACPTE_2_LBM     := ' ';
    EAN_ACPTE_2_SEGEP   := ' ';
    EAN_ACPTE_2_FF      := ' ';
    EAN_ACPTE_3_LBM     := ' ';
    EAN_ACPTE_3_SEGEP   := ' ';
    EAN_ACPTE_3_FF      := ' ';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de la generation des ventes par LBM_VENTE');
  
    --**************** On ramene les parametres des interfaces
  
    BEGIN
      BEGIN
        SELECT lpi.NbJourPourTicket
              ,lpi.CodeAxeSteCaisse
              ,lpi.CodeRemiseEscompte
              ,
               --DLA le 15/05/2007 : ajout de coderemiseopcomm
               lpi.CodeRemiseOpComm
              ,
               --DLA le 18/05/2007 : ajout du ticket de change
               CodeRecetteChange
              ,CodeDepenseChange
              ,EANChangeLBM
              ,EANChangeSEGEP
              ,EANChangeFF
              ,NumRecCarteKDO
              ,
               --Modif MTI le 03/12/2012
               NumRecCarteKDO_SEGEP
              ,NumRecCarteKDO_FF
              ,
               --Fin MTI
               --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
               NumRecBonKdoCrm
              ,EANBONKDOCRM
              ,
               --Fin Ajout ERI le 17/11/2015
               EANCarteKdo_BM
              ,EANCarteKdo_SEGEP
              ,EANCarteKdo_FF
              ,NumReglCarteKDO
              ,CODE_RECETTE_ACPTE
              , -- BP 27/10/2008 #27260
               CODE_RECETTE_ACPTE2
              ,CODE_DEPENSE_ACPTE
              ,EAN_ACPTE_1_LBM
              ,EAN_ACPTE_1_SEGEP
              ,EAN_ACPTE_1_FF
              ,EAN_ACPTE_2_LBM
              ,EAN_ACPTE_2_SEGEP
              ,EAN_ACPTE_2_FF
              ,EAN_ACPTE_3_LBM
              ,EAN_ACPTE_3_SEGEP
              ,EAN_ACPTE_3_FF
              ,NUM_REGL_ACPTE
          INTO NbJoursTickets
              ,CodeAxeSteCaisse
              ,CodeRemiseEscompte
              ,CodeRemiseOpComm
              ,
               --DLA le 18/05/2007 : ajout du ticket de change
               CodeRecetteChange
              ,CodeDepenseChange
              ,EANChangeLBM
              ,EANChangeSEGEP
              ,EANChangeFF
              ,NumRecCarteKDO
              ,
               --Modif MTI le 03/12/2012
               NumRecCarteKDO_SEGEP
              ,NumRecCarteKDO_FF
              ,
               --Fin MTI
               --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
               NumRecBonKdoCrm
              ,EANBonKdoCRM
              ,
               --Fin Ajout ERI le 17/11/2015
               EANCarteKdo_BM
              ,EANCarteKdo_SEGEP
              ,EANCarteKdo_FF
              ,NumReglCarteKDO
              ,CODE_RECETTE_ACPTE
              , -- BP 27/10/2008 #27260
               CODE_RECETTE_ACPTE2
              ,CODE_DEPENSE_ACPTE
              ,EAN_ACPTE_1_LBM
              ,EAN_ACPTE_1_SEGEP
              ,EAN_ACPTE_1_FF
              ,EAN_ACPTE_2_LBM
              ,EAN_ACPTE_2_SEGEP
              ,EAN_ACPTE_2_FF
              ,EAN_ACPTE_3_LBM
              ,EAN_ACPTE_3_SEGEP
              ,EAN_ACPTE_3_FF
              ,NUM_REGL_ACPTE
          FROM LBM_PARAM_INTERFACE lpi;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de la lecture des parametres d''extraction des ventes.' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      --*************DLA le 13/03/2007 : on va chercher le taux de l'escompte
      BEGIN
        SELECT ValeurDefaut
          INTO TauxEscompte
          FROM TYPES_REMISE
         WHERE CODETYPEREMISE = NVL(CodeRemiseEscompte
                                   ,0);
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de la lecture du taux de l''escompte.' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      --*************on recherche le parametrage de la facturation client
      BEGIN
        SELECT PRENUMEROTATION INTO PRENUMEROTATION FROM PARAMETRES_FACTURATIONCLIENT;
      EXCEPTION
        WHEN OTHERS THEN
          RAISE_APPLICATION_ERROR(-20001
                                 ,'Erreur lors de la lecture du parametrage de la facturation client.' || CHR(13) || SQLERRM(SQLCODE));
      END;
    
      --************** on ramene les tickets a extraire
    
      LaDateMiseAJour := SYSDATE;
      iLigneVente     := 0;
      iLigneRegl      := 0;
      --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
      iLigneAMKT := 0;
      --Fin ajout ERI le 19/12/20103
      --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
      iLigneAMKTR := 0;
      --Fin Ajout ERI le 19/09/2014
      --Ajout ERI le 02/01/2016: Gestion des attributs tickets
      iLigneAttribut := 0;
      --Fin ajout ERI le 02/01/2016
      CodeSaisieLiv := ' ';
      FOR Ligne IN (SELECT *
                      FROM (SELECT 'Ligne' TypeInfo
                                  ,sm.CodeElementStat
                                  ,hc.CodeMagasin
                                  ,hc.JourDeVente
                                  ,hc.CodeCaisse
                                  ,hc.CodeCaissiere
                                  ,hc.NumTicket
                                  ,hc.CodeNature
                                  ,hc.NumLigne
                                  ,hc.CodeInterneArticle
                                  ,hc.CodeClient
                                  ,hc.TypeLigne
                                  ,
                                   --DLA le 13/03/2007 on remonte les info export, escompte
                                   DECODE(hc.TypeLigne
                                         ,4
                                         ,hc.CaNetRealise * (-1)
                                         ,CaNetRealise) CaNetRealise
                                  ,hc.MtRemise
                                  ,hc.MtRemiseReel
                                  ,hc.mtremiseligne
                                  ,(hc.MtRemiseReel - hc.mtremiseligne) MtRemiseTicket
                                  ,
                                   --         hc.MtTVA,
                                   ROUND((hc.CANETREALISE * TauxEscompte / 100)
                                        ,2) MtEscompteLigne
                                  ,
                                   --DLA le 01/03/2007
                                   hc.CodeOpeComm
                                  ,
                                   --DLA le 13/03/2007 on remonte les info export, escompte
                                   0 Escompte
                                  ,
                                   --                                 hc.CodeCarte,
                                   hc.CodeVendeur
                                  ,
                                   --                                 hc.CodeSaisie,
                                   DECODE(hc.TypeLigne
                                         ,7
                                         ,DECODE(MotifRetour
                                                ,CODE_RECETTE_ACPTE
                                                ,hc.CodeSaisie
                                                ,DECODE(MotifRetour
                                                       ,CODE_RECETTE_ACPTE2
                                                       ,hc.CodeSaisie
                                                       ,a.CodeBarres))
                                         ,hc.CodeSaisie) CodeSaisie
                                  ,
                                   --DECODE(hc.TypeLigne, 7,a.CodeBarres,hc.CodeSaisie) CodeSaisie,  --
                                   CP2.CodeClassprod1
                                  ,p.CodeClassProd3
                                  ,lc.APPL
                                  ,lc.TYPEGEST
                                  ,
                                   --SUM(NVL(hc.MtRemise, 0)) TotalRemisesLigne,
                                   tp.TauxTVA
                                  ,hc.MtTva
                                  ,hc.VolVente
                                  ,
                                   --                                 SUM(DECODE(tr.ApplicableEn, 1, hc.MtRemise, 0)) MtTotalRemiseLigne,
                                   --                                SUM(DECODE(hc.NumRemise, CodeRemiseEscompte, hc.MtRemise, 0)) EscompteLigne,
                                   DECODE(tr.ApplicableEn
                                         ,1
                                         ,hc.NumRemise
                                         ,0) ReducType
                                  ,DECODE(tr.ApplicableEn
                                         ,0
                                         ,hc.NumRemise
                                         ,0) RemiseType
                                  ,lc.HCA
                                  ,am.LibRedactionMarketing
                                  ,am.CodeTypeActionMarketing
                                  ,hc.MotifRetour
                                  ,NVL(mrmp.Cheque
                                      ,0) Cheque
                                  ,NVL(mrmp.CB
                                      ,0) CB
                                  ,hc.CodeDevise
                                  ,hc.NumPieceIdentite
                                  ,hc.PRIXVENTEARTICLECAISSE
                                  ,hc.libelle2
                                  ,
                                   -- Annulation de l'impact du mtremise OPComm suite evolution WST : les promo en remise sont desormais remontees comme
                                    -- des remises lignes
                                    0 MtRemiseOpComm
                                   ,
                                    --                      hc.MtRemiseOpComm,
                                    hc.EnPromotion
                                   ,hc.codetva
                                   ,hc.numligneresa
                                   ,hc.CodeActionMarketing
                               FROM HISTORIQUE_CAISSES      hc
                                   ,LBM_TICKET_A_EXTRAIRE   ltae
                                   ,STATS_MAGASIN           sm
                                   ,ARTICLES                a
                                   ,PRODUITS                p
                                   ,CLASSPROD2              CP2
                                   ,CLASSPROD3              CP3
                                   ,LBM_CP_HISTO            lc
                                   ,TVA_PAYS                tp
                                   ,ACTIONS_MARKETING       am
                                   ,TYPES_REMISE            tr
                                   ,MODES_REGL_MAGASIN_PAYS mrmp
                              WHERE hc.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets
                                AND hc.TypeLigne IN (1, 2, 4, 7, 9)
                                AND hc.CodeMagasin = ltae.CodeMagasin
                                   -- DLA : ajout du TRUNC
                                AND trunc(hc.JourDeVente) = ltae.JourDeVente
                                AND hc.CodeCaisse = ltae.CodeCaisse
                                AND hc.NumTicket = ltae.NumTicket
                                AND sm.CodeMagasin = hc.CodeMagasin
                                AND sm.CodeAxeStat = CodeAxeSteCaisse
                                AND a.CodeInterneArticle(+) = hc.CodeInterneArticle
                                AND p.CodeProduit(+) = a.CodeProduit
                                AND lc.CP(+) = p.CodeClassProd3
                                AND CP3.CodeClassProd3(+) = p.CodeClassProd3
                                AND CP2.CodeClassprod2(+) = CP3.CodeClassProd2
                                AND tp.CodeTVA(+) = hc.CodeTVA
                                AND tp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS')
                                AND am.CodeActionMarketing(+) = hc.CodeActionMarketing
                                AND tr.CodeTypeRemise(+) = hc.NumRemise
                                AND mrmp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS')
                                AND mrmp.CodeModeReglementMag(+) = hc.MotifRetour
                             UNION ALL
                             SELECT 'Pied' TypeInfo
                                   ,sm.CodeElementStat
                                   ,hc.CodeMagasin
                                   ,hc.JourDeVente
                                   ,hc.CodeCaisse
                                   ,hc.CodeCaissiere
                                   ,hc.NumTicket
                                   ,0 CodeNature
                                   ,0 NumLigne
                                   ,0 CodeInterneArticle
                                   ,hc.CodeClient
                                   ,0 TypeLigne
                                   ,
                                    --DLA le 13/03/2007 on remonte les info export, escompte
                                    SUM(DECODE(hc.TypeLigne
                                              ,9
                                              ,CaNetRealise
                                              ,0)) CaNetRealise
                                   ,0 MtRemiseReel
                                   ,0 MtRemise
                                   ,0 mtremiseligne
                                   ,0 MtRemiseTicket
                                   ,
                                    --         0 MtExport,
                                    0 MtEscompteLigne
                                   ,
                                    --DLA le 01/03/2007
                                    0 CodeOpeComm
                                   ,
                                    --DLA le 13/03/2007 FIN on remonte les info export, escompte
                                    NVL(sum(DECODE(hc.TypeLigne
                                                  ,6
                                                  ,(DECODE(hc.NumRemise
                                                          ,99
                                                          ,hc.MtRemise
                                                          ,0))
                                                  ,0))
                                       ,0) Escompte
                                   ,
                                    --                                 SUM(NVL(DECODE(hc.NumRemise, 99, hc.MtRemise, 0), 0)) Escompte,
                                    --                                 hc.CodeCarte,
                                    0 CodeVendeur
                                   ,'' CodeSaisie
                                   ,'' CodeClassprod1
                                   ,'' CodeClassProd3
                                   ,'' APPL
                                   ,'' TYPEGEST
                                   ,
                                    --                                 0 TotalRemisesLigne,
                                    0 TauxTVA
                                   ,0 MtTva
                                   ,0 VolVente
                                   ,
                                    --                                 0 MtTotalRemiseLigne,
                                    --                                 0 EscompteLigne,
                                    0 ReducType
                                   ,0 RemiseType
                                   ,'' HCA
                                   ,'' LibRedactionMarketing
                                   ,0 CodeTypeActionMarketing
                                   ,0 MotifRetour
                                   ,0 Cheque
                                   ,0 CB
                                   ,'' CodeDevise
                                   ,'' NumPieceIdentite
                                   ,0 PRIXVENTEARTICLECAISSE
                                   ,'' libelle2
                                   ,0 MtRemiseOpComm
                                   ,0 EnPromotion
                                   ,'0' CodeTVA
                                   ,null numligneresa
                                   ,null CodeActionMarketing
                               FROM HISTORIQUE_CAISSES    hc
                                   ,LBM_TICKET_A_EXTRAIRE ltae
                                   ,STATS_MAGASIN         sm
                              WHERE hc.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets
                                AND hc.TypeLigne IN (1, 2, 4, 7, 9)
                                AND hc.CodeMagasin = ltae.CodeMagasin
                                   -- DLA ajout du TRUNC
                                AND trunc(hc.JourDeVente) = ltae.JourDeVente
                                AND hc.CodeCaisse = ltae.CodeCaisse
                                AND hc.NumTicket = ltae.NumTicket
                                AND sm.CodeMagasin = hc.CodeMagasin
                                AND sm.CodeAxeStat = CodeAxeSteCaisse
                              GROUP BY hc.CodeMagasin
                                      ,hc.JourDeVente
                                      ,hc.CodeCaisse
                                      ,hc.NumTicket
                                      ,sm.CodeElementStat
                                      ,hc.CodeCaissiere
                                      ,hc.CodeClient
                             
                             -- ,hc.CodeCarte
                             --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
                             union all
                             select 'Actions Marketing' TypeInfo
                                   ,smag.CodeElementStat
                                   ,ram.CodeMagasin
                                   ,nvl(hc1.JourDeVente
                                       ,ram.JourDeVente) JourDeVente
                                   ,nvl(hc1.CODECAISSE
                                       ,smag.CODEELEMENTSTAT) CodeCaisse
                                   ,0 CodeCaissiere
                                   ,ram.NumTicket
                                   ,0 CodeNature
                                   ,0 NumLigne
                                   ,
                                    --row_number() over (partition by ram.CODEMAGASIN, ram.JOURDEVENTE, ram.NUMTICKET order by ram.CODEREACTIONMARKETING asc ) NumLigne,
                                    0 CodeInterneArticle
                                   ,ram.CodeClient
                                   ,0 TypeLigne
                                   ,0 CaNetRealise
                                   ,hc2.MTREMISE MtRemise
                                   ,0 MtRemiseReel
                                   ,0 mtremiseligne
                                   ,0 MtRemiseTicket
                                   ,0 MtEscompteLigne
                                   ,0 CodeOpeComm
                                   ,0 Escompte
                                   ,0 CodeVendeur
                                   ,'' CodeSaisie
                                   ,'' CodeClassprod1
                                   ,'' CodeClassProd3
                                   ,'' APPL
                                   ,'' TYPEGEST
                                   ,0 TauxTVA
                                   ,0 MtTva
                                   ,0 VolVente
                                   ,0 ReducType
                                   ,0 RemiseType
                                   ,'' HCA
                                   ,'' LibRedactionMarketing
                                   ,0 CodeTypeActionMarketing
                                   ,0 MotifRetour
                                   ,0 Cheque
                                   ,0 CB
                                   ,'' CodeDevise
                                   ,'' NumPieceIdentite
                                   ,0 PRIXVENTEARTICLECAISSE
                                   ,'' libelle2
                                   ,0 MtRemiseOpComm
                                   ,0 EnPromotion
                                   ,'0' CodeTVA
                                   ,null numligneresa
                                   ,ram.CODEACTIONMARKETING CodeActionMarketing
                               from REACTIONS_MARKETING ram
                              inner join STATS_MAGASIN smag on ram.CODEMAGASIN = smag.CODEMAGASIN
                                                           and smag.CODEAXESTAT = 1
                             
                              inner join LBM_TICKET_A_EXTRAIRE ltae on ram.CODEMAGASIN = ltae.CODEMAGASIN
                                                                   and ram.JOURDEVENTE = ltae.JOURDEVENTE
                                                                   and ram.NUMTICKET = ltae.NUMTICKET
                                                                   and smag.CODEELEMENTSTAT = ltae.CODECAISSE
                             
                              inner join (select distinct h.CODECAISSE
                                                         ,h.CODEMAGASIN
                                                         ,h.JOURDEVENTE
                                                         ,h.NUMTICKET
                                                         ,h.CODECLIENT
                                            from HISTORIQUE_CAISSES h
                                          -- Ajout ERI le 30/08/2016:
                                           where h.JOURDEVENTE >= TRUNC(SYSDATE) - NbJoursTickets
                                          --Fin Ajout ERI le 30/08/2016
                                          ) hc1 on ram.CODEMAGASIN = hc1.CODEMAGASIN
                                               and ram.JOURDEVENTE = trunc(hc1.JOURDEVENTE)
                                               and ram.NUMTICKET = hc1.NUMTICKET
                                               and nvl(ram.CODECLIENT
                                                      ,0) = hc1.CODECLIENT
                                               and smag.CODEELEMENTSTAT = hc1.CODECAISSE
                               left join HISTORIQUE_CAISSES hc2 on ram.CODEMAGASIN = hc2.CODEMAGASIN
                                                               and ram.JOURDEVENTE = trunc(hc2.JOURDEVENTE)
                                                               and ram.NUMTICKET = hc2.NUMTICKET
                                                               and smag.CODEELEMENTSTAT = hc2.CODECAISSE
                                                               and ram.CODEACTIONMARKETING = hc2.CODEACTIONMARKETING
                                                               and hc2.TYPELIGNE = 6
                             /* Suppression ERI le 26/01/2015: cette mecanique est geree dans le decisionnel car la table REACTIONS_MARKETING est purgee
                                                          union all
                                                          -- Recuperation des actions du premier ticket pour les tickets de realisation d'une commande client
                                                        select distinct'Actions Marketing' TypeInfo,
                                                        smag.CodeElementStat,
                                                        ram.CodeMagasin,
                                                        nvl(hc1.JourDeVente,ram.JourDeVente) JourDeVente,
                                                        nvl(hc1.CODECAISSE,smag.CODEELEMENTSTAT ) CodeCaisse,
                                                        0 CodeCaissiere,
                                                        ram.NumTicket,
                                                        0 CodeNature,
                                                        0 NumLigne,
                                                        --row_number() over (partition by ram.CODEMAGASIN, ram.JOURDEVENTE, ram.NUMTICKET order by ram.CODEREACTIONMARKETING asc ) NumLigne,
                                                        0 CodeInterneArticle,
                                                        ram.CodeClient,
                                                        0 TypeLigne,
                                                        0 CaNetRealise,
                                                        0 MtRemise,
                                                        --hc2.MTREMISE MtRemise,
                                                        0 MtRemiseReel,
                                                        0 mtremiseligne,
                                                        0 MtRemiseTicket,
                                                        0 MtEscompteLigne,
                                                        0 CodeOpeComm,
                                                        0 Escompte,
                                                        0 CodeVendeur,
                                                        '' CodeSaisie,
                                                        '' CodeClassprod1,
                                                        '' CodeClassProd3,
                                                        '' APPL,
                                                        '' TYPEGEST,
                                                        0 TauxTVA,
                                                        0 MtTva,
                                                        0 VolVente,
                                                        0 ReducType,
                                                        0 RemiseType,
                                                        '' HCA,
                                                        '' LibRedactionMarketing,
                                                        0 CodeTypeActionMarketing,
                                                        0 MotifRetour,
                                                        0 Cheque,
                                                        0 CB,
                                                        '' CodeDevise,
                                                        '' NumPieceIdentite,
                                                        0 PRIXVENTEARTICLECAISSE,
                                                        '' libelle2,
                                                        0 MtRemiseOpComm,
                                                        0 EnPromotion,
                                                        '0' CodeTVA,
                                                        null numligneresa,
                                                        ram2.CODEACTIONMARKETING CodeActionMarketing
                                                        
                                                        from REACTIONS_MARKETING ram
                                                        inner join STATS_MAGASIN smag on ram.CODEMAGASIN = smag.CODEMAGASIN and
                                                        smag.CODEAXESTAT = 1
                                                        inner join HISTO_OSCC osc on ram.JOURDEVENTE = trunc(osc.DATEMODIFICATION ) and
                                                        ram.CODEMAGASIN = osc.CODECAISSEUTIL and
                                                        ram.NUMTICKET = osc.NUMTICKETUTIL and
                                                        -- Modif ERI le 09/12/2014
                                                        osc.TYPEOSCC = 2
                                                        
                                                        
                                                        
                                                        --                        inner join
                                                        
                                                        --                        (
                                                        --                        select ram2.CODEREACTIONMARKETING, ram2.JOURDEVENTE, ram2.CODEMAGASIN, ram2.NUMTICKET, ram2.CODEACTIONMARKETING, osc2.CODEOSCC
                                                        --                        from REACTIONS_MARKETING ram2
                                                        --                        inner join HISTO_OSCC osc2 on ram2.JOURDEVENTE = trunc(osc2.DATEOSCC) and
                                                        --                                                      ram2.CODEMAGASIN = osc2.CODECAISSE and
                                                        --                                                      to_char(ram2.NUMTICKET) = osc2.NUMEROTICKET and
                                                        --                                                      osc2.NUMTICKETUTIL <> 0
                                                        --
                                                        --                        left join (select *
                                                        --                                    from REACTIONS_MARKETING ram
                                                        --                                    inner join HISTO_OSCC osc on ram.JOURDEVENTE = trunc(osc.DATEMODIFICATION ) and
                                                        --                                                                 ram.CODEMAGASIN = osc.CODECAISSEUTIL and
                                                        --                                                                 ram.NUMTICKET = osc.NUMTICKETUTIL) T1  on osc2.CODEOSCC =  T1.CODEOSCC  and
                                                        --                                                                                                           ram2.CODEACTIONMARKETING = T1.CODEACTIONMARKETING
                                                        --                        where T1.CODEACTIONMARKETING is null
                                                        
                                                        --                        )  T2 on osc.CODEOSCC = T2.CODEOSCC
                                                        
                                                        inner join REACTIONS_MARKETING ram2
                                                        on ram2.JOURDEVENTE = trunc(osc.DATEOSCC) and
                                                        ram2.CODEMAGASIN = substr(lpad(osc.NUMEROTICKET,10,0),1,3) and
                                                        to_char(ram2.NUMTICKET) = osc.NUMEROTICKET
                                                        
                                                        left join (select *
                                                        from REACTIONS_MARKETING ram
                                                        inner join HISTO_OSCC osc2 on ram.JOURDEVENTE = trunc(osc2.DATEMODIFICATION ) and
                                                        ram.CODEMAGASIN = osc2.CODECAISSEUTIL and
                                                        ram.NUMTICKET = osc2.NUMTICKETUTIL and
                                                        osc2.TYPEOSCC = 2 ) T1
                                                        on osc.CODEOSCC =  T1.CODEOSCC
                                                        and  ram2.CODEACTIONMARKETING = T1.CODEACTIONMARKETING
                                                        -- Fin Modif ERI le 09/12/2014
                                                        inner join (select distinct h.CODECAISSE
                                                        ,h.CODEMAGASIN
                                                        ,h.JOURDEVENTE
                                                        ,h.NUMTICKET
                                                        ,h.CODECLIENT
                                                        from HISTORIQUE_CAISSES h) hc1 on  ram.CODEMAGASIN = hc1.CODEMAGASIN and
                                                        ram.JOURDEVENTE = trunc( hc1.JOURDEVENTE ) and
                                                        ram.NUMTICKET = hc1.NUMTICKET and
                                                        nvl(ram.CODECLIENT,0) = hc1.CODECLIENT and
                                                        smag.CODEELEMENTSTAT = hc1.CODECAISSE
                                                        inner join LBM_TICKET_A_EXTRAIRE ltae on ram.CODEMAGASIN = ltae.CODEMAGASIN and
                                                        ram.JOURDEVENTE = ltae.JOURDEVENTE and
                                                        ram.NUMTICKET = ltae.NUMTICKET and
                                                        smag.CODEELEMENTSTAT = ltae.CODECAISSE
                                                        WHERE -- Ajout ERI le 09/12/2014
                                                        T1.CODEACTIONMARKETING is null and
                                                        -- Fin Ajout ERI le 09/12/2014
                                                        hc1.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets
                                                        
                                                        --Fin ajout ERI le 19/12/20103
                                                        Fin Suppression ERI le 26/01/2015 */
                            --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
                            union all
                            select 'Actions Marketing Reponses' TypeInfo
                                  ,smag.CodeElementStat
                                  ,rep.CodeMagasin
                                  ,nvl(hc5.JourDeVente
                                      ,rep.JourDeVente) JourDeVente
                                  ,nvl(hc5.CODECAISSE
                                      ,smag.CODEELEMENTSTAT) CodeCaisse
                                  ,0 CodeCaissiere
                                  ,rep.NumTicket
                                  ,0 CodeNature
                                  ,0 NumLigne
                                  ,
                                   --row_number() over (partition by ram.CODEMAGASIN, ram.JOURDEVENTE, ram.NUMTICKET order by ram.CODEREACTIONMARKETING asc ) NumLigne,
                                   0 CodeInterneArticle
                                  ,rep.CodeClient
                                  ,0 TypeLigne
                                  ,0 CaNetRealise
                                  ,0 MtRemise
                                  ,0 MtRemiseReel
                                  ,0 mtremiseligne
                                  ,0 MtRemiseTicket
                                  ,0 MtEscompteLigne
                                  ,rep.CODEELEMENT CodeOpeComm
                                  ,0 Escompte
                                  ,rep.CODEQUESTION CodeVendeur
                                  ,'' CodeSaisie
                                  ,'' CodeClassprod1
                                  ,'' CodeClassProd3
                                  ,'' APPL
                                  ,'' TYPEGEST
                                  ,0 TauxTVA
                                  ,0 MtTva
                                  ,0 VolVente
                                  ,0 ReducType
                                  ,0 RemiseType
                                  ,'' HCA
                                  ,'' LibRedactionMarketing
                                  ,0 CodeTypeActionMarketing
                                  ,0 MotifRetour
                                  ,0 Cheque
                                  ,0 CB
                                  ,'' CodeDevise
                                  ,'' NumPieceIdentite
                                  ,0 PRIXVENTEARTICLECAISSE
                                  ,rep.VALEUR libelle2
                                  ,0 MtRemiseOpComm
                                  ,0 EnPromotion
                                  ,'0' CodeTVA
                                  ,null numligneresa
                                  ,rep.CODEACTIONMARKETING CodeActionMarketing
                              from REPONSES_ACTIONS_MKT rep
                             inner join STATS_MAGASIN smag on rep.CODEMAGASIN = smag.CODEMAGASIN
                                                          and smag.CODEAXESTAT = 1
                             inner join LBM_TICKET_A_EXTRAIRE ltae on rep.CODEMAGASIN = ltae.CODEMAGASIN
                                                                  and rep.JOURDEVENTE = ltae.JOURDEVENTE
                                                                  and rep.NUMTICKET = ltae.NUMTICKET
                                                                  and smag.CODEELEMENTSTAT = ltae.CODECAISSE
                             inner join (select distinct h.CODECAISSE
                                                        ,h.CODEMAGASIN
                                                        ,h.JOURDEVENTE
                                                        ,h.NUMTICKET
                                                        ,h.CODECLIENT
                                           from HISTORIQUE_CAISSES h
                                         -- Ajout ERI le 30/08/2016:
                                          where h.JOURDEVENTE >= TRUNC(SYSDATE) - NbJoursTickets
                                         --Fin Ajout ERI le 30/08/2016
                                         ) hc5 on rep.CODEMAGASIN = hc5.CODEMAGASIN
                                              and rep.JOURDEVENTE = trunc(hc5.JOURDEVENTE)
                                              and rep.NUMTICKET = hc5.NUMTICKET
                                              and smag.CODEELEMENTSTAT = hc5.CODECAISSE
                            
                             WHERE hc5.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets
                            --Fin Ajout ERI le 19/09/2014
                            union all
                            --Ajout ERI le 02/01/2016: Gestion des attributs tickets
                            select 'Attributs' TypeInfo
                                  ,smag.CodeElementStat
                                  ,hen.CodeMagasin
                                  ,nvl(hc6.JourDeVente
                                      ,hen.JourDeVente) JourDeVente
                                  ,nvl(hc6.CODECAISSE
                                      ,smag.CODEELEMENTSTAT) CodeCaisse
                                  ,0 CodeCaissiere
                                  ,hen.NumTicket
                                  ,0 CodeNature
                                  ,0 NumLigne
                                  ,0 CodeInterneArticle
                                  ,hc6.CodeClient
                                  ,0 TypeLigne
                                  ,0 CaNetRealise
                                  ,0 MtRemise
                                  ,0 MtRemiseReel
                                  ,0 mtremiseligne
                                  ,0 MtRemiseTicket
                                  ,0 MtEscompteLigne
                                  ,0 CodeOpeComm
                                  ,0 Escompte
                                  ,hen.NUMCHAMP CodeVendeur
                                  ,DECODE(hen.NUMCHAMP
                                         ,19
                                         ,REPLACE(hen.elementan
                                                 ,'#'
                                                 ,'|') || '|' || pay.LIBPAYS
                                         ,hen.elementan) CodeSaisie
                                  ,'' CodeClassprod1
                                  ,'' CodeClassProd3
                                  ,'' APPL
                                  ,'' TYPEGEST
                                  ,0 TauxTVA
                                  ,0 MtTva
                                  ,0 VolVente
                                  ,0 ReducType
                                  ,0 RemiseType
                                  ,'' HCA
                                  ,'' LibRedactionMarketing
                                  ,0 CodeTypeActionMarketing
                                  ,0 MotifRetour
                                  ,0 Cheque
                                  ,0 CB
                                  ,'' CodeDevise
                                  ,'' NumPieceIdentite
                                  ,0 PRIXVENTEARTICLECAISSE
                                  ,'' libelle2
                                  ,0 MtRemiseOpComm
                                  ,0 EnPromotion
                                  ,'0' CodeTVA
                                  ,null numligneresa
                                  ,null CodeActionMarketing
                              from HISTO_TIC_ENTETE hen
                             inner join STATS_MAGASIN smag on hen.CODEMAGASIN = smag.CODEMAGASIN
                                                          and smag.CODEAXESTAT = 1
                             inner join LBM_TICKET_A_EXTRAIRE ltae on hen.CODEMAGASIN = ltae.CODEMAGASIN
                                                                  and hen.JOURDEVENTE = ltae.JOURDEVENTE
                                                                  and hen.NUMTICKET = ltae.NUMTICKET
                             inner join (select distinct h.CODECAISSE
                                                        ,h.CODEMAGASIN
                                                        ,h.JOURDEVENTE
                                                        ,h.NUMTICKET
                                                        ,h.CODECLIENT
                                           from HISTORIQUE_CAISSES h
                                          where h.JOURDEVENTE >= TRUNC(SYSDATE) - NbJoursTickets) hc6 on hen.CODEMAGASIN = hc6.CODEMAGASIN
                                                                                                     and hen.JOURDEVENTE = trunc(hc6.JOURDEVENTE)
                                                                                                     and hen.NUMTICKET = hc6.NUMTICKET
                                                                                                     and smag.CODEELEMENTSTAT = hc6.CODECAISSE
                              left join PAYS pay ON hen.ELEMENTN = pay.CODEENMAGASIN
                             where hen.NUMCHAMP = 19
                            --Fin Ajout ERI le 02/01/2016: Gestion des attributs tickets
                            )
                     ORDER BY CodeMagasin
                             ,JourDeVente
                             ,CodeCaisse
                             ,NumTicket
                             ,TypeInfo
                             ,NumLigne) LOOP
        BEGIN
          --*************On teste le caracterer Export ou escompte ou ticket a 0 du ticket
          LeNewTicket := Ligne.NumTicket;
        
          IF (TicketEnErreur = 0)
             OR (LeOldTicket <> LeNewTicket) THEN
            -- DLA le 28/03/2007 si on change de ticket, on commit
            IF LeOldTicket <> LeNewTicket THEN
              --************************ On controle la cohernce du ticket precedent
              IF LeOldTicket <> '-1' THEN
                test_ticket(LaSteCaisseEnCours
                           ,LeNumCaisseEnCours
                           ,LeNumTicketEnCours
                           ,LaDateHTransEnCours);
              END IF;
              LeOldTicket         := LeNewTicket;
              LaSteCaisseEnCours  := Ligne.CodeElementStat;
              LeNumCaisseEnCours  := Ligne.CodeMagasin;
              LeNumTicketEnCours  := TO_NUMBER(SUBSTR(LIGNE.NUMTICKET
                                                     ,4
                                                     ,10));
              LaDateHTransEnCours := Ligne.JourDeVente;
            
              --************************ Fin du controle
            
              TicketEnErreur               := 0;
              EscompteNbLigne              := 0;
              EscompteNbLigneIntermediaire := 1;
              EscompteMtTotal              := 0;
              EscompteMtIntermediaire      := 0;
              EscompteCATicketTotal        := 0;
              BEGIN
                SELECT 1
                      ,MtRemise
                      ,NumLigne
                  INTO TicketEscompte
                      ,EscompteMtTotal
                      ,EscompteNoLigne -- BP 27260
                  FROM HISTORIQUE_CAISSES
                 WHERE CodeMagasin = Ligne.Codemagasin
                   AND JourDeVente = Ligne.JourDeVente
                   AND CodeCaisse = Ligne.CodeCaisse
                   AND NumTicket = Ligne.NumTicket
                   AND TypeLigne = 6
                   AND NumRemise = 99
                   AND ROWNUM = 1;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  TicketEscompte  := 0;
                  EscompteNoLigne := 999;
                WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(-20001
                                         ,'Probleme lors du traitement escompte, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
              END;
            
              IF TicketEscompte = 1 THEN
                BEGIN
                  SELECT SUM(CANETREALISE)
                        ,COUNT(*)
                    INTO EscompteCATicketTotal
                        ,EscompteNbLigne
                    FROM HISTORIQUE_CAISSES
                   WHERE CodeMagasin = Ligne.Codemagasin
                     AND JourDeVente = Ligne.JourDeVente
                     AND CodeCaisse = Ligne.CodeCaisse
                     AND NumTicket = Ligne.NumTicket
                     AND TypeLigne = 1
                     AND NumLigne < EscompteNoLigne; -- BP 27260
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement escompte2, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
              END IF;
            
              BEGIN
                SELECT 1
                  INTO TicketExport
                  FROM HISTORIQUE_CAISSES
                 WHERE CodeMagasin = Ligne.Codemagasin
                   AND JourDeVente = Ligne.JourDeVente
                   AND CodeCaisse = Ligne.CodeCaisse
                   AND NumTicket = Ligne.NumTicket
                   AND TypeLigne = 4
                   AND MotifRetour = 21
                   AND ROWNUM = 1;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  TicketExport := 0;
                WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(-20001
                                         ,'Probleme lors du traitement export, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
              END;
            
              MtTvaKdo      := 0;
              CANETKdo      := 0;
              EANSaisieKdo  := NULL;
              VolVenteKdo   := 0;
              TauxTvaKdo    := 0;
              CodeNatureKdo := 0;
              BEGIN
                SELECT 1
                      ,MotifRetour
                  INTO TicketChange
                      ,TypeChange
                  FROM HISTORIQUE_CAISSES
                 WHERE CodeMagasin = Ligne.Codemagasin
                   AND JourDeVente = Ligne.JourDeVente
                   AND CodeCaisse = Ligne.CodeCaisse
                   AND NumTicket = Ligne.NumTicket
                   AND (((TypeLigne = 7) And (MotifRetour = CodeRecetteChange)) OR ((TypeLigne = 4) And (MotifRetour = CodeDepenseChange)))
                   AND ROWNUM = 1;
              EXCEPTION
                WHEN NO_DATA_FOUND THEN
                  TicketChange := 0;
                WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(-20001
                                         ,'Probleme lors du traitement change, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
              END;
            
              IF TicketChange = 1 THEN
                iLigneVente := iLigneVente + 1;
                IF Ligne.CodeElementStat = 1 THEN
                  LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeLBM;
                END IF;
                IF Ligne.CodeElementStat = 2 THEN
                  LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeSEGEP;
                END IF;
                IF Ligne.CodeElementStat = 3 THEN
                  LeTabLignesVentes(iLigneVente).EANSaisie := EANChangeFF;
                END IF;
                -- recherche d'info sur l'EAN change a) remonter
                BEGIN
                  SELECT cp2.codeclassprod1
                        ,p.codeclassprod3
                    INTO LeTabLignesVentes(iLigneVente) .Departement
                        ,LeTabLignesVentes(iLigneVente) .CP
                    FROM produits     p
                        ,histo_cb_frn hcf
                        ,classprod2   cp2
                        ,classprod3   cp3
                   WHERE hcf.codebarres = LeTabLignesVentes(iLigneVente).EANSaisie
                     AND p.codeproduit = to_char(hcf.codeinternearticle)
                     AND cp3.codeclassprod3 = p.codeclassprod3
                     AND cp2.codeclassprod2 = cp3.codeclassprod2;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement change, recherche du Centre de profit / departement, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
              
                BEGIN
                  SELECT HCA
                        ,APPL
                        ,TYPEGEST
                    INTO LeTabLignesVentes(iLigneVente) .HCA
                        ,LeTabLignesVentes(iLigneVente) .APPL
                        ,LeTabLignesVentes(iLigneVente) .TYPEGEST
                    FROM LBM_CP_HISTO
                   WHERE CP = LeTabLignesVentes(iLigneVente).CP;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement change, recherche du HCA, APPL et TYPEGEST, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
              
                BEGIN
                  SELECT NVL(tp.TauxTVA
                            ,0)
                    INTO LeTabLignesVentes(iLigneVente) .TVATaux
                    FROM TVA_Pays         tp
                        ,TVA_Produit_Pays tpp
                        ,histo_cb_frn     hcf
                   WHERE tp.CodePays = tpp.CodePays
                     AND tp.CodeTVA = tpp.CodeTVA
                     AND tpp.CodePays = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS')
                     AND tpp.CodeProduit = to_char(hcf.codeinternearticle)
                     AND hcf.codebarres = LeTabLignesVentes(iLigneVente).EANSaisie;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement change, recherche du taux de TVA, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
              
                LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat;
                LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente;
                LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin;
                LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket;
                LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente;
                LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
                LeTabLignesVentes(iLigneVente).PrixTTCArt := 0;
                LeTabLignesVentes(iLigneVente).PrixHTArt := 0;
                LeTabLignesVentes(iLigneVente).ExpMont := 0;
                LeTabLignesVentes(iLigneVente).EscMont := 0;
                LeTabLignesVentes(iLigneVente).CaNetLigne := 0;
                LeTabLignesVentes(iLigneVente).TotRemRed := 0;
                LeTabLignesVentes(iLigneVente).TotRemRedHT := 0;
                LeTabLignesVentes(iLigneVente).ReducTotal := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARK := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
                LeTabLignesVentes(iLigneVente).ExpRemise := 0;
                LeTabLignesVentes(iLigneVente).ExpArt := 0;
                LeTabLignesVentes(iLigneVente).NumCdeClt := NULL;
                LeTabLignesVentes(iLigneVente).TvaMont := 0;
                IF TypeChange = 1 THEN
                  LeTabLignesVentes(iLigneVente).Qte := 1;
                END IF;
                IF TypeChange = 2 THEN
                  LeTabLignesVentes(iLigneVente).Qte := -1;
                END IF;
                LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
                LeTabLignesVentes(iLigneVente).PR := NULL;
                LeTabLignesVentes(iLigneVente).ReducType := 0;
                LeTabLignesVentes(iLigneVente).RemiseType := 0;
                LeTabLignesVentes(iLigneVente).RemManuelle := 0;
                LeTabLignesVentes(iLigneVente).NumPlan := 0;
                LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL;
                LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL;
                LeTabLignesVentes(iLigneVente).DatHTopGU := NULL;
                LeTabLignesVentes(iLigneVente).TopArch := NULL;
                LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
                LeTabLignesVentes(iLigneVente).Numplan := Null;
              END IF; -- IF TicketChange = 1 THEN
            
              -- Modif ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres ==> on cree systematiquement une ligne de reglement a 0 avec le
              --                           moyen de paiement "Bon cadeau"  (41) pour gerer les interfaces
              BEGIN
                SELECT COUNT(*)
                  INTO TicketAZero
                  FROM HISTORIQUE_CAISSES
                 WHERE CodeMagasin = Ligne.Codemagasin
                   AND JourDeVente = Ligne.JourDeVente
                   AND CodeCaisse = Ligne.CodeCaisse
                   AND NumTicket = Ligne.NumTicket
                   AND TypeLigne = 9;
                SELECT COUNT(*)
                  INTO TicketRembBonKdoCRM
                  FROM HISTORIQUE_CAISSES
                 WHERE CodeMagasin = Ligne.Codemagasin
                   AND JourDeVente = Ligne.JourDeVente
                   AND CodeCaisse = Ligne.CodeCaisse
                   AND NumTicket = Ligne.NumTicket
                   AND TypeLigne = 7
                   AND MotifRetour = NumRecBonKdoCRM;
                IF (TicketAZero = 0 AND TicketRembBonKdoCRM = 0)
                   OR (TicketAZero = 0 AND TicketRembBonKdoCRM > 0)
                   OR (TicketAZero > 0 AND TicketRembBonKdoCRM > 0) THEN
                  BEGIN
                    iLigneRegl := 1;
                    LeTabLignesRegl(iLigneRegl).SteCaisse := Ligne.CodeElementStat;
                    LeTabLignesRegl(iLigneRegl).DateHTransac := Ligne.JourDeVente;
                    LeTabLignesRegl(iLigneRegl).NumCaisse := Ligne.Codemagasin; --Ligne.CodeCaisse;
                    LeTabLignesRegl(iLigneRegl).NumCaissierTrans := Ligne.CodeCaissiere;
                    LeTabLignesRegl(iLigneRegl).NumTicket := Ligne.NumTicket;
                    LeTabLignesRegl(iLigneRegl).NumLigPaie := 1;
                    LeTabLignesRegl(iLigneRegl).NumCertifCHQ := NULL;
                    LeTabLignesRegl(iLigneRegl).NumAutoCB := NULL;
                    IF TicketRembBonKdoCRM > 0 THEN
                      LeTabLignesRegl(iLigneRegl).PaieMode := 41; -- Bon Cadeaux 24 Sevres
                    ELSE
                      LeTabLignesRegl(iLigneRegl).PaieMode := 11; -- espece par defaut
                    END IF;
                    LeTabLignesRegl(iLigneRegl).PaieMontDev := 0;
                    LeTabLignesRegl(iLigneRegl).PaieMontDev := 0;
                    LeTabLignesRegl(iLigneRegl).Dev := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEDEVISE');
                    LeTabLignesRegl(iLigneRegl).PaieMontDevSte := 0;
                    LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := NULL;
                    LeTabLignesRegl(iLigneRegl).DateMaj := LaDateMiseAJour;
                  END;
                END IF;
              EXCEPTION
                WHEN OTHERS THEN
                  RAISE_APPLICATION_ERROR(-20001
                                         ,'Probleme lors du traitement ticket a zero, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
              END;
              /*
              BEGIN
              SELECT 0 INTO TicketAZero
              FROM HISTORIQUE_CAISSES
              WHERE CodeMagasin  =  Ligne.Codemagasin
              AND   JourDeVente  =  Ligne.JourDeVente
              AND   CodeCaisse  =  Ligne.CodeCaisse
              AND   NumTicket  =  Ligne.NumTicket
              AND   TypeLigne  = 9
              AND   ROWNUM   = 1;
              EXCEPTION
              WHEN NO_DATA_FOUND THEN
              BEGIN
              --************* Si c'est un ticket a 0 (sans ligne de reglement), on en cree une
              iLigneRegl := 1;
              LeTabLignesRegl(iLigneRegl).SteCaisse := Ligne.CodeElementStat;
              LeTabLignesRegl(iLigneRegl).DateHTransac := Ligne.JourDeVente;
              LeTabLignesRegl(iLigneRegl).NumCaisse := Ligne.Codemagasin;--Ligne.CodeCaisse;
              LeTabLignesRegl(iLigneRegl).NumCaissierTrans := Ligne.CodeCaissiere;
              LeTabLignesRegl(iLigneRegl).NumTicket := Ligne.NumTicket;
              LeTabLignesRegl(iLigneRegl).NumLigPaie := 1;
              LeTabLignesRegl(iLigneRegl).NumCertifCHQ := NULL;
              LeTabLignesRegl(iLigneRegl).NumAutoCB := NULL;
              LeTabLignesRegl(iLigneRegl).PaieMode := 11; -- espece par defaut
              LeTabLignesRegl(iLigneRegl).PaieMontDev := 0;
              LeTabLignesRegl(iLigneRegl).PaieMontDev := 0;
              LeTabLignesRegl(iLigneRegl).Dev := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEDEVISE');
              LeTabLignesRegl(iLigneRegl).PaieMontDevSte := 0;
              LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := NULL;
              LeTabLignesRegl(iLigneRegl).DateMaj := LaDateMiseAJour;
              END;
              WHEN OTHERS THEN
              RAISE_APPLICATION_ERROR(-20001, 'Probleme lors du traitement ticket a zero, ticket '||Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
              END;
              */
              --Fin Modif ERI le 17/11/2015
            END IF; -- IF LeOldTicket <> LeNewTicket THEN
          
            BEGIN
              SELECT 1
                INTO TicketClientEnCompte
                FROM HISTORIQUE_CAISSES h
              -- Ajout BF du 14/05/2010 : on controle que le client du ticket est bien en compte
               INNER JOIN CLIENTS c on c.CodeClient = h.CodeClient
                                   and c.ClientCompte = 1
               WHERE h.CodeMagasin = Ligne.Codemagasin
                 AND h.JourDeVente = Ligne.JourDeVente
                 AND h.CodeCaisse = Ligne.CodeCaisse
                 AND h.NumTicket = Ligne.NumTicket
                 AND h.TypeLigne = 9
                    -- Modif BF du 14/05/2010 : ajout des reprises d'acompte pour identifier les tickets de realisation de cmd client en cpte
                    --              ANd   MotifRetour = 61
                 ANd h.MotifRetour IN (61, 36)
                 AND ROWNUM = 1;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                TicketClientEnCompte := 0;
              WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001
                                       ,'Probleme lors du traitement client en compte , ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
            END;
          
            --          --************* On traite les lignes
            IF Ligne.TypeInfo = 'Ligne' THEN
              --****************  On  regarde si il s'agit d'un ticket de livraison
              IF (Ligne.TypeLigne) = 9
                 AND (Ligne.MotifRetour = NUM_REGL_ACPTE) THEN
                CodeSaisieLiv := Ligne.CodeSaisie; -- va declencher le traitement de mis a jour de la structure
                -- FTR le 04/06/2010 recherche du NumCdeClt (Fiche 457)
                BEGIN
                  SELECT DECODE(NVL(REMARQUE
                                   ,'-1')
                               ,'-1'
                               ,CODEOSCC
                               ,SUBSTR(REMARQUE
                                      ,2
                                      ,LENGTH(Remarque)))
                    INTO NumCdeClt
                    FROM HISTO_OSCC
                   WHERE CODEOSCC = Ligne.CODESAISIE;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement ticket de livraison, recherche du NUMCDECLT, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                --Fin FTR le 04/06/2010
              END IF;
            
              --**************** On traite les lignes d'encaissement d'acompte #27260
              IF ((Ligne.TypeLigne = 7) AND ((ligne.MotifRetour = CODE_RECETTE_ACPTE) OR (ligne.MotifRetour = CODE_RECETTE_ACPTE2)))
                 OR ((Ligne.TypeLigne = 4) AND (ligne.MotifRetour = CODE_DEPENSE_ACPTE)) THEN
                IF (Ligne.CodeCaisse = 1) THEN
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_1_LBM;
                  END IF;
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE2) THEN
                    EAN_Encaissement := EAN_ACPTE_2_LBM;
                  END IF;
                  IF (ligne.MotifRetour = CODE_DEPENSE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_3_LBM;
                  END IF;
                END IF;
                IF (Ligne.CodeCaisse = 2) THEN
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_1_SEGEP;
                  END IF;
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE2) THEN
                    EAN_Encaissement := EAN_ACPTE_2_SEGEP;
                  END IF;
                  IF (ligne.MotifRetour = CODE_DEPENSE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_3_SEGEP;
                  END IF;
                END IF;
                IF (Ligne.CodeCaisse = 3) THEN
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_1_FF;
                  END IF;
                  IF (ligne.MotifRetour = CODE_RECETTE_ACPTE2) THEN
                    EAN_Encaissement := EAN_ACPTE_2_FF;
                  END IF;
                  IF (ligne.MotifRetour = CODE_DEPENSE_ACPTE) THEN
                    EAN_Encaissement := EAN_ACPTE_3_FF;
                  END IF;
                END IF;
                -- recherche d'info sur l'EAN
                iLigneVente := iLigneVente + 1;
                BEGIN
                  SELECT cp2.codeclassprod1
                        ,p.codeclassprod3
                    INTO LeTabLignesVentes(iLigneVente) .Departement
                        ,LeTabLignesVentes(iLigneVente) .CP
                    FROM PRODUITS     p
                        ,HISTO_CB_FRN hcf
                        ,CLASSPROD2   cp2
                        ,CLASSPROD3   cp3
                   WHERE hcf.codebarres = EAN_Encaissement
                     AND p.codeproduit = TO_CHAR(hcf.codeinternearticle)
                     AND cp3.codeclassprod3 = p.codeclassprod3
                     AND cp2.codeclassprod2 = cp3.codeclassprod2;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement lignes d''encaissement, recherche du Centre de profit / departement, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                -- recherche du NumCdeClt
                BEGIN
                  SELECT DECODE(NVL(REMARQUE
                                   ,'-1')
                               ,'-1'
                               ,CODEOSCC
                               ,SUBSTR(REMARQUE
                                      ,2
                                      ,LENGTH(Remarque)))
                    INTO NumCdeClt
                    FROM HISTO_OSCC
                   WHERE CODEOSCC = Ligne.CODESAISIE;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement lignes d''encaissement, recherche du NUMCDECLT, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                -- recherche HCA, APPL, TYPEGEST
                BEGIN
                  SELECT HCA
                        ,APPL
                        ,TYPEGEST
                    INTO LeTabLignesVentes(iLigneVente) .HCA
                        ,LeTabLignesVentes(iLigneVente) .APPL
                        ,LeTabLignesVentes(iLigneVente) .TYPEGEST
                    FROM LBM_CP_HISTO
                   WHERE CP = LeTabLignesVentes(iLigneVente).CP
                     AND ROWNUM = 1;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement lignes d''encaissement, recherche du HCA, APPL et TYPEGEST, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
              
                IF ((Ligne.TypeLigne = 7) AND ((ligne.MotifRetour = CODE_RECETTE_ACPTE) OR (ligne.MotifRetour = CODE_RECETTE_ACPTE2))) THEN
                  QteLigneAcompte := 1;
                ELSIF ((Ligne.TypeLigne = 4) AND (ligne.MotifRetour = CODE_DEPENSE_ACPTE)) THEN
                  QteLigneAcompte := -1;
                ELSE
                  QteLigneAcompte := 0;
                END IF;
              
                LeTabLignesVentes(iLigneVente).EANSaisie := EAN_Encaissement;
                LeTabLignesVentes(iLigneVente).PR := 1;
                LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat;
                LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente;
                LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin;
                LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket;
                LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente;
                LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
                LeTabLignesVentes(iLigneVente).TVATaux := Ligne.TauxTva;
                LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
                LeTabLignesVentes(iLigneVente).PrixTTCArt := 0;
                LeTabLignesVentes(iLigneVente).PrixHTArt := 0;
                LeTabLignesVentes(iLigneVente).ExpMont := 0;
                LeTabLignesVentes(iLigneVente).EscMont := 0;
                LeTabLignesVentes(iLigneVente).CaNetLigne := Ligne.CaNetRealise;
                LeTabLignesVentes(iLigneVente).CaNetLigneHT := Ligne.CaNetRealise - Ligne.MtTVA;
                LeTabLignesVentes(iLigneVente).TotRemRed := 0;
                LeTabLignesVentes(iLigneVente).TotRemRedHT := 0;
                LeTabLignesVentes(iLigneVente).ReducTotal := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARK := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
                LeTabLignesVentes(iLigneVente).ExpRemise := 0;
                LeTabLignesVentes(iLigneVente).ExpArt := 0;
                LeTabLignesVentes(iLigneVente).NumCdeClt := NumCdeClt;
                LeTabLignesVentes(iLigneVente).TvaMont := 0;
                LeTabLignesVentes(iLigneVente).Qte := QteLigneAcompte;
                LeTabLignesVentes(iLigneVente).ReducType := 0;
                LeTabLignesVentes(iLigneVente).RemiseType := 0;
                LeTabLignesVentes(iLigneVente).RemManuelle := 0;
                LeTabLignesVentes(iLigneVente).NumPlan := 0;
                LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL;
                LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL;
                LeTabLignesVentes(iLigneVente).DatHTopGU := NULL;
                LeTabLignesVentes(iLigneVente).TopArch := NULL;
                LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
                LeTabLignesVentes(iLigneVente).Numplan := NULL;
              END IF;
              --**************** On traite les lignes de vente de carte cadeau
              --Modif BF du 01/10/12 : le ctrl se fait sur le debut du numero d'oscc et non plus sur l'enseigne de la caisse
              --Modif MTI  le 03/12/2012  pour ajouter NumRecCarteKDO_SEGEP et NumRecCarteKDO_FF
              --dans le cadre de l'achat des cartes CKDO SEGEP sur des caisses BM
              --IF (Ligne.TypeLigne = 7) and (ligne.MotifRetour = NumRecCarteKDO) THEN
              IF (Ligne.TypeLigne = 7)
                 and (ligne.MotifRetour = NumRecCarteKDO or ligne.motifretour = NumRecCarteKDO_SEGEP or ligne.motifretour = NumRecCarteKDO_FF
                 --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
                 or ligne.motifretour = NumRecBonKdoCRM
                 --Fin Ajout ERI le 17/11/2015
                 ) THEN
                --fin mti
                -- Fin modif BF du 01/10/2012
              
                BEGIN
                  SELECT 1
                        ,NVL(hc.MTTVA
                            ,0)
                        ,hc.CaNetRealise
                        ,hc.CodeSaisie
                        ,hc.VolVente
                        ,NVL(tp.tauxTva
                            ,0)
                        ,hc.CodeNature
                    INTO CarteCadeau
                        ,MtTvaKdo
                        ,CANetKDO
                        ,EANSaisieKdo
                        ,VolVenteKdo
                        ,TauxTvaKdo
                        ,CodeNatureKdo
                    FROM HISTORIQUE_CAISSES hc
                        ,TVA_PAYS           tp
                   WHERE tp.CodeTVA(+) = hc.CodeTVA
                     AND tp.CodePays(+) = PK_SITE.RetourneParametreSiteVarchar('CODEPAYS')
                     AND hc.CodeMagasin = Ligne.Codemagasin
                     AND hc.JourDeVente = Ligne.JourDeVente
                     AND hc.CodeCaisse = Ligne.CodeCaisse
                     AND hc.NumTicket = Ligne.NumTicket
                     AND hc.numligne = ligne.numligne
                     AND hc.TypeLigne = 7
                     AND hc.MotifRetour in (NumRecCarteKDO
                                           ,NumRecCarteKDO_SEGEP
                                           ,NumRecCarteKDO_FF
                                            --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
                                           ,NumRecBonKdoCRM
                                            --Fin Ajout ERI le 17/11/2015
                                            );
                EXCEPTION
                  WHEN NO_DATA_FOUND THEN
                    CarteCadeau := 0;
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement carte cadeau, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                iLigneVente := iLigneVente + 1;
                -- recherche d'info sur l'EAN
                BEGIN
                  SELECT cp2.codeclassprod1
                        ,p.codeclassprod3
                    INTO LeTabLignesVentes(iLigneVente) .Departement
                        ,LeTabLignesVentes(iLigneVente) .CP
                    FROM PRODUITS     p
                        ,HISTO_CB_FRN hcf
                        ,CLASSPROD2   cp2
                        ,CLASSPROD3   cp3
                  /*               Modif BF du 01/10/12 : le ctrl se fait sur le debut du numero d'oscc et non plus sur l'enseigne de la caisse
                                    1er caractere oscc = type oscc
                                    7 = BM
                                    8 = Segep
                                    9 = FF
                                    */
                   WHERE hcf.codebarres = DECODE(substr(EANSaisieKdo
                                                       ,1
                                                       ,1)
                                                ,'7'
                                                ,EANCarteKdo_BM
                                                ,DECODE(substr(EANSaisieKdo
                                                              ,1
                                                              ,1)
                                                       ,'8'
                                                       ,EANCarteKdo_SEGEP
                                                       ,DECODE(substr(EANSaisieKdo
                                                                     ,1
                                                                     ,1)
                                                              ,'9'
                                                              ,EANCarteKdo_FF
                                                              ,
                                                               --Ajout ERI le 17/11/2015 = Gestion Remboursement en Bon Cadeaux 24 Sevres
                                                               DECODE(substr(EANSaisieKdo
                                                                            ,1
                                                                            ,1)
                                                                     ,'4'
                                                                     ,EANBonKdoCRM)
                                                               --Fin Ajout ERI le 17/11/2015
                                                               )))
                        --        Fin modif BF du 01/10/2012
                        /*   WHERE hcf.codebarres = DECODE(Ligne.CodeCaisse,1,EANCarteKdo_BM,
                                                DECODE(Ligne.CodeCaisse,2,EANCarteKdo_SEGEP,
                                                DECODE(Ligne.CodeCaisse,3,EANCarteKdo_FF)))*/
                        
                     AND p.codeproduit = TO_CHAR(hcf.codeinternearticle)
                     AND cp3.codeclassprod3 = p.codeclassprod3
                     AND cp2.codeclassprod2 = cp3.codeclassprod2;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement carte cadeau, recherche du Centre de profit / departement, ticket ' || EANSaisieKdo || '-' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                --Ajouter_Log(3, 'BIZ-0005', LeTabLignesVentes(iLigneVente).CP);
                BEGIN
                  SELECT HCA
                        ,APPL
                        ,TYPEGEST
                    INTO LeTabLignesVentes(iLigneVente) .HCA
                        ,LeTabLignesVentes(iLigneVente) .APPL
                        ,LeTabLignesVentes(iLigneVente) .TYPEGEST
                    FROM LBM_CP_HISTO
                   WHERE CP = LeTabLignesVentes(iLigneVente).CP
                     AND ROWNUM = 1;
                EXCEPTION
                  WHEN OTHERS THEN
                    RAISE_APPLICATION_ERROR(-20001
                                           ,'Probleme lors du traitement carte cadeau, recherche du HCA, APPL et TYPEGEST, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                LeTabLignesVentes(iLigneVente).EANSaisie := EANSaisieKdo;
                LeTabLignesVentes(iLigneVente).PR := 1;
                LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat;
                LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente;
                LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin;
                LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket;
                LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente;
                LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
                LeTabLignesVentes(iLigneVente).TVATaux := TauxTvaKdo;
                LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
              
                LeTabLignesVentes(iLigneVente).PrixTTCArt := CANetKDO;
                LeTabLignesVentes(iLigneVente).PrixHTArt := CANetKDO - MtTVAKdo;
                LeTabLignesVentes(iLigneVente).ExpMont := 0;
                LeTabLignesVentes(iLigneVente).EscMont := 0;
                LeTabLignesVentes(iLigneVente).CaNetLigne := CANetKDO;
                LeTabLignesVentes(iLigneVente).CaNetLigneHT := CANetKDO - MtTVAKdo;
              
                LeTabLignesVentes(iLigneVente).TotRemRed := 0;
                LeTabLignesVentes(iLigneVente).TotRemRedHT := 0;
                LeTabLignesVentes(iLigneVente).ReducTotal := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARK := 0;
                LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
                LeTabLignesVentes(iLigneVente).ExpRemise := 0;
                LeTabLignesVentes(iLigneVente).ExpArt := 0;
                LeTabLignesVentes(iLigneVente).NumCdeClt := NULL;
                LeTabLignesVentes(iLigneVente).TvaMont := MtTVAKdo;
                LeTabLignesVentes(iLigneVente).Qte := VolVenteKdo;
                LeTabLignesVentes(iLigneVente).ReducType := 0;
                LeTabLignesVentes(iLigneVente).RemiseType := 0;
                LeTabLignesVentes(iLigneVente).RemManuelle := 0;
                LeTabLignesVentes(iLigneVente).NumPlan := 0;
                LeTabLignesVentes(iLigneVente).ActMarkLibReduit := NULL;
                LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := NULL;
                LeTabLignesVentes(iLigneVente).DatHTopGU := NULL;
                LeTabLignesVentes(iLigneVente).TopArch := NULL;
                LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
                LeTabLignesVentes(iLigneVente).Numplan := NULL;
              END IF;
              -- fin traitement carte cadeau
            
              --**************** On traite les lignes de vente ou de retour
              IF (Ligne.TypeLigne = 1)
                 OR (Ligne.TypeLigne = 2) THEN
                IF TicketClientEnCompte = 1
                   AND PreNumerotation = 1 THEN
                
                  -- Ajout BF du 14/05/2010 : on ajoute la prenumerotation meme pour les lignes d'acompte et rembt d'acompte
                  /*IF TicketClientEnCompte =1 AND PreNumerotation = 1 AND (
                  ((Ligne.TypeLigne = 7) AND ((ligne.MotifRetour = CODE_RECETTE_ACPTE) OR (ligne.MotifRetour = CODE_RECETTE_ACPTE2))) OR
                  ((Ligne.TypeLigne = 4) AND (ligne.MotifRetour = CODE_DEPENSE_ACPTE)) OR (Ligne.TypeLigne = 1) OR (Ligne.TypeLigne = 2)
                  ) THEN*/
                  BEGIN
                    SELECT NUMFACTURE
                      Into NumFacture
                      FROM NUM_FACTURE_TICKET
                     WHERE CodeMagasin = Ligne.CodeMagasin
                       AND JourDeVente = Ligne.JourDeVente
                       AND CodeCaisse = Ligne.CodeCaisse
                       AND NumTicket = Ligne.NumTicket
                       AND TypeFacture = DECODE(Ligne.TypeLigne
                                               ,1
                                               ,0
                                               ,1); --DECODE(Ligne.TypeLigne,1,0,7,0,1); -- ajout recette => facture
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      NumFacture := 0;
                  END;
                  IF NumFacture = 0 THEN
                    BEGIN
                      INSERT INTO NUM_FACTURE_TICKET
                        (CODEMAGASIN
                        ,JOURDEVENTE
                        ,CODECAISSE
                        ,NUMTICKET
                        ,TYPEFACTURE
                        ,NUMFACTURE)
                      VALUES
                        (Ligne.CodeMagasin
                        ,Ligne.JourDeVente
                        ,Ligne.CodeCaisse
                        ,Ligne.NumTicket
                        ,DECODE(Ligne.TypeLigne
                               ,1
                               ,0
                               ,1)
                        , --DECODE(Ligne.TypeLigne,1,0,7,0,1), -- ajout recette => facture
                         -- FTR le 11/10/2010 pour gerer les sequences de factures client compte / societe
                         -- Si codecaisse = 1 (LBM) on envoi 998
                         -- Si codecaisse = 2 (SEGEP) on envoi 999
                         -- Si codecaisse = 3 (FF) on envoi 997
                         --Retourne_NumFactClientSuivant(Ligne.CodeMagasin)
                         Retourne_NumFactClientSuivant(DECODE(Ligne.CodeCaisse
                                                             ,1
                                                             ,998
                                                             ,2
                                                             ,999
                                                             ,3
                                                             ,997))
                         -- Fin FTR le 11/10/2010
                         );
                    EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        NULL;
                      WHEN OTHERS THEN
                        RAISE_APPLICATION_ERROR(-20001
                                               ,'Probleme lors de l''insertion du numero de facture client, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                    END;
                  END IF;
                END IF;
              
              END IF;
              -- Fin Ajout BF du 14/05/10
              --**************** On traite les lignes de vente ou de retour
              IF (Ligne.TypeLigne = 1)
                 OR (Ligne.TypeLigne = 2) THEN
                -- Suppression BF du 14/05/10 la prenumerotation est traitee plus haut avec l'ajout des reprises d'acomptes
                /*
                IF TicketClientEnCompte =1 AND PreNumerotation = 1 THEN
                BEGIN
                SELECT NUMFACTURE Into NumFacture
                FROM NUM_FACTURE_TICKET
                WHERE CodeMagasin = Ligne.CodeMagasin
                AND   JourDeVente =Ligne.JourDeVente
                AND   CodeCaisse = Ligne.CodeCaisse
                AND   NumTicket = Ligne.NumTicket
                AND   TypeFacture = DECODE(Ligne.TypeLigne,1,0,1);
                EXCEPTION
                WHEN NO_DATA_FOUND THEN
                NumFacture := 0     ;
                END;
                IF NumFacture = 0 THEN
                BEGIN
                INSERT INTO NUM_FACTURE_TICKET
                (CODEMAGASIN,
                JOURDEVENTE,
                CODECAISSE,
                NUMTICKET,
                TYPEFACTURE,
                NUMFACTURE)
                VALUES
                (Ligne.CodeMagasin,
                Ligne.JourDeVente,
                Ligne.CodeCaisse,
                Ligne.NumTicket,
                DECODE(Ligne.TypeLigne,1,0,1),
                Retourne_NumFactClientSuivant(Ligne.CodeMagasin)
                );
                EXCEPTION
                WHEN DUP_VAL_ON_INDEX THEN NULL;
                WHEN OTHERS THEN
                RAISE_APPLICATION_ERROR(-20001, 'Probleme lors de l''insertion du numero de facture client, ticket '||Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                END;
                END IF;
                END IF;
                */
                -- Fin Suppression BF du 14/05/10
              
                --************* On traite les lignes
                --DLA le 01/03/2007 : recherche du libelle de l'opecomm
                IF Ligne.CodeOpeComm > 0 THEN
                  BEGIN
                    SELECT LibOpeComm INTO LePlanLib FROM OPERATIONS_COMMERCIALES WHERE CODEOPECOMM = Ligne.CodeOpeComm;
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      BEGIN
                        SELECT LibOpeComm INTO LePlanLib FROM INT_OPERATIONS_COMMERCIALES WHERE CODEOPECOMM = Ligne.CodeOpeComm;
                      EXCEPTION
                        WHEN NO_DATA_FOUND THEN
                          LePlanLib := 'INCONNU';
                      END;
                  END;
                END IF;
              
                Ligne.MtRemiseReel := Ligne.MtRemiseReel + Ligne.MtRemiseOpcomm;
                -- Ligne de vente ou de retour
                iLigneVente := iLigneVente + 1;
              
                --******************* Donnees diverses
              
                LeTabLignesVentes(iLigneVente).SteCaisse := Ligne.CodeElementStat;
                LeTabLignesVentes(iLigneVente).DateHTrans := Ligne.JourDeVente;
                LeTabLignesVentes(iLigneVente).NumCaisse := Ligne.CodeMagasin; --Ligne.CodeCaisse;
                LeTabLignesVentes(iLigneVente).NumTicket := Ligne.NumTicket;
                LeTabLignesVentes(iLigneVente).NumLigne := iLigneVente;
                LeTabLignesVentes(iLigneVente).CodeVend := Ligne.CodeVendeur;
                --DLA le 15/05/2007 : on prend Libelle2
                --                  LeTabLignesVentes(iLigneVente).EANSaisie := Ligne.CodeSaisie;
                LeTabLignesVentes(iLigneVente).EANSaisie := Ligne.Libelle2;
                LeTabLignesVentes(iLigneVente).Departement := Ligne.CodeClassProd1;
                LeTabLignesVentes(iLigneVente).CP := Ligne.CodeClassProd3;
              
                --******************* Traitement du montant de l'export a la ligne
                --******************* Export sur CABrut, sur CANet et sur remise
              
                IF TicketExport = 1 THEN
                  IF Ligne.TypeLigne = 1 THEN
                    LeTabLignesVentes(iLigneVente).ExpRemise := round(Ligne.MtRemiseReel * (1 - (1 / (1 + Ligne.TauxTVA / 100)))
                                                                     ,2);
                    LeTabLignesVentes(iLigneVente).ExpMont := Ligne.MtTVA;
                    LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).ExpRemise + LeTabLignesVentes(iLigneVente).ExpMont;
                  END IF;
                  IF Ligne.TypeLigne = 2 THEN
                    LeTabLignesVentes(iLigneVente).ExpRemise := -round(Ligne.MtRemiseReel * (1 - (1 / (1 + Ligne.TauxTVA / 100)))
                                                                      ,2);
                    LeTabLignesVentes(iLigneVente).ExpMont := -Ligne.MtTVA;
                    LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).ExpRemise + LeTabLignesVentes(iLigneVente).ExpMont;
                  END IF;
                ELSE
                  LeTabLignesVentes(iLigneVente).ExpMont := 0;
                  LeTabLignesVentes(iLigneVente).ExpArt := 0;
                  LeTabLignesVentes(iLigneVente).ExpRemise := 0;
                END IF;
              
                --******************* Traitement du montant de l'escompte a la ligne
                --******************* Si ligne de retour, le montant de l'escompte est 0
                IF TicketEscompte = 1 THEN
                  IF Ligne.TypeLigne = 1 THEN
                    IF EscompteNbLigneIntermediaire <= EscompteNbLigne THEN
                      LeTabLignesVentes(iLigneVente).EscMont := ceil((Ligne.CaNetRealise / EscompteCATicketTotal) * EscompteMtTotal * 100) / 100;
                      EscompteMtIntermediaire := EscompteMtIntermediaire + LeTabLignesVentes(iLigneVente).EscMont;
                      EscompteNbLigneIntermediaire := EscompteNbLigneIntermediaire + 1;
                      IF EscompteMtIntermediaire > EscompteMtTotal THEN
                        LeTabLignesVentes(iLigneVente).EscMont := LeTabLignesVentes(iLigneVente).EscMont + EscompteMtTotal - EscompteMtIntermediaire;
                        EscompteMtIntermediaire := EscompteMtTotal;
                      END IF;
                    ELSE
                      LeTabLignesVentes(iLigneVente).EscMont := 0;
                    END IF;
                  END IF;
                  IF Ligne.TypeLigne = 2 THEN
                    LeTabLignesVentes(iLigneVente).EscMont := 0;
                  END IF;
                ELSE
                  LeTabLignesVentes(iLigneVente).EscMont := 0;
                END IF;
              
                --******************* Traitement du CANET par ligne
              
                --DLA le 13/03/2007 : pour les tickets export, on retire la TVA sur le CANet et les mtremise
                -- Si le ticket contient de l'escompte, on retire l'escompte des remise avant ce calcul
              
                IF Ligne.TypeLigne = 1 THEN
                  LeTabLignesVentes(iLigneVente).CaNetLigne := Ligne.CaNetRealise - LeTabLignesVentes(iLigneVente).ExpMont;
                  LeTabLignesVentes(iLigneVente).CaNetLigneHT := Ligne.CaNetRealise - Ligne.MtTVA;
                END IF;
                IF Ligne.TypeLigne = 2 THEN
                  LeTabLignesVentes(iLigneVente).CaNetLigne := -Ligne.CaNetRealise - LeTabLignesVentes(iLigneVente).ExpMont;
                  LeTabLignesVentes(iLigneVente).CaNetLigneHT := - (Ligne.CaNetRealise - Ligne.MtTVA);
                END IF;
              
                --******************* Traitement de la somme des remises par lignes
              
                IF Ligne.TypeLigne = 1 THEN
                  LeTabLignesVentes(iLigneVente).TotRemRed := Ligne.MtRemiseReel + LeTabLignesVentes(iLigneVente).ExpMont;
                  LeTabLignesVentes(iLigneVente).TotRemRedHT := (Ligne.MtRemiseReel / (1 + (Ligne.TauxTVA / 100))); --+  LeTabLignesVentes(iLigneVente).ExpMont;
                END IF;
                IF Ligne.TypeLigne = 2 THEN
                  LeTabLignesVentes(iLigneVente).TotRemRed := -Ligne.MtRemiseReel + LeTabLignesVentes(iLigneVente).ExpMont;
                  LeTabLignesVentes(iLigneVente).TotRemRedHT := - (Ligne.MtRemiseReel / (1 + (Ligne.TauxTVA / 100))); --(LeTabLignesVentes(iLigneVente).TotRemRed / (1 + (Ligne.TauxTVA / 100)));
                END IF;
              
                --******************* Traitement du CABrut
              
                LeTabLignesVentes(iLigneVente).PrixTTCArt := LeTabLignesVentes(iLigneVente).CaNetLigne + LeTabLignesVentes(iLigneVente).TotRemRed;
                LeTabLignesVentes(iLigneVente).PrixHTArt := LeTabLignesVentes(iLigneVente).PrixTTCArt - round((LeTabLignesVentes(iLigneVente).PrixTTCArt * (1 - (1 / (1 + (Ligne.TauxTVA / 100)))))
                                                                                                             ,2);
                -- ========================================
                -- BFU le 28/5/2007 modification calcul expart en fonction du TTC - HT et expremise par difference entre expart et expmont
                IF TicketExport = 1 THEN
                  LeTabLignesVentes(iLigneVente).ExpArt := LeTabLignesVentes(iLigneVente).PrixTTCArt - LeTabLignesVentes(iLigneVente).PrixHTArt;
                  LeTabLignesVentes(iLigneVente).ExpRemise := LeTabLignesVentes(iLigneVente).ExpArt - LeTabLignesVentes(iLigneVente).ExpMont;
                END IF;
                -- ========================================
                --******************* Traitement du montant des actions marketing par ligne
              
                IF Ligne.LibRedactionMarketing IS NOT NULL THEN
                  IF Ligne.TypeLigne = 1 THEN
                    LeTabLignesVentes(iLigneVente).MONTACTMARK := Ligne.MtRemiseLigne;
                    LeTabLignesVentes(iLigneVente).MONTACTMARKHT := LeTabLignesVentes(iLigneVente).MONTACTMARK / (1 + (Ligne.TauxTVA / 100));
                  END IF;
                  IF Ligne.TypeLigne = 2 THEN
                    LeTabLignesVentes(iLigneVente).MONTACTMARK := -Ligne.MtRemiseLigne;
                    LeTabLignesVentes(iLigneVente).MONTACTMARKHT := - (LeTabLignesVentes(iLigneVente).MONTACTMARK / (1 + (Ligne.TauxTVA / 100)));
                  END IF;
                ELSE
                  LeTabLignesVentes(iLigneVente).MONTACTMARK := 0;
                  LeTabLignesVentes(iLigneVente).MONTACTMARKHT := 0;
                END IF;
              
                --******************* Autres donnees
              
                LeTabLignesVentes(iLigneVente).Appl := Ligne.Appl;
                LeTabLignesVentes(iLigneVente).TypeGest := Ligne.TypeGest;
                LeTabLignesVentes(iLigneVente).NumCdeClt := NULL;
                LeTabLignesVentes(iLigneVente).TvaTaux := Ligne.TauxTVA;
                IF Ligne.TypeLigne = 1 THEN
                  LeTabLignesVentes(iLigneVente).TvaMont := Ligne.MtTVA;
                END IF;
                IF Ligne.TypeLigne = 2 THEN
                  LeTabLignesVentes(iLigneVente).TvaMont := -Ligne.MtTVA;
                END IF;
                IF Ligne.TypeLigne = 1 THEN
                  LeTabLignesVentes(iLigneVente).Qte := Ligne.VolVente;
                  --DLA le 12/05/2007 : ajout du motif de retour
                  LeTabLignesVentes(iLigneVente).MotifRetour := NULL;
                END IF;
                IF Ligne.TypeLigne = 2 THEN
                  LETABLIGNESVENTES(ILIGNEVENTE).QTE := -LIGNE.VOLVENTE;
                  --DLA LE 12/05/2007 : AJOUT DU MOTIF DE RETOUR
                  LETABLIGNESVENTES(ILIGNEVENTE).MOTIFRETOUR := LIGNE.MOTIFRETOUR;
                END IF;
              
                LeTabLignesVentes(iLigneVente).PR := Ligne.CodeNature; -- Nature Article, dev ulterieur
                -- DLA le 15/03/2007 suite appel N.RAspal
              
                --******************* Si la remise lignes est en montant, on renseigne REDUCTOTAL
              
                IF Ligne.ReducType <> 0 THEN
                  IF Ligne.TypeLigne = 1 THEN
                    LeTabLignesVentes(iLigneVente).ReducTotal := Ligne.MtRemiseLigne;
                  END IF;
                  IF Ligne.TypeLigne = 2 THEN
                    LeTabLignesVentes(iLigneVente).ReducTotal := -Ligne.MtRemiseLigne;
                  END IF;
                END IF;
              
                --******************* recherche du code de la remise la plus avantageuse
              
                LeTabLignesVentes(iLigneVente).ReducType := 0;
                LeTabLignesVentes(iLigneVente).RemiseType := 0;
                --DLA le 16/05/2007 : impact de la "remise" opcomm
                IF Ligne.MtRemiseLigne > (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN
                  IF Ligne.RemiseType <> CodeRemiseEscompte THEN
                    LeTabLignesVentes(iLigneVente).RemiseType := Ligne.RemiseType;
                    LeTabLignesVentes(iLigneVente).ReducType := Ligne.ReducType;
                  ELSE
                    LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseEscompte;
                    LeTabLignesVentes(iLigneVente).ReducType := 0;
                  END IF;
                ELSE
                  IF Ligne.RemiseType <> 0 THEN
                    -- JCO 26/06/2009 : attribution du code remise le plus avantageux
                    -- JCO --LeTabLignesVentes(iLigneVente).RemiseType := 56;
                    IF nvl(Ligne.numligneresa
                          ,0) <> 0 THEN
                      -- Extraction du type de remise pour les enlevements d'article commande
                      LeTabLignesVentes(iLigneVente).RemiseType := Ligne.RemiseType;
                    ELSE
                      -- Extraction du code de premier avantage de type remise
                      -- pour l'action marketing appliqu?e a la ligne d'article
                      SELECT COUNT(*)
                        INTO Compteur
                        FROM LIGNES_AVANTAGE_ACTION_MKT laam
                            ,TYPES_REMISE               tr
                       WHERE tr.CodeTypeRemise = laam.CodeTypeRemise
                         AND laam.CodeActionMarketing = Ligne.CodeActionMarketing;
                    
                      IF (Compteur <> 0) THEN
                        SELECT laam.CodeTypeRemise
                          INTO LeTabLignesVentes(iLigneVente) .RemiseType
                          FROM LIGNES_AVANTAGE_ACTION_MKT laam
                              ,TYPES_REMISE               tr
                         WHERE tr.CodeTypeRemise = laam.CodeTypeRemise
                           AND laam.CodeActionMarketing = Ligne.CodeActionMarketing
                           AND ROWNUM = 1;
                      ELSE
                        LeTabLignesVentes(iLigneVente).RemiseType := Ligne.RemiseType;
                      END IF;
                    END IF;
                    -- Fin modif JCO
                  
                    LeTabLignesVentes(iLigneVente).ReducType := 0;
                  END IF;
                  IF Ligne.ReducType <> 0 THEN
                    LeTabLignesVentes(iLigneVente).ReducType := 56;
                    LeTabLignesVentes(iLigneVente).RemiseType := 0;
                  END IF;
                END IF;
              
                -- DLA le 15/05/2007 : comparaison egalement avec le code remise parametre pour
                -- la remise lie a une OpComm en %
              
                IF Ligne.MtRemiseLigne >= (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN
                  IF Ligne.MtRemiseLigne < Ligne.MtRemiseOpComm THEN
                    LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseOpComm;
                    LeTabLignesVentes(iLigneVente).ReducType := 0;
                  END IF;
                END IF;
              
                IF Ligne.MtRemiseLigne < (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) THEN
                  IF (Ligne.MtRemiseReel - Ligne.MtRemiseLigne - Ligne.MtRemiseOpcomm) < Ligne.MtRemiseOpComm THEN
                    LeTabLignesVentes(iLigneVente).RemiseType := CodeRemiseOpComm;
                    LeTabLignesVentes(iLigneVente).ReducType := 0;
                  END IF;
                END IF;
              
                --******************* Autres donnees
              
                LeTabLignesVentes(iLigneVente).RemManuelle := 0;
                LeTabLignesVentes(iLigneVente).NumPlan := 0;
                LeTabLignesVentes(iLigneVente).HCA := Ligne.HCA;
                LeTabLignesVentes(iLigneVente).ActMarkLibReduit := Ligne.LibRedactionMarketing;
                LeTabLignesVentes(iLigneVente).ActMarkCodeDuType := Ligne.CodeTypeActionMarketing;
                LeTabLignesVentes(iLigneVente).DatHTopGU := NULL;
                LeTabLignesVentes(iLigneVente).TopArch := NULL;
                LeTabLignesVentes(iLigneVente).DateMaj := LaDateMiseAJour;
                --DLA le 01/03/2007
                LeTabLignesVentes(iLigneVente).Numplan := LePlanLib;
              
                --******************* Traitement des lignes de reglement
              
              ELSIF Ligne.TypeLigne = 9 THEN
              
                iLigneRegl := iLigneRegl + 1;
              
                LeTabLignesRegl(iLigneRegl).SteCaisse := Ligne.CodeElementStat;
                LeTabLignesRegl(iLigneRegl).DateHTransac := Ligne.JourDeVente;
                LeTabLignesRegl(iLigneRegl).NumCaisse := Ligne.Codemagasin; --Ligne.CodeCaisse;
                LeTabLignesRegl(iLigneRegl).NumCaissierTrans := Ligne.CodeCaissiere;
                LeTabLignesRegl(iLigneRegl).NumTicket := Ligne.NumTicket;
                LeTabLignesRegl(iLigneRegl).NumLigPaie := iLigneRegl;
              
                -- DLA le 23/07/2007 : info pour les tickets de change
              
                IF Ligne.Cheque = 1 THEN
                  --FTR le 11/05/2010 pour envoyer le n? d'autorisation des cheques auto (MP25) dans le bon champ
                  --LeTabLignesRegl(iLigneRegl).NumCertifCHQ := Ligne.NumPieceIdentite;
                  IF Ligne.MotifRetour = 25 THEN
                    LeTabLignesRegl(iLigneRegl).NumCertifCHQ := Ligne.CodeSaisie;
                  ELSE
                    LeTabLignesRegl(iLigneRegl).NumCertifCHQ := Ligne.NumPieceIdentite;
                  END IF;
                  --Fin FTR le 11/05/2010
                ELSE
                  LeTabLignesRegl(iLigneRegl).NumCertifCHQ := NULL;
                END IF;
              
                IF TicketChange = 1 THEN
                  --Modif DLA le 27/12/2007 : on renseigne TICKETCHANGE a present
                  --                LeTabLignesRegl(iLigneRegl).NumCertifCHQ := '1';
                  LeTabLignesRegl(iLigneRegl).TICKETCHANGE := 1;
                END IF;
              
                LeTabLignesRegl(iLigneRegl).PaieMode := Ligne.MotifRetour;
              
                --DLA le 13/03/2007 : correction sur la remontee du CA en devise
                IF Ligne.MtRemise <> 0 THEN
                  LeTabLignesRegl(iLigneRegl).PaieMontDev := Ligne.MtRemise;
                  BEGIN
                    SELECT CODEDEVISE
                      INTO LeTabLignesRegl(iLigneRegl) .Dev
                      FROM MODES_REGL_MAGASIN_PAYS
                     WHERE CODEPAYS = PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEPAYS')
                       AND CODEMODEREGLEMENTMAG = Ligne.MotifRetour;
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      RAISE_APPLICATION_ERROR(-20001
                                             ,'Pas de devise pour le mode de reglement ' || Ligne.MotifRetour);
                  END;
                ELSE
                  LeTabLignesRegl(iLigneRegl).PaieMontDev := Ligne.CaNetRealise;
                  LeTabLignesRegl(iLigneRegl).Dev := PK_SITE.RETOURNEPARAMETRESITEVARCHAR('CODEDEVISE');
                END IF;
              
                LeTabLignesRegl(iLigneRegl).PaieMontDevSte := Ligne.CaNetRealise;
              
                --******************* Si paiement par cheque KDO ou liste de mariage
                --******************* On recalcule le numero de cheque ou carte a renvoyer
              
                IF Ligne.MotifRetour IN (62, 65) THEN
                  --               LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr(Ligne.CodeSaisie, 2, 8));
                  -- BFU le 31/05/2007 : correction bug sur extraction du numero de cheque cadeau (la suppression des zeros de fin ne fonctionnement pas lorsque le modulo de l'ean8 est a 0)
                  --       LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr((rtrim(substr(Ligne.CodeSaisie, 2, 11), '0')), 1, (length((rtrim(substr(Ligne.CodeSaisie, 2, 11), '0'))))-1));
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := to_number(substr(Ligne.CodeSaisie
                                                                              ,2
                                                                              ,7));
                END IF;
              
                IF Ligne.MotifRetour = 46 THEN
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := '92505300' || substr(Ligne.CodeSaisie
                                                                                  ,2
                                                                                  ,8);
                END IF;
              
                --Modif FTR le 12/02/2014 ajout du moyen de paiement 77 pour la carte 24 Sevres
                IF Ligne.MotifRetour = 77 THEN
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.CodeSaisie;
                END IF;
              
                --******************* Si paiement autre que cheque, on met le numero d'identification remonte
                --Modif FTR le 13/07/2012 ajout du moyen de paiement 48 pour la carte CUP
              
                IF Ligne.MotifRetour IN (42, 44, 45, 52, 43, 47, 74, 48) THEN
                  --IF Ligne.MotifRetour IN (42, 44, 45, 52, 43, 47,74) THEN
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.NumPieceIdentite;
                  -- Modif DLA le 27/12/2007 : le format de NumAutoCb a ete modifie en Varchar2, le test est a present inutile
                  LeTabLignesRegl(iLigneRegl).NumAutoCB := Ligne.CodeSaisie;
                  --                LeTabLignesRegl(iLigneRegl).NumAutoCB := TEST_CodeSaisie(Ligne.CodeSaisie);
                END IF;
                --******************* Si c'est un client en compte, on met le code client dans NumIdMoyPaie
                -- DLA le 16/05/2007 : si client en compte, alors on met code client
              
                IF Ligne.MotifRetour = 61 THEN
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.CodeClient;
                
                  BEGIN
                    --Modif DLA le 27/12/2007 : on renseigne NUMFACTURE a present
                    --                  SELECT NUMFACTURE INTO LeTabLignesRegl(iLigneRegl).NumCertifCHQ
                    SELECT NUMFACTURE
                      INTO LeTabLignesRegl(iLigneRegl) .NUMFACTURE
                      FROM NUM_FACTURE_TICKET
                     WHERE CodeMagasin = Ligne.CodeMagasin
                       AND JourDeVente = Ligne.JourDeVente
                       AND CodeCaisse = Ligne.CodeCaisse
                       AND NumTicket = Ligne.NumTicket
                       AND ROWNUM = 1;
                  EXCEPTION
                    WHEN NO_DATA_FOUND THEN
                      NULL;
                    WHEN OTHERS THEN
                      RAISE_APPLICATION_ERROR(-20001
                                             ,'Probleme lors de la recuperation du numero de facture client, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                  END;
                END IF;
                IF Ligne.MotifRetour = NumReglCarteKDO THEN
                  LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.CodeSaisie;
                END IF;
              
                LeTabLignesRegl(iLigneRegl).DateMaj := LaDateMiseAJour;
              
                --Modif DLA le 27/12/2008 : gestion des tickets OFF LINE
              
                IF Ligne.CodeTVA = '3' THEN
                  LeTabLignesRegl(iLigneRegl).TRANSACOFFLINE := 1;
                END IF;
              END IF;
            
              --******************* Si c'est un credit, on met le numero de credit dans NumIdMoyPaie
            
              IF Ligne.MotifRetour IN (32, 33, 34) THEN
                LeTabLignesRegl(iLigneRegl).NumIdMoyPaie := Ligne.NumPieceIdentite;
              END IF;
            
              /*
              --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
              --*******************Traitement des lignes d'action marketing
              ELSIF   Ligne.TypeInfo = 'Actions Marketing' THEN
              
              iLigneAMKT := iLigneAMKT + 1;
              
              LeTabLignesAMKT(iLigneAMKT).stecaisse := Ligne.CodeCaisse;
              LeTabLignesAMKT(iLigneAMKT).datehtransac := Ligne.JourDeVente;
              LeTabLignesAMKT(iLigneAMKT).numcaisse := Ligne.Codemagasin;
              LeTabLignesAMKT(iLigneAMKT).numticket := Ligne.NumTicket;
              LeTabLignesAMKT(iLigneAMKT).numligamkt := Ligne.NumLigne;
              LeTabLignesAMKT(iLigneAMKT).codeactionmkt := Ligne.CodeActionMarketing;
              LeTabLignesAMKT(iLigneAMKT).remredttcmkt := Ligne.MtRemise;
              LeTabLignesAMKT(iLigneAMKT).datemaj := LaDateMiseAJour;
              
              --Fin ajout ERI le 19/12/20103
              */
              --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
              --*******************Traitement des lignes d'action marketing
            
            ELSE
              IF Ligne.TypeInfo = 'Actions Marketing' THEN
              
                iLigneAMKT := iLigneAMKT + 1;
              
                LeTabLignesAMKT(iLigneAMKT).stecaisse := Ligne.CodeCaisse;
                LeTabLignesAMKT(iLigneAMKT).datehtransac := Ligne.JourDeVente;
                LeTabLignesAMKT(iLigneAMKT).numcaisse := Ligne.Codemagasin;
                LeTabLignesAMKT(iLigneAMKT).numticket := Ligne.NumTicket;
                LeTabLignesAMKT(iLigneAMKT).numligamkt := iLigneAMKT;
                --Ligne.NumLigne;
                LeTabLignesAMKT(iLigneAMKT).codeactionmkt := Ligne.CodeActionMarketing;
                LeTabLignesAMKT(iLigneAMKT).remredttcmkt := Ligne.MtRemise;
                LeTabLignesAMKT(iLigneAMKT).datemaj := LaDateMiseAJour;
              
                --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
              ELSE
                IF Ligne.TypeInfo = 'Actions Marketing Reponses' THEN
                
                  iLigneAMKTR := iLigneAMKTR + 1;
                
                  LeTabLignesAMKTR(iLigneAMKTR).stecaisse := Ligne.CodeCaisse;
                  LeTabLignesAMKTR(iLigneAMKTR).datehtransac := Ligne.JourDeVente;
                  LeTabLignesAMKTR(iLigneAMKTR).numcaisse := Ligne.Codemagasin;
                  LeTabLignesAMKTR(iLigneAMKTR).numticket := Ligne.NumTicket;
                  LeTabLignesAMKTR(iLigneAMKTR).codeactionmkt := Ligne.CodeActionMarketing;
                  LeTabLignesAMKTR(iLigneAMKTR).codequestion := Ligne.CodeVendeur;
                  LeTabLignesAMKTR(iLigneAMKTR).codeclient := Ligne.CodeClient;
                  LeTabLignesAMKTR(iLigneAMKTR).codeelement := Ligne.CodeOpeComm;
                  LeTabLignesAMKTR(iLigneAMKTR).valeur := Ligne.libelle2;
                  LeTabLignesAMKTR(iLigneAMKTR).datemaj := LaDateMiseAJour;
                
                  --Fin Ajout ERI le 19/09/2014:
                ELSE
                  IF Ligne.TypeInfo = 'Attributs' THEN
                    iLigneAttribut := iLigneAttribut + 1;
                    LeTabLignesAttributVente(iLigneAttribut).stecaisse := Ligne.CodeCaisse;
                    LeTabLignesAttributVente(iLigneAttribut).datehtrans := Ligne.JourDeVente;
                    LeTabLignesAttributVente(iLigneAttribut).numcaisse := Ligne.Codemagasin;
                    LeTabLignesAttributVente(iLigneAttribut).numticket := Ligne.NumTicket;
                    LeTabLignesAttributVente(iLigneAttribut).numattribut := Ligne.CodeVendeur;
                    LeTabLignesAttributVente(iLigneAttribut).valeurattribut := Ligne.codesaisie;
                    LeTabLignesAttributVente(iLigneAttribut).datemaj := LaDateMiseAJour;
                  
                  ELSE
                  
                    --******************* Traitement des PIED de ticket (creation d'une entete)
                  
                    -- Pied de ticket => alimentation de la structure de l'entete de ticket
                    -- et insertion des donnees dans les tables BizTalk
                    LeEnteteVente.SteCaisse        := Ligne.CodeElementStat;
                    LeEnteteVente.DateHTrans       := Ligne.JourDeVente;
                    LeEnteteVente.NumCaisse        := Ligne.CodeMagasin; --Ligne.CodeCaisse;
                    LeEnteteVente.NumCaissierTrans := Ligne.CodeCaissiere;
                    LeEnteteVente.NumTicket        := Ligne.NumTicket;
                    IF TicketExport = 1 THEN
                      LeEnteteVente.Export := 'O';
                    ELSE
                      LeEnteteVente.Export := 'N';
                    END IF;
                    LeEnteteVente.CaNetTTC := Ligne.CaNetRealise;
                    LeEnteteVente.NumClt   := Ligne.CodeClient;
                    LeEnteteVente.Escpt    := 0;
                  
                    BEGIN
                      --Modif ERI le 15/06/2017 : Mantis 7593
                      --Modif ERI le 16/04/2014:
                    
                      /*
                      SELECT CASE
                      WHEN lge.codecarte IS NULL
                      THEN NVL (car.codecartefideliteclient, hc.codecarte)
                      ELSE hc.codecarte
                      END
                      INTO leentetevente.numcartepriv
                      FROM historique_caisses hc
                      --Ajout ERI le 07/01/2015
                      LEFT JOIN carte_fidelite_client car2
                      ON hc.codecarte = car2.codecartefideliteclient
                      --Fin Ajout ERI le 07/01/2015
                      LEFT JOIN lbm_gestion_cartes_chgt_niveau lge
                      -- Modif ERI le 07/01/2015
                      ON --hc.codeclient = lge.codeclient
                      DECODE (hc.codeclient, '0', car2.codeclient, hc.codeclient) = lge.codeclient
                      -- Fin Modif ERI le 07/01/2015
                      AND TRUNC (hc.jourdevente) = TRUNC (lge.date_ticket)
                      LEFT JOIN carte_fidelite_client car
                      -- Modif ERI le 07/01/2015
                      ON --hc.codeclient = car.codeclient
                      DECODE (hc.codeclient, '0', car2.codeclient, hc.codeclient) = car.codeclient
                      -- Fin Modif ERI le 07/01/2015
                      AND car.codeetatcartefideliteclient = 'TMP'
                      WHERE codemagasin = ligne.codemagasin
                      AND jourdevente = ligne.jourdevente
                      AND codecaisse = ligne.codecaisse
                      AND numticket = ligne.numticket
                      AND hc.codecarte IS NOT NULL
                      AND ROWNUM = 1;
                      
                      */
                      SELECT CodeCarte
                        INTO LeEnteteVente.NumCartePriv
                        FROM HISTORIQUE_CAISSES
                       WHERE CodeMagasin = Ligne.Codemagasin
                         AND JourDeVente = Ligne.JourDeVente
                         AND CodeCaisse = Ligne.CodeCaisse
                         AND NumTicket = Ligne.NumTicket
                         AND CODECARTE IS NOT NULL
                         AND ROWNUM = 1;
                    
                      -- Fin Modif ERI le 16/04/2014
                      --Fin Modif ERI le 15/06/2017 : Mantis 7593
                    
                    EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        LeEnteteVente.NumCartePriv := NULL;
                    END;
                  
                    LeEnteteVente.DateHTOPCA := NULL;
                    LeEnteteVente.DateMaj    := LaDateMiseAJour;
                    --FTR le 06/08/2010
                    BEGIN
                      SELECT ElementN
                        INTO LeEnteteVente.DelaiArticle
                        FROM HISTO_TIC_ENTETE
                       WHERE CodeMagasin = Ligne.Codemagasin
                         AND CodeCaisse = Ligne.CodeCaisse
                         AND NumTicket = Ligne.NumTicket
                            --Modif ERi le 04/06/2014
                         AND JourDeVente = TRUNC(Ligne.JourDeVente)
                            -- Fin modif ERi le 04/06/2014
                         AND NumChamp = 1
                         AND NumLigne = 0;
                    EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        LeEnteteVente.DelaiArticle := NULL;
                    END;
                  
                    BEGIN
                      SELECT ElementN
                        INTO LeEnteteVente.DELAIPAIEMENT
                        FROM HISTO_TIC_ENTETE
                       WHERE CodeMagasin = Ligne.Codemagasin
                         AND CodeCaisse = Ligne.CodeCaisse
                         AND NumTicket = Ligne.NumTicket
                            --Modif ERi le 04/06/2014
                         AND JourDeVente = TRUNC(Ligne.JourDeVente)
                            -- Fin modif ERi le 04/06/2014
                         AND NumChamp = 2
                         AND NumLigne = 0;
                    EXCEPTION
                      WHEN NO_DATA_FOUND THEN
                        LeEnteteVente.DELAIPAIEMENT := NULL;
                    END;
                  
                    --Fin FTR le 06/08/2010
                  
                    --******************* Alimentation des tables BizTalk
                    IF CodeSaisieLiv <> ' ' THEN
                      -- BP 27260
                      cpt := iLigneVente;
                      WHILE (cpt > 0) LOOP
                        IF LeTabLignesVentes(cpt).NumTicket = Ligne.NumTicket THEN
                          -- FTR le 08/06/2010 recherche du NumCdeClt (Fiche 457)
                          BEGIN
                            SELECT DECODE(NVL(REMARQUE
                                             ,'-1')
                                         ,'-1'
                                         ,CODEOSCC
                                         ,SUBSTR(REMARQUE
                                                ,2
                                                ,LENGTH(Remarque)))
                              INTO NumCdeClt
                              FROM HISTO_OSCC
                             WHERE CODEOSCC = CodeSaisieLiv;
                          EXCEPTION
                            WHEN OTHERS THEN
                              RAISE_APPLICATION_ERROR(-20001
                                                     ,'Probleme lors du traitement ticket, recherche du NUMCDECLT, ticket ' || Ligne.NumTicket || CHR(13) || SQLERRM(SQLCODE));
                          END;
                          LeTabLignesVentes(cpt).NUMCDECLT := NUMCDECLT;
                          --LeTabLignesVentes(cpt).NUMCDECLT := CodeSaisieLiv;
                          -- Fin FTR le 08/06/2010
                        END IF;
                        cpt := cpt - 1;
                      END LOOP;
                      CodeSaisieLiv := ' ';
                    END IF;
                  
                    -- FTR le 05/07/2010 ajout du CodeClient de la commande client dans le ticket
                    cpt := iLigneVente;
                    WHILE (cpt > 0) LOOP
                      IF LeTabLignesVentes(cpt).NUMCDECLT IS NOT NULL THEN
                        BEGIN
                          SELECT CODECLIENT INTO LeEnteteVente.NumClt FROM HISTO_OSCC WHERE CODEOSCC = LeTabLignesVentes(cpt).NUMCDECLT;
                          cpt := 0;
                        EXCEPTION
                          WHEN OTHERS THEN
                            RAISE_APPLICATION_ERROR(-20001
                                                   ,'Probleme lors de la recuperation du client de la commande ' || LeTabLignesVentes(cpt).NUMCDECLT || CHR(13) || SQLERRM(SQLCODE));
                        END;
                      ELSE
                        cpt := cpt - 1;
                      END IF;
                    END LOOP;
                    -- Fin FTR le 05/07/2010
                  
                    --DLA le 28/02/2007 : on tronque le numticket dans tous les INSERT
                    BEGIN
                      INSERT INTO LBM_TICKET_EXTRAIT
                        (CODEMAGASIN
                        ,JOURDEVENTE
                        ,CODECAISSE
                        ,NUMTICKET)
                      VALUES
                        (Ligne.CodeMagasin
                        ,
                         -- FTR le 16/03/2010 il vaut mieux inserer sans l'heure pour eviter de
                         -- rejouer 2 * le meme ticket
                         --Ligne.JourDeVente,
                         TRUNC(Ligne.JourDeVente)
                        ,Ligne.CodeCaisse
                        ,TO_NUMBER(SUBSTR(LIGNE.NUMTICKET
                                         ,4
                                         ,10))
                         --        Ligne.NumTicket
                         );
                    EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        EFFACE_LBM_TICKET_A_EXTRAIRE_A(Ligne.CodeMagasin
                                                      ,Ligne.JourDeVente
                                                      ,Ligne.CodeCaisse
                                                      ,Ligne.NumTicket);
                        --                COMMIT;
                        RAISE_APPLICATION_ERROR(-20001
                                               ,'Ce ticket est deja present dans la table LBM_TICKET_EXTRAIT');
                    END;
                  
                    BEGIN
                      INSERT INTO LBM_VENTE_ENTETE
                        (STECAISSE
                        ,DATEHTRANS
                        ,NUMCAISSE
                        ,NUMCAISSIERTRANS
                        ,NUMTICKET
                        ,EXPORT
                        ,NUMCLT
                        ,CANETTTC
                        ,ESCPT
                        ,NUMCARTEPRIV
                        ,DATEHTOPCA
                        ,DATEMAJ
                        ,TOPCA
                        ,TOPLM
                         --FTR le 06/08/2010
                        ,DELAIPAIEMENT
                        ,DELAIARTICLE
                         --Fin FTR le 06/08/2010
                         )
                      VALUES
                        (LeEnteteVente.SteCaisse
                        ,LeEnteteVente.DateHTrans
                        ,LeEnteteVente.NumCaisse
                        ,LeEnteteVente.NumCaissierTrans
                        ,TO_NUMBER(SUBSTR(LeEnteteVente.NumTicket
                                         ,4
                                         ,10))
                        ,
                         --     LeEnteteVente.NumTicket,
                         LeEnteteVente.Export
                        ,LeEnteteVente.NumClt
                        ,LeEnteteVente.CaNetTTC
                        ,LeEnteteVente.Escpt
                        ,LeEnteteVente.NumCartePriv
                        ,LeEnteteVente.DateHTOPCA
                        ,LeEnteteVente.DateMaj
                        ,0
                        ,0
                         --FTR le 06/08/2010
                        ,LeEnteteVente.DELAIPAIEMENT
                        ,LeEnteteVente.DELAIARTICLE
                         --Fin FTR le 06/08/2010
                         );
                    EXCEPTION
                      WHEN DUP_VAL_ON_INDEX THEN
                        RAISE_APPLICATION_ERROR(-20001
                                               ,'Une entete de ticket identique est deja presente dans la table LBM_VENTE_POSTE');
                    END;
                  
                    FOR lVente IN 1 .. iLigneVente LOOP
                      BEGIN
                        INSERT INTO LBM_VENTE_POSTE
                          (STECAISSE
                          ,DATEHTRANS
                          ,NUMCAISSE
                          ,NUMTICKET
                          ,NUMLIGNE
                          ,CODEVEND
                          ,EANSAISIE
                          ,DEPARTEMENT
                          ,CP
                          ,PRIXTTCART
                          ,CANETLIGNE
                          ,APPL
                          ,TYPEGEST
                          ,NUMCDECLT
                          ,TOTREMRED
                          ,TVATAUX
                          ,TVAMONT
                          ,QTE
                          ,PR
                          ,REDUCTOTAL
                          ,ESCMONT
                          ,REDUCTYPE
                          ,REMISETYPE
                          ,REMMANUELLE
                          ,NUMPLAN
                          ,HCA
                          ,ACTMARKLIBREDUIT
                          ,ACTMARKCODEDUTYPE
                          ,DATHTOPGU
                          ,TOPARCH
                          ,DATEMAJ
                          ,EXPMONT
                          ,PRIXHTART
                          ,TOTREMREDHT
                          ,CANETLIGNEHT
                          ,MONTACTMARKHT
                          ,MONTACTMARK
                          ,EXPART
                          ,EXPREMISE
                          ,MOTIFRETOUR
                          ,TOPGU)
                        VALUES
                          (LeTabLignesVentes(lVente).SteCaisse
                          ,LeTabLignesVentes(lVente).DateHTrans
                          ,LeTabLignesVentes(lVente).NumCaisse
                          ,TO_NUMBER(SUBSTR(LeTabLignesVentes(lVente).NumTicket
                                           ,4
                                           ,10))
                          ,
                           --             LeTabLignesVentes(lVente).NumTicket,
                           LeTabLignesVentes(lVente).NumLigne
                          ,LeTabLignesVentes(lVente).CodeVend
                          ,LeTabLignesVentes(lVente).EanSaisie
                          ,LeTabLignesVentes(lVente).Departement
                          ,LeTabLignesVentes(lVente).Cp
                          ,LeTabLignesVentes(lVente).PrixTTCArt
                          ,LeTabLignesVentes(lVente).CANetLigne
                          ,LeTabLignesVentes(lVente).Appl
                          ,LeTabLignesVentes(lVente).TypeGest
                          ,LeTabLignesVentes(lVente).NumCdeCLT
                          ,LeTabLignesVentes(lVente).TotRemRed
                          ,LeTabLignesVentes(lVente).TvaTaux
                          ,LeTabLignesVentes(lVente).TvaMont
                          ,LeTabLignesVentes(lVente).Qte
                          ,LeTabLignesVentes(lVente).Pr
                          ,LeTabLignesVentes(lVente).ReducTotal
                          ,LeTabLignesVentes(lVente).EscMont
                          ,LeTabLignesVentes(lVente).ReducType
                          ,LeTabLignesVentes(lVente).RemiseType
                          ,LeTabLignesVentes(lVente).RemManuelle
                          ,LeTabLignesVentes(lVente).NumPlan
                          ,LeTabLignesVentes(lVente).Hca
                          ,LeTabLignesVentes(lVente).ActMarkLibReduit
                          ,LeTabLignesVentes(lVente).ActMarkCodeDuType
                          ,LeTabLignesVentes(lVente).DatHTOPGU
                          ,LeTabLignesVentes(lVente).TopArch
                          ,LeTabLignesVentes(lVente).DateMaj
                          ,LeTabLignesVentes(lVente).EXPMONT
                          ,LeTabLignesVentes(lVente).PRIXHTART
                          ,LeTabLignesVentes(lVente).TOTREMREDHT
                          ,LeTabLignesVentes(lVente).CANETLIGNEHT
                          ,LeTabLignesVentes(lVente).MONTACTMARKHT
                          ,LeTabLignesVentes(lVente).MONTACTMARK
                          ,LeTabLignesVentes(lVente).EXPART
                          ,LeTabLignesVentes(lVente).EXPREMISE
                          ,LeTabLignesVentes(lVente).MOTIFRETOUR
                          ,0);
                      EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR(-20001
                                                 ,'Une ligne de ticket identique est deja presente dans la table LBM_VENTE_POSTE');
                      END;
                    END LOOP;
                  
                    FOR lRegl IN 1 .. iLigneRegl LOOP
                      BEGIN
                        INSERT INTO LBM_VENTE_REGLEMENT
                          (STECAISSE
                          ,DATEHTRANSAC
                          ,NUMCAISSE
                          ,NUMCAISSIERTRANS
                          ,NUMTICKET
                          ,NUMLIGPAIE
                          ,NUMCERTIFCHQ
                          ,NUMAUTOCB
                          ,PAIEMODE
                          ,PAIEMONTDEV
                          ,DEV
                          ,PAIEMONTDEVSTE
                          ,NUMIDMOYPAIE
                          ,DATEMAJ
                          ,TICKETCHANGE
                          ,NUMFACTURE
                          ,TRANSACOFFLINE)
                        VALUES
                          (LeTabLignesRegl(lRegl).SteCaisse
                          ,LeTabLignesRegl(lRegl).DateHTRansac
                          ,LeTabLignesRegl(lRegl).NumCaisse
                          ,LeTabLignesRegl(lRegl).NumCaissierTrans
                          ,TO_NUMBER(SUBSTR(LeTabLignesRegl(lRegl).NumTicket
                                           ,4
                                           ,10))
                          ,
                           --     LeTabLignesRegl(lRegl).NumTicket,
                           LeTabLignesRegl(lRegl).NumLigPaie
                          ,LeTabLignesRegl(lRegl).NumCertifChq
                          ,LeTabLignesRegl(lRegl).NumAutoCb
                          ,LeTabLignesRegl(lRegl).PaieMode
                          ,LeTabLignesRegl(lRegl).PaieMontDev
                          ,LeTabLignesRegl(lRegl).Dev
                          ,LeTabLignesRegl(lRegl).PaieMontDevSte
                          ,LeTabLignesRegl(lRegl).NumIdMoyPaie
                          ,LeTabLignesRegl(lRegl).DateMaj
                          ,LeTabLignesRegl(lRegl).TICKETCHANGE
                          ,LeTabLignesRegl(lRegl).NUMFACTURE
                          ,LeTabLignesRegl(lRegl).TRANSACOFFLINE);
                      EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR(-20001
                                                 ,'Une ligne de reglement identique est deja presente dans la table LBM_VENTE_REGLEMENT');
                      END;
                    END LOOP;
                  
                    --Ajout ERI le 19/12/20103: Gestion des actions marketing par ticket
                    FOR lAMkt in 1 .. iLigneAMKT LOOP
                    
                      BEGIN
                        INSERT INTO LBM_VENTE_ACT_MKT
                          (STECAISSE
                          ,DATEHTRANSAC
                          ,NUMCAISSE
                          ,NUMTICKET
                          ,NUMLIGAMKT
                          ,CODEACTIONMKT
                          ,REMREDTTCMKT
                          ,DATEMAJ)
                        VALUES
                          (LeTabLignesAMKT(lAMkt).stecaisse
                          ,LeTabLignesAMKT(lAMkt).datehtransac
                          ,LeTabLignesAMKT(lAMkt).numcaisse
                          ,TO_NUMBER(SUBSTR(LeTabLignesAMKT(lAMkt).numticket
                                           ,4
                                           ,10))
                          ,LeTabLignesAMKT(lAMkt).numligamkt
                          ,LeTabLignesAMKT(lAMkt).codeactionmkt
                          ,LeTabLignesAMKT(lAMkt).remredttcmkt
                          ,LeTabLignesAMKT(lAMkt).datemaj);
                      
                      EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR(-20001
                                                 ,'Une ligne d''action marketing identique est deja presente dans la table LBM_VENTE_ACT_MKT');
                        
                      END;
                    
                    END LOOP;
                    --Fin ajout ERI le 19/12/20103
                  
                    --Ajout ERI le 19/09/2014: Gestion des reponses des actions marketing par ticket
                    FOR lAMktR in 1 .. iLigneAMKTR LOOP
                    
                      BEGIN
                        INSERT INTO LBM_VENTE_ACT_MKT_REPONSES
                          (STECAISSE
                          ,DATEHTRANSAC
                          ,NUMCAISSE
                          ,NUMTICKET
                          ,CODEACTIONMKT
                          ,CODEQUESTION
                          ,CODECLIENT
                          ,CODEELEMENT
                          ,VALEUR
                          ,DATEMAJ)
                        VALUES
                          (
                           
                           LeTabLignesAMKTR(lAMktR).stecaisse
                          ,LeTabLignesAMKTR(lAMktR).datehtransac
                          ,LeTabLignesAMKTR(lAMktR).numcaisse
                          ,TO_NUMBER(SUBSTR(LeTabLignesAMKTR(lAMktR).numticket
                                           ,4
                                           ,10))
                          ,LeTabLignesAMKTR(lAMktR).codeactionmkt
                          ,LeTabLignesAMKTR(lAMktR).codequestion
                          ,LeTabLignesAMKTR(lAMktR).codeclient
                          ,LeTabLignesAMKTR(lAMktR).codeelement
                          ,LeTabLignesAMKTR(lAMktR).valeur
                          ,LeTabLignesAMKTR(lAMktR).datemaj
                           
                           );
                      
                      EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR(-20001
                                                 ,'Une ligne d''action marketing identique est deja presente dans la table LBM_VENTE_ACT_MKT_REPONSES');
                        
                      END;
                    
                    END LOOP;
                    --Fin Ajout ERI le 19/09/2014
                    --Ajout ERI le 02/01/2016: Gestion des attributs tickets
                    FOR lAttrib in 1 .. iLigneAttribut LOOP
                      BEGIN
                        INSERT INTO LBM_VENTE_ATTRIBUTS
                          (STECAISSE
                          ,DATEHTRANS
                          ,NUMCAISSE
                          ,NUMTICKET
                          ,NUMATTRIBUT
                          ,VALEUR
                          ,DATEMAJ)
                        VALUES
                          (LeTabLignesAttributVente(iLigneAttribut).stecaisse
                          ,LeTabLignesAttributVente(iLigneAttribut).datehtrans
                          ,LeTabLignesAttributVente(iLigneAttribut).numcaisse
                          ,TO_NUMBER(SUBSTR(LeTabLignesAttributVente(iLigneAttribut).numticket
                                           ,4
                                           ,10))
                          ,LeTabLignesAttributVente(iLigneAttribut).numattribut
                          ,LeTabLignesAttributVente(iLigneAttribut).valeurattribut
                          ,LeTabLignesAttributVente(iLigneAttribut).datemaj);
                      EXCEPTION
                        WHEN DUP_VAL_ON_INDEX THEN
                          RAISE_APPLICATION_ERROR(-2001
                                                 ,'Une ligne d''attribut identique est deja presente dans la table LBM_VENTE_ATTRIBUTS');
                      END;
                    END LOOP;
                    --Fin Ajout ERI le 02/01/2016
                    --******************* Une fois le ticket extrait, on le supprime de la tablme des tickets a extraire
                    EFFACE_LBM_TICKET_A_EXTRAIRE(Ligne.CodeMagasin
                                                ,Ligne.JourDeVente
                                                ,Ligne.CodeCaisse
                                                ,Ligne.NumTicket);
                  
                    --******************* Une fois le ticket extrait, on reinitialise les donnees
                    InitTicket;
                  END IF;
                END IF;
              END IF;
            END IF;
          END IF;
        
        EXCEPTION
          WHEN OTHERS THEN
            TicketEnErreur := 1;
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''integration  du ticket ' || Ligne.NumTicket || ' du ' || Ligne.JourDeVente || ' pour le magasin ' || Ligne.CodeMagasin || ' caisse ' || Ligne.CodeCaisse || ' :' || CHR(13) || SQLERRM(SQLCODE));
            -- Reinit des donnees
            InitTicket;
        END;
      END LOOP;
    
      --Trace les enregistrements qui de ne satisfont pas la jointure
      FOR Ligne IN (
                    -- FTR le 16/01/2010 Jointure avec des JOIN et filtre sur les CodeMagasin et CodeElementStat IS NULL
                    SELECT DISTINCT ltae.CodeMagasin
                                    ,ltae.CodeCaisse
                                    ,ltae.JourdeVente
                                    ,sm.CodeElementStat Stat
                                    ,hc.CodeMagasin MAG
                      FROM LBM_TICKET_A_EXTRAIRE ltae
                      LEFT JOIN HISTORIQUE_CAISSES hc ON hc.CodeMagasin = ltae.CodeMagasin
                                                     AND trunc(hc.JourDeVente) = ltae.JourDeVente
                                                     AND hc.CodeCaisse = ltae.CodeCaisse
                                                     AND hc.NumTicket = ltae.NumTicket
                                                     AND hc.TypeLigne IN (1, 2, 4, 7, 9)
                      LEFT JOIN STATS_MAGASIN sm ON sm.CodeMagasin = hc.CodeMagasin
                                                AND sm.CodeAxeStat = CodeAxeSteCaisse
                     WHERE ltae.JourDeVente >= TRUNC(SYSDATE) - NbJoursTickets
                       AND (hc.CodeMagasin IS NULL OR sm.CodeElementStat IS NULL)) LOOP
        IF Ligne.Mag IS NULL THEN
          Ajouter_Log(3
                     ,LeCodeMsg
                     ,'Trace issue de la generation des ventes. Ticket Magasin ' || Ligne.CodeMagasin || ' Caisse ' || Ligne.CodeCaisse || ' jour de vente ' || TO_CHAR(Ligne.JourDeVente
                                                                                                                                                                       ,'DD/MM/YYYY HH24:MI:SS') || ' non trouve.');
        END IF;
        IF Ligne.Stat IS NULL THEN
          Ajouter_Log(3
                     ,LeCodeMsg
                     ,'Trace issue de la generation des ventes. Ticket Magasin ' || Ligne.CodeMagasin || ' Caisse ' || Ligne.CodeCaisse || ' jour de vente ' || TO_CHAR(Ligne.JourDeVente
                                                                                                                                                                       ,'DD/MM/YYYY HH24:MI:SS') || ' element stat non trouve.');
        END IF;
      END LOOP;
    
      -- DLA le 28/03/2007 : ce commit est place ici pour assurer l'integration du dernier ticket
      -- En effet, l'autre commit est place au changement de ticket, qui n'a jamais lieu pour
      -- le dernier
      test_ticket(LaSteCaisseEnCours
                 ,LeNumCaisseEnCours
                 ,LeNumTicketEnCours
                 ,LaDateHTransEnCours);
      --   COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Erreur lors de de la generation des ventes : ' || CHR(13) || SQLERRM(SQLCODE));
    END;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la generation des ventes par LBM_ VENTE');
    ROLLBACK;
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
    LeCodeMsg       Log_Traitements.CodeMsg%TYPE;
    LaDateMiseAJour DATE;
  
    LeTypeRemise TRecLBMTypeRemise;
  BEGIN
    LeCodeMsg       := 'BIZ-0006';
    LaDateMiseAJour := SYSDATE;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de la generation des types de remises par LBM_ TYPEREMISE');
  
    BEGIN
      FOR Ligne IN (SELECT CodeTypeRemise
                          ,LibTypeRemise
                      FROM TYPES_REMISE) LOOP
        BEGIN
          -- Extraction des donnees depuis Storeland
          LeTypeRemise.RemiseType := Ligne.CodeTypeRemise;
          LeTypeRemise.RemiseLib  := Ligne.LibTypeRemise;
          LeTypeRemise.DateMaj    := LaDateMiseAJour;
        
          -- Insertion des donnees dans les tables BizTalk
          BEGIN
            INSERT INTO LBM_TYPE_REMISE
              (REMISETYPE
              ,REMISELIB
              ,DATEMAJ)
            VALUES
              (LeTypeRemise.RemiseType
              ,LeTypeRemise.RemiseLib
              ,LeTypeRemise.DateMaj);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              NULL;
              --              RAISE_APPLICATION_ERROR(-20001, 'Un enregistrement existe deja dans la table LBM_TYPE_REMISE pour ce code RemiseType.');
          END;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''extraction du type de remise ' || LeTypeRemise.RemiseType || '(' || LeTypeRemise.RemiseLib || ') : ' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de l''extraction des types de remises : ' || CHR(13) || SQLERRM(SQLCODE));
    END;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la generation des types de remises par LBM_ TYPEREMISE');
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
    LeCodeMsg       Log_Traitements.CodeMsg%TYPE;
    LaDateMiseAJour DATE;
  
    LeTypeActionMarketing TRecLBMActionMarketing;
  BEGIN
    LeCodeMsg       := 'BIZ-0007';
    LaDateMiseAJour := SYSDATE;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Lancement de la generation des types AM par LBM_ TYPEAM');
  
    BEGIN
      FOR Ligne IN (SELECT CodeTypeActionMarketing
                          ,LibTypeActionMarketing
                      FROM TYPES_ACTION_MARKETING) LOOP
        BEGIN
          -- Extraction des donnees depuis Storeland
          LeTypeActionMarketing.ActMarkCodeType  := Ligne.CodeTypeActionMarketing;
          LeTypeActionMarketing.ActMarkLibDuType := Ligne.LibTypeActionMarketing;
          LeTypeActionMarketing.DateMaj          := LaDateMiseAJour;
        
          -- Insertion des donnees dans les tables BizTalk
          BEGIN
            INSERT INTO LBM_ACTION_MARKETING
              (ACTMARKCODETYPE
              ,ACTMARKLIBDUTYPE
              ,DATEMAJ)
            VALUES
              (LeTypeActionMarketing.ActMarkCodeType
              ,LeTypeActionMarketing.ActMarkLibDuType
              ,LeTypeActionMarketing.DateMaj);
          EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
              NULL;
              --              RAISE_APPLICATION_ERROR(-20001, 'Un enregistrement existe deja dans la table LBM_ACTION_MARKETING pour ce code ActMarkCodeType.');
          END;
          COMMIT;
        EXCEPTION
          WHEN OTHERS THEN
            ROLLBACK;
            Ajouter_Log(1
                       ,LeCodeMsg
                       ,'Erreur lors de l''extraction du type d''action marketing ' || LeTypeActionMarketing.ActMarkCodeType || '(' || LeTypeActionMarketing.ActMarkLibDuType || ') : ' || CHR(13) || SQLERRM(SQLCODE));
        END;
      END LOOP;
    EXCEPTION
      WHEN OTHERS THEN
        Ajouter_Log(1
                   ,LeCodeMsg
                   ,'Une erreur s''est produite lors de l''extraction des types d''action marketing : ' || CHR(13) || SQLERRM(SQLCODE));
    END;
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de la generation des types AM par LBM_ TYPEAM');
  END;

  /*******************************************************************/
  /*  Procedure LBM_ExtractionsCommandes                             */
  /*                                                                 */
  /*                                                                 */
  /*  BP 31/10/2008 #27260 Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE LBM_ExtractionsCommandes IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0012';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut des extractions Storeland vers BizTalk');
  
    -- gestion d'un lock pour eviter le lancement du traitement si il est deja en cours
    BEGIN
      INSERT INTO TABLE_LOCK
        (NOMTABLE
        ,ENREGISTREMENT
        ,NUMPOSTE
        ,CODEUTILISATEUR)
      VALUES
        ('PK_LBM'
        ,'LBM_ExtractionsCommandes'
        ,0
        ,0);
      COMMIT;
    
      BEGIN
        PRC_LBM_COMMANDES;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Erreur lors de l''extraction des reservations ' || SQLERRM(SQLCODE));
      END;
      --    ELSE
      --      Ajouter_Log(1, LeCodeMsg, 'Les parametres de l''interface ne sont pas alimentes.');
      --    END IF;
    
      DELETE FROM TABLE_LOCK
       WHERE NOMTABLE = 'PK_LBM'
         AND ENREGISTREMENT = 'LBM_ExtractionsCommandes'
         AND NUMPOSTE = 0
         AND CODEUTILISATEUR = 0;
    
      COMMIT;
    
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        NULL;
    END;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin des extractions Storeland vers BizTalk');
  END;

  /*******************************************************************/
  /*  Procedure LBM_IntegrationCommandes                             */
  /*                                                                 */
  /*                                                                 */
  /*  BP 31/10/2008 #27260 Creation                                  */
  /*                                                                 */
  /*******************************************************************/

  PROCEDURE LBM_IntegrationCommandes IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
  BEGIN
    LeCodeMsg := 'BIZ-0012';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut des integration Storeland vers BizTalk');
  
    -- gestion d'un lock pour eviter le lancement du traitement si il est deja en cours
    BEGIN
      INSERT INTO TABLE_LOCK
        (NOMTABLE
        ,ENREGISTREMENT
        ,NUMPOSTE
        ,CODEUTILISATEUR)
      VALUES
        ('PK_LBM'
        ,'LBM_IntegrationCommandes'
        ,0
        ,0);
      COMMIT;
    
      BEGIN
        PRC_LBM_STATUTS;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Erreur lors de l''integration des reservations ' || SQLERRM(SQLCODE));
      END;
      --    ELSE
      --      Ajouter_Log(1, LeCodeMsg, 'Les parametres de l''interface ne sont pas alimentes.');
      --    END IF;
    
      DELETE FROM TABLE_LOCK
       WHERE NOMTABLE = 'PK_LBM'
         AND ENREGISTREMENT = 'LBM_IntegrationCommandes'
         AND NUMPOSTE = 0
         AND CODEUTILISATEUR = 0;
    
      COMMIT;
    
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        NULL;
    END;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin des integrations Storeland vers BizTalk');
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
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Debut des extractions Storeland vers BizTalk');
  
    -- SM 28/02/2007 gestion d'un lock pour eviter le lancement du traitement si il est deja en cours
    BEGIN
      INSERT INTO TABLE_LOCK
        (NOMTABLE
        ,ENREGISTREMENT
        ,NUMPOSTE
        ,CODEUTILISATEUR)
      VALUES
        ('PK_LBM'
        ,'LBM_Extractions'
        ,0
        ,0);
      COMMIT;
    
      --    IF LeCodeTraitementBizTalk <> -1  THEN
      BEGIN
        PRC_LBM_VENTE;
        PRC_LBM_TypeRemise;
        PRC_LBM_TypeAM;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Erreur lors de l''extraction des ventes ' || SQLERRM(SQLCODE));
      END;
      --    ELSE
      --      Ajouter_Log(1, LeCodeMsg, 'Les parametres de l''interface ne sont pas alimentes.');
      --    END IF;
    
      DELETE FROM TABLE_LOCK
       WHERE NOMTABLE = 'PK_LBM'
         AND ENREGISTREMENT = 'LBM_Extractions'
         AND NUMPOSTE = 0
         AND CODEUTILISATEUR = 0;
    
      COMMIT;
    
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
        NULL;
    END;
  
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin des extractions Storeland vers BizTalk');
    -- DLA le 26/12/2006 :modification, on transporte un ID fourni par BizTalk
    --    CodeTraitementExtraction := LeCodeTraitementBizTalk;
    -- DLA le 26/12/2006 : FIN modification, on transporte un ID fourni par BizTalk
  END;

  /*******************************************************************/
  /*  Procedure LBM_FinIntegReferencement                            */
  /*                                                                 */
  /*                                                                 */
  /*  BFU 08/04/2009 Creation - Tracker 31480                        */
  /*******************************************************************/

  PROCEDURE LBM_FinIntegReferencement IS
    LeCodeMsg Log_Traitements.CodeMsg%TYPE;
    Etat      NUMBER(4);
  BEGIN
    LeCodeMsg := 'BIZ-0000';
    -- Recuperation de l'etat du lock laisse par Prepajournee
    BEGIN
      SELECT ENREGISTREMENT INTO Etat FROM TABLE_LOCK WHERE NOMTABLE = 'PREPA_EN_JOURNEE';
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        Etat := 0;
      WHEN OTHERS THEN
        BEGIN
          Ajouter_Log(1
                     ,LeCodeMsg
                     ,'Erreur lors de PK_LBM .FinINTEGRATION_REFERENCEMENT.' || CHR(13) || SQLERRM(SQLCODE));
        END;
    END;
  
    --------------------------------------------------------------------------------------------------------
    -- Deniere etape : on declare le traitement correctement effectue si l'etat est mis a 3 par Prepajourne
    --------------------------------------------------------------------------------------------------------
    If Etat = 3 Then
      UPDATE LBM_MESSAGE_ID SET ID_BATCH_STL = -ID_BATCH_STL WHERE ID_BATCH_STL < 0;
    Else
      Ajouter_Log(1
                 ,LeCodeMsg
                 ,'Probleme dans Prepajournee : lock = ' || Etat);
    END IF;
    -- Dans tous les cas on supprime le lock pour une prochaine tentative...
    DELETE FROM TABLE_LOCK WHERE NOMTABLE = 'PREPA_EN_JOURNEE';
    Ajouter_Log(3
               ,LeCodeMsg
               ,'Fin de l''integration du referencement');
    --dernier commit
    COMMIT;
  END;

END PK_LBM;
