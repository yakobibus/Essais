-- Requête parmi les TOP avec un grand nombre d’occurrence à optimiser (pour l’accès aux index) :
UPDATE lbm_vente_poste v
    SET   topgu = 2
  WHERE stecaisse IN (1, 2)
    AND   appl = 'SAP'
    AND   ROWNUM <= :b3
    AND   hca IS NULL
    AND   departement = :b2
    AND   (
        (
            typegest != '5'
            AND   typegest != '6'
            AND   :b1 = 'F'
        )
        OR    (
            (
                typegest = '5'
                OR    typegest = '6'
            )
            AND   :b1 = 'G'
        )
    )
    AND   topgu = 0
    AND   numcdeclt IS NULL
    AND   trunc(datehtrans) = (
        SELECT
            trunc(datehtrans)
        FROM
            (
                SELECT
                    datehtrans
                FROM
                    lbm_vente_poste v
                    LEFT JOIN lbm_cp_histo h ON v.cp = h.cp
                WHERE
                    stecaisse IN (
                        1,
                        2
                    )
                    AND   v.appl = 'SAP'
                    AND   v.hca IS NULL
                    AND   departement = :b2
                    AND   (
                        (
                            v.typegest != '5'
                            AND   v.typegest != '6'
                            AND   :b1 = 'F'
                        )
                        OR    (
                            (
                                v.typegest = '5'
                                OR    v.typegest = '6'
                            )
                            AND   :b1 = 'G'
                        )
                    )
                    AND   topgu = 0
                    AND   (
                        ( datehtrans < h.dateblocageinventaire )
                        OR    ( h.dateblocageinventaire IS NULL )
                        AND   numcdeclt IS NULL
                    )
                ORDER BY
                    datehtrans
            )
        WHERE
            ROWNUM <= 1
    )
    AND   (
        ( datehtrans < (
            SELECT
                dateblocageinventaire
            FROM
                lbm_cp_histo h
            WHERE
                h.cp = v.cp
        ) )
        OR    ( (
            SELECT
                dateblocageinventaire
            FROM
                lbm_cp_histo h
            WHERE
                h.cp = v.cp
        ) IS NULL )
    );

Execution Plan
----------------------------------------------------------

---------------------------------------------------------------------------------
| Id  | Operation                     | Name            | Rows  | Bytes | Cost  |
---------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |                 |     1 |    35 |   453K|
|   1 |  COUNT STOPKEY                |                 |       |       |       |
|   2 |   FILTER                      |                 |       |       |       |
|   3 |    TABLE ACCESS FULL          | LBM_VENTE_POSTE |     5 |   175 |   226K|
|   4 |     COUNT STOPKEY             |                 |       |       |       |
|   5 |      VIEW                     |                 |   464 |  4176 |   226K|
|   6 |       SORT ORDER BY STOPKEY   |                 |   464 | 20880 |   226K|
|   7 |        FILTER                 |                 |       |       |       |
|   8 |         HASH JOIN OUTER       |                 |   464 | 20880 |   226K|
|   9 |          TABLE ACCESS FULL    | LBM_VENTE_POSTE |   498 | 17430 |   226K|
|  10 |          TABLE ACCESS FULL    | LBM_CP_HISTO    |  9422 | 94220 |    21 |
|  11 |    TABLE ACCESS BY INDEX ROWID| LBM_CP_HISTO    |     1 |    10 |     2 |
|  12 |     INDEX UNIQUE SCAN         | LBM_CP_HISTO_PK |     1 |       |     1 |
|  13 |    TABLE ACCESS BY INDEX ROWID| LBM_CP_HISTO    |     1 |    10 |     2 |
|  14 |     INDEX UNIQUE SCAN         | LBM_CP_HISTO_PK |     1 |       |     1 |
---------------------------------------------------------------------------------

Note
-----
   - 'PLAN_TABLE' is old version


Statistics
----------------------------------------------------------
        383  recursive calls
          0  db block gets
        105  consistent gets
          0  physical reads
          0  redo size
        322  bytes sent via SQL*Net to client
       1394  bytes received via SQL*Net from client
          1  SQL*Net roundtrips to/from client
         10  sorts (memory)
          0  sorts (disk)


