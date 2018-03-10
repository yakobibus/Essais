#! /usr/bin/bash

# Objet : 
# -----

# Historique des modifications :
# ----------------------------

declare -r STATUS_OK=0
declare -i STATUS_KO=1

declare -r defaltCSVfilename="Transaction.csv"
declare -i globalRetCode=${STATUS_OK}

function prnJSON {
    :
}

function main {
    local -i retCode=${STATUS_OK}

    gawk -e '
      function printFields (fieldsArray, fieldsCount)
      {
          for ( ii = 1 ; ii <= fieldsCount ; ++ii )
          {
              printf ("%2.2d [%s]\n", ii, fieldsArray [ii])
          }
      }

      {
          fieldContrat = 1
          fieldEffectiveStartDate = 3
          fieldDossier = 12
          fieldTiers = 15
          fieldMontant = 17
          #
          fieldsCount = split($0, fieldsArray, fieldsSeparator)
# printFields(fieldsArray, fieldsCount)
          #

          effectiveStartDate = fieldsArray[fieldEffectiveStartDate]
          gsub("/", "-", effectiveStartDate)

          montant = fieldsArray[fieldMontant]
          gsub(/\./, decimalSeparator, montant)
          # 

          if (fieldsCount == 18)
          {
            /* print $0 */
            if (NR == 1) {
                virgule = " "
            }
            else {
                virgule = ","
            }
            printf ("\t%s\t{\n", virgule)  # Entity begin bloc
            
            printf ("\t\t\t\"transactionids\" : \n")

            printf ("\t\t\t[\n")

            printf ("\t\t\t\t{\n") # Ids begin bloc
            printf ("\t\t\t\t\t\"scheme\" : \"CARDIF\"\n")
            printf ("\t\t\t\t,\t\"issuer\" : \"ORION\"\n")
            printf ("\t\t\t\t,\t\"id\" : \"%s-%s-%s-%s-%s\"\n", substr(fieldsArray[fieldContrat], 7, 11), fieldsArray[fieldDossier], fieldsArray[fieldTiers], "J", "E")
            printf ("\t\t\t\t}\n")  # Ids end bloc

            printf ("\t\t\t]\n")

            printf ("\t\t,\t\"transaction_detail\" : \n")

            printf ("\t\t\t[\n")
            printf ("\t\t\t\t{\n") # transaction_detail begin bloc
            printf ("\t\t\t\t\t\"effectivestartdate\" : \"%s\"\n", effectiveStartDate)
            printf ("\t\t\t\t,\t\"mnt_total_ht\" : \"%s\"\n", montant)
            printf ("\t\t\t\t}\n") # transaction_detail end bloc
            printf ("\t\t\t]\n")

            printf ("\t\t,\t\"link\" : \n")

            printf ("\t\t\t[\n")
            if (length(fieldsArray[fieldDossier]) > 0) {
                printf ("\t\t\t\t{\n") # DOS link begin bloc
                printf ("\t\t\t\t\t\"\" : \"%s\"\n", "TRA_VRS_DOS")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", "DOS")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", fieldsArray[fieldDossier])
                printf ("\t\t\t\t}\n") # DOS link end bloc
            }

            if (length(fieldsArray[fieldTiers]) > 0) {
                printf ("\t\t\t,\t{\n") # TRS link begin bloc
                printf ("\t\t\t\t\t\"\" : \"%s\"\n", "TRA_VRS_TRS")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", "TRS")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", fieldsArray[fieldTiers])
                printf ("\t\t\t\t}\n") # TRS link end bloc
            }

            if (length(fieldsArray[fieldContrat]) > 0) {
                printf ("\t\t\t,\t{\n") # CNT link begin bloc
                printf ("\t\t\t\t\t\"\" : \"%s\"\n", "TRA_VRS_CNT")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", "CNT")
                printf ("\t\t\t\t,\t\"\" : \"%s\"\n", substr(fieldsArray[fieldContrat], 7, 11))
                printf ("\t\t\t\t}\n") # CNT link end bloc
            }
            printf ("\t\t\t]\n")

            printf ("\t\t}\n")  # entity end bloc
          }

      }

      BEGIN {
          fieldsSeparator = "|"
          decimalSeparator = "."
          printf ("{\n\t\"entity.transaction\" :\n\t[\n")
      }

      END {
          printf ("\t]\n}\n")
      }
    ' ${defaltCSVfilename}
    # while read csvLine 
    # do
    #     #echo "${csvLine}"
    # done < ${defaltCSVfilename}

    prnJSON
    retCode=${?}

    return ${retCode}
}

main
globalRetCode=${?}

exit ${globalRetCode}
