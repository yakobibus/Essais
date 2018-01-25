

----
DEFINE schema_common  = own_07755_comm
DEFINE schema_dataservice = own_07755_ds
DEFINE schema_trans = own_07755_trans
DEFINE schema_trans_globale = own_07755_transglobale
----

create or replace package &&schema_trans..p_transaction is
  procedure setTransaction( JsonData in varchar2 ) ; -- Procédure d'alimentation de la transaction
end p_transaction ;
/
show errors

create or replace package body &&schema_trans..p_transaction is
  procedure setTransaction( JsonData in varchar2 ) is
    /* Objet      : Procédure d'alimentation de la transaction creation/maj
 ** Parametres :
 **   - JsonData : donnees d'alimentaion de la transaction
    ** Appel      :
        p_transaction.setTransaction(JsonData => '[
            {"id_me": "value"
          , "id_flex_1": "value"
          , ...
          , "cd_type_cre": "value"
          }
        , {"id_me": "value"
          , "id_flex_1": "value"
          , ...
          , "cd_type_cre": "value"
          }
          ]'
        );
 **/
    cursor cur_json_custom_view (json_array in varchar2) is
      with json_custom_view as
      (
        select json_array as json_array from dual
      )
      select jt.id_me
           , jt.id_flex_1
           , jt.id_flex_2
           , jt.id_flex_3
           , jt.id_flex_4
           , jt.id_tr
           , jt.id_cre
           , jt.dt_effet
           , jt.dt_connaissance
           , jt.dt_comptable
           , jt.id_societe
           , jt.cd_devise
           , jt.cd_source
           , jt.cd_exercice
           , jt.cd_periode
           , jt.cd_rubrique
           , jt.cd_sens
           , jt.mt_prime_ht_tot
           , jt.cd_type_cre
        from json_table
             (
               (select json_custom_view.json_array from json_custom_view)
             , '$[*]' columns
               (
                 id_me           varchar2 path '$.id_me'
               , id_flex_1       varchar2 path '$.id_flex_1'
               , id_flex_2       varchar2 path '$.id_flex_2'
               , id_flex_3       varchar2 path '$.id_flex_3'
               , id_flex_4       varchar2 path '$.id_flex_4'
               , id_tr           varchar2 path '$.id_tr'
               , id_cre          varchar2 path '$.id_cre'
               , dt_effet        varchar2 path '$.dt_effet'
               , dt_connaissance varchar2 path '$.dt_connaissance'
               , dt_comptable    varchar2 path '$.dt_comptable'
               , id_societe      varchar2 path '$.id_societe'
               , cd_devise       varchar2 path '$.cd_devise'
               , cd_source       varchar2 path '$.cd_source'
               , cd_exercice     varchar2 path '$.cd_exercice'
               , cd_periode      varchar2 path '$.cd_periode'
               , cd_rubrique     varchar2 path '$.cd_rubrique'
               , cd_sens         varchar2 path '$.cd_sens'
               , mt_prime_ht_tot varchar2 path '$.mt_prime_ht_tot'
               , cd_type_cre     varchar2 path '$.cd_type_cre'
               )
             ) jt       
    ;
  begin
    <<>> ;
    -- Determiner la taille du tableau json
    -- Valide la structure json
    --
  end setTransaction ;
end p_transaction ;
/
show errors


grant execute on &&schema_trans..p_transaction to &&schema_common. ;

------

set serveroutput on size 1000000
declare
    cursor cur_json_custom_view (json_array in varchar2) is
      with json_custom_view as
      (
        select json_array as json_array from dual
      )
      select jt.id_me
           , jt.id_flex_1
           , jt.id_flex_2
           , jt.id_flex_3
           , jt.id_flex_4
           , jt.id_tr
           , jt.id_cre
           , jt.dt_effet
           , jt.dt_connaissance
           , jt.dt_comptable
           , jt.id_societe
           , jt.cd_devise
           , jt.cd_source
           , jt.cd_exercice
           , jt.cd_periode
           , jt.cd_rubrique
           , jt.cd_sens
           , jt.mt_prime_ht_tot
           , jt.cd_type_cre
        from json_table
             (
               (select json_custom_view.json_array from json_custom_view)
             , '$[*]' columns
               (
                 id_me           varchar2 path '$.id_me'
               , id_flex_1       varchar2 path '$.id_flex_1'
               , id_flex_2       varchar2 path '$.id_flex_2'
               , id_flex_3       varchar2 path '$.id_flex_3'
               , id_flex_4       varchar2 path '$.id_flex_4'
               , id_tr           varchar2 path '$.id_tr'
               , id_cre          varchar2 path '$.id_cre'
               , dt_effet        varchar2 path '$.dt_effet'
               , dt_connaissance varchar2 path '$.dt_connaissance'
               , dt_comptable    varchar2 path '$.dt_comptable'
               , id_societe      varchar2 path '$.id_societe'
               , cd_devise       varchar2 path '$.cd_devise'
               , cd_source       varchar2 path '$.cd_source'
               , cd_exercice     varchar2 path '$.cd_exercice'
               , cd_periode      varchar2 path '$.cd_periode'
               , cd_rubrique     varchar2 path '$.cd_rubrique'
               , cd_sens         varchar2 path '$.cd_sens'
               , mt_prime_ht_tot varchar2 path '$.mt_prime_ht_tot'
               , cd_type_cre     varchar2 path '$.cd_type_cre'
               )
             ) jt       
    ;
    --
    subtype ty_cur_json_custom_view is cur_json_custom_view%rowtype ;
    type tbl_ty_cur_json_custom_view is table of ty_cur_json_custom_view index by pls_integer ;
    --
    arr_transaction_data tbl_ty_cur_json_custom_view;
    --
    procedure pLire(pvc_json_arr in varchar2) is
    begin
      open cur_json_custom_view (pvc_json_arr);
      loop
        fetch cur_json_custom_view bulk collect into arr_transaction_data ;
        if (arr_transaction_data.count > 0) then
          for ii in 1 .. arr_transaction_data.count loop
            dbms_output.put_line ('id_me ('|| ii || ') :: ' || arr_transaction_data(ii).id_me)  ;
          end loop ;
        end if ;
        exit when cur_json_custom_view%notfound ;
      end loop ;
      close cur_json_custom_view;
    end pLire;
begin
  pLire ( '[  {"id_me": "value"
  , "id_flex_1": "value"
  , "id_flex_2": "value"
  , "id_flex_3": "value"
  , "id_flex_4": "value"
  , "id_tr": "value"
  , "id_cre": "value"
  , "dt_effet": "value"
  , "dt_connaissance": "value"
  , "dt_comptable": "value"
  , "id_societe": "value"
  , "cd_devise": "value"
  , "cd_source": "value"
  , "cd_exercice": "value"
  , "cd_periode": "value"
  , "cd_rubrique": "value"
  , "cd_sens": "value"
  , "mt_prime_ht_tot": "value"
  , "cd_type_cre": "value"
  }
, {"id_me": "value"
  , "id_flex_1": "value"
  , "id_flex_2": "value"
  , "id_flex_3": "value"
  , "id_flex_4": "value"
  , "id_tr": "value"
  , "id_cre": "value"
  , "dt_effet": "value"
  , "dt_connaissance": "value"
  , "dt_comptable": "value"
  , "id_societe": "value"
  , "cd_devise": "value"
  , "cd_source": "value"
  , "cd_exercice": "value"
  , "cd_periode": "value"
  , "cd_rubrique": "value"
  , "cd_sens": "value"
  , "mt_prime_ht_tot": "value"
  , "cd_type_cre": "value"
  }
  ]' );
end ;


