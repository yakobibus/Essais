create PACKAGE PK_LBM_VENTES_GU AS
  /******************************************************************************
  NAME:       PK_LBM_VENTES_GU_B0
  PURPOSE:
  
  REVISIONS:
  Ver        Date        Author           Description
  ---------  ----------  ---------------  ------------------------------------
  1.0        24/05/2016    ERI            1. Created this package.
  
  Ce package  qui est appele par BIZTALK permet d'envoyer les tickets vers SAP
  et qui contiennet des articles qui sont geres en ferme (Division "BO" )
  ******************************************************************************/

  TYPE v_tickets_rec IS RECORD(
    
     stecaisse        lbm_vente_poste.stecaisse%TYPE
    ,datehtrans       lbm_vente_poste.datehtrans%TYPE
    ,numcaisse        lbm_vente_poste.numcaisse%TYPE
    ,numticket        lbm_vente_poste.numticket%TYPE
    ,numligne         lbm_vente_poste.numligne%TYPE
    ,codevend         lbm_vente_poste.codevend%TYPE
    ,eansaisie        lbm_vente_poste.eansaisie%TYPE
    ,cp               lbm_vente_poste.cp%TYPE
    ,prixttcart       lbm_vente_poste.prixttcart%TYPE
    ,canetligne       lbm_vente_poste.canetligne%TYPE
    ,appl             lbm_vente_poste.appl%TYPE
    ,typegest         lbm_vente_poste.typegest%TYPE
    ,numcdeclt        lbm_vente_poste.numcdeclt%TYPE
    ,totremred        lbm_vente_poste.totremred%TYPE
    ,tvataux          lbm_vente_poste.tvataux%TYPE
    ,tvamont          lbm_vente_poste.tvamont%TYPE
    ,qte              lbm_vente_poste.qte%TYPE
    ,pr               lbm_vente_poste.pr%TYPE
    ,reductotal       lbm_vente_poste.reductotal%TYPE
    ,escmont          lbm_vente_poste.escmont%TYPE
    ,reductype        lbm_vente_poste.reductype%TYPE
    ,remisetype       lbm_vente_poste.remisetype%TYPE
    ,remmanuelle      lbm_vente_poste.remmanuelle%TYPE
    ,numplan          lbm_vente_poste.numplan%TYPE
    ,hca              lbm_vente_poste.hca%TYPE
    ,actmarklibreduit lbm_vente_poste.actmarklibreduit%TYPE
    ,dathtopgu        lbm_vente_poste.dathtopgu%TYPE
    ,toparch          lbm_vente_poste.toparch%TYPE
    ,datemaj          lbm_vente_poste.datemaj%TYPE
    ,departement      lbm_vente_poste.departement%TYPE
    ,expmont          lbm_vente_poste.expmont%TYPE
    ,montactmark      lbm_vente_poste.montactmark%TYPE
    ,montactmarkht    lbm_vente_poste.montactmarkht%TYPE
    ,expart           lbm_vente_poste.expart%TYPE
    ,expremise        lbm_vente_poste.expremise%TYPE
    ,canetligneht     lbm_vente_poste.canetligneht%TYPE
    ,totremredht      lbm_vente_poste.totremredht%TYPE
    ,prixhtart        lbm_vente_poste.prixhtart%TYPE
    ,motifretour      lbm_vente_poste.motifretour%TYPE
    ,numcaisseticket  VARCHAR2(20 BYTE)
    ,magasin          VARCHAR2(4 BYTE));

  TYPE o_tickettype IS REF CURSOR RETURN v_tickets_rec;

  PROCEDURE LBM_GETTICKETSBM(p_typeticket IN VARCHAR2 -- 2 valeurs possibles : "STD": tickets standard SAP
                             --                        "CDE" Tickets commandes client
                            ,p_typegestion IN VARCHAR2 -- 2 valeurs possibles : "F": tickets centre de profit en ferme
                             --                       "G": tickets centre de profit en gerance
                            ,p_rownum        IN NUMBER -- Nombres de lignes a traiter
                            ,p_dep           IN VARCHAR2 -- Numero du departement
                            ,o_cursor_ticket OUT o_tickettype);

END PK_LBM_VENTES_GU;

create PACKAGE BODY PK_LBM_VENTES_GU AS
  /******************************************************************************
  NAME:       PK_LBM_VENTES_GU_B0
  PURPOSE:
  
  REVISIONS:
  Ver        Date        Author           Description
  ---------  ----------  ---------------  ------------------------------------
  1.0        24/05/2016    ERI            1. Created this package.
  
  Ce package  qui est appele par BIZTALK permet d'envoyer les tickets vers SAP
  et qui contiennet des articles qui sont geres en ferme (Division "BO" )
  ******************************************************************************/

  PROCEDURE LBM_GETTICKETSBM(p_typeticket    IN VARCHAR2
                            ,p_typegestion   IN VARCHAR2
                            ,p_rownum        IN NUMBER
                            ,p_dep           IN VARCHAR2
                            ,o_cursor_ticket OUT o_tickettype)
  
   IS
  
  BEGIN
  
    IF p_typeticket = 'STD' THEN
    
      UPDATE lbm_vente_poste v
         SET topgu = 2
       WHERE stecaisse IN (1, 2)
         AND appl = 'SAP'
         AND ROWNUM <= p_rownum
         AND hca IS NULL
         AND departement = p_dep
         AND ((typegest != '5' AND typegest != '6' AND p_typegestion = 'F') OR ((typegest = '5' OR typegest = '6') AND p_typegestion = 'G'))
         AND topgu = 0
         AND numcdeclt IS NULL
         AND TRUNC(datehtrans) = (SELECT TRUNC(datehtrans)
                                    FROM (SELECT datehtrans
                                            FROM lbm_vente_poste v
                                            LEFT JOIN lbm_cp_histo h ON v.cp = h.cp
                                           WHERE stecaisse IN (1, 2)
                                             AND v.appl = 'SAP'
                                             AND v.hca IS NULL
                                             AND departement = p_dep
                                             AND ((v.typegest != '5' AND v.typegest != '6' AND p_typegestion = 'F') OR ((v.typegest = '5' OR v.typegest = '6') AND p_typegestion = 'G'))
                                             AND topgu = 0
                                             AND ((datehtrans < h.dateblocageinventaire) OR (h.dateblocageinventaire IS NULL) AND numcdeclt IS NULL)
                                           ORDER BY datehtrans)
                                   WHERE ROWNUM <= 1)
         AND ((datehtrans < (SELECT dateblocageinventaire FROM lbm_cp_histo h WHERE h.cp = v.cp)) OR ((SELECT dateblocageinventaire FROM lbm_cp_histo h WHERE h.cp = v.cp) IS NULL));
    
      OPEN o_cursor_ticket FOR
      
        SELECT stecaisse
              ,datehtrans
              ,numcaisse
              ,numticket
              ,numligne
              ,codevend
              ,eansaisie
              ,cp
              ,prixttcart
              ,canetligne
              ,appl
              ,typegest
              ,numcdeclt
              ,totremred
              ,tvataux
              ,tvamont
              ,qte
              ,pr
              ,reductotal
              ,escmont
              ,reductype
              ,remisetype
              ,remmanuelle
              ,numplan
              ,hca
              ,actmarklibreduit
              ,dathtopgu
              ,toparch
              ,datemaj
              ,departement
              ,expmont
              ,montactmark
              ,montactmarkht
              ,expart
              ,expremise
              ,canetligneht
              ,totremredht
              ,prixhtart
              ,motifretour
              ,CONCAT(CONCAT(numcaisse
                            ,'-')
                     ,numticket) AS numcaisseticket
              ,null AS magasin
        
          FROM lbm_vente_poste v
         WHERE appl = 'SAP'
           AND hca IS NULL
           AND departement = p_dep
           AND ((typegest != '5' AND typegest != '6' AND p_typegestion = 'F') OR ((typegest = '5' OR typegest = '6') AND p_typegestion = 'G'))
           AND topgu = 2
           AND numcdeclt IS NULL
         ORDER BY numcaisse
                 ,numticket;
    
      UPDATE lbm_vente_poste
         SET dathtopgu = CURRENT_DATE
            ,topgu     = 1
       WHERE appl = 'SAP'
         AND hca IS NULL
         AND departement = p_dep
         AND ((typegest != '5' AND typegest != '6' AND p_typegestion = 'F') OR ((typegest = '5' OR typegest = '6') AND p_typegestion = 'G'))
         AND topgu = 2
         AND numcdeclt IS NULL;
    
    END IF;
  
    IF p_typeticket = 'CDE' THEN
    
      UPDATE lbm_vente_poste v
         SET topgu = 2
       WHERE (TRUNC(datehtrans), numcdeclt, departement) = (SELECT TRUNC(datehtrans) AS datehtrans
                                                                  ,numcdeclt AS numcdeclt
                                                                  ,departement AS departement
                                                              FROM (SELECT v2.datehtrans AS datehtrans
                                                                          ,numcdeclt     AS numcdeclt
                                                                          ,departement   AS departement
                                                                      FROM lbm_vente_poste v2
                                                                     INNER JOIN lbm_commande_entete c ON v2.numcdeclt = c.numcdecli
                                                                      LEFT JOIN lbm_cp_histo h ON v2.cp = h.cp
                                                                     WHERE v2.stecaisse = '1'
                                                                       AND v2.appl = 'SAP'
                                                                       AND v2.hca IS NULL
                                                                       AND ((v2.typegest != '5' AND v2.typegest != '6' AND p_typegestion = 'F') OR ((v2.typegest = '5' OR v2.typegest = '6') AND p_typegestion = 'G'))
                                                                       AND topgu = 0
                                                                       AND ((v2.datehtrans < h.dateblocageinventaire) OR (h.dateblocageinventaire IS NULL))
                                                                       AND numcdeclt IS NOT NULL
                                                                     ORDER BY v2.datehtrans)
                                                             WHERE ROWNUM <= p_rownum)
         AND stecaisse = '1'
         AND appl = 'SAP'
         AND hca IS NULL
         AND ((v.typegest != '5' AND v.typegest != '6' AND p_typegestion = 'F') OR ((v.typegest = '5' OR v.typegest = '6') AND p_typegestion = 'G'))
         AND topgu = 0
         AND ((datehtrans < (SELECT dateblocageinventaire
                               FROM lbm_cp_histo h
                              WHERE h.cp = v.cp
                                AND ROWNUM <= 1)) OR ((SELECT dateblocageinventaire
                                                          FROM lbm_cp_histo h
                                                         WHERE h.cp = v.cp
                                                           AND ROWNUM <= 1) IS NULL));
    
      OPEN o_cursor_ticket FOR
      
        SELECT p.stecaisse
              ,p.datehtrans
              ,p.numcaisse
              ,numticket
              ,numligne
              ,codevend
              ,LTRIM(eansaisie
                    ,0) AS eansaisie
              ,cp
              ,prixttcart
              ,canetligne
              ,appl
              ,typegest
              ,numcdeclt
              ,totremred
              ,tvataux
              ,tvamont
              ,qte
              ,pr
              ,reductotal
              ,escmont
              ,reductype
              ,remisetype
              ,remmanuelle
              ,numplan
              ,hca
              ,actmarklibreduit
              ,dathtopgu
              ,toparch
              ,p.datemaj
              ,departement
              ,expmont
              ,montactmark
              ,montactmarkht
              ,expart
              ,expremise
              ,canetligneht
              ,totremredht
              ,prixhtart
              ,motifretour
              ,CONCAT(p.numcaisse
                     ,numticket) AS numcaisseticket
              ,magasin
          FROM lbm_vente_poste p
         INNER JOIN lbm_commande_entete e ON e.numcdecli = p.numcdeclt
         WHERE appl = 'SAP'
           AND p.numcdeclt IS NOT NULL
           AND hca IS NULL
           AND ((typegest != '5' AND typegest != '6' AND p_typegestion = 'F') OR ((typegest = '5' OR typegest = '6') AND p_typegestion = 'G'))
           AND p.topgu = 2;
    
      UPDATE lbm_vente_poste
         SET dathtopgu = CURRENT_DATE
            ,topgu     = 1
       WHERE appl = 'SAP'
         AND hca IS NULL
         AND numcdeclt IS NOT NULL
         AND ((typegest != '5' AND typegest != '6' AND p_typegestion = 'F') OR ((typegest = '5' OR typegest = '6') AND p_typegestion = 'G'))
         AND topgu = 2;
    
    END IF;
  
  END;

END PK_LBM_VENTES_GU;
