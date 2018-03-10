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
          fieldDoddier = 12
          fieldTiers = 15
          # 
          fieldsSeparator = "|"
          fieldsCount = split($0, fieldsArray, fieldsSeparator)
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

            printf ("\t\t\t\t{\n")
            printf ("\t\t\t\t\t\"scheme\" : \"CARDIF\"\n")
            printf ("\t\t\t\t,\t\"issuer\" : \"ORION\"\n")
            printf ("\t\t\t\t,\t\"id\" : \"%s%s\"\n", substr(fieldsArray[fieldContrat], 7, 11), "J-E")
            printf ("\t\t\t\t}\n")

            printf ("\t\t\t]\n")

            printf ("\t\t}\n")  # entity end bloc
          }

#printFields(fieldsArray, fieldsCount)
      }

      BEGIN {
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
