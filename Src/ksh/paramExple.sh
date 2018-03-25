# /usr/bin/bash

# paramExple.sh
# -------------

# An example of passing parameters to a scrpit an included functions

function f1 {
    local -i argc=$#

    echo "   dans f1 : $argc vars :"
    local -i i=0;

    for toto in  "${@}" ; do
       i=$(( 1 + $i ))
       echo "   "${i}. $toto
    done
}

declare -ir tmStart=$( date +%s )
declare -r ARGC=${#}
declare -i ii=0
declare -a anArray

echo "Il y a $ARGC vars, le dernier est <${!ARGC}> [${0##*/}]: "

for titi in "${@}"  ; do 
    anArray[${ii}]="${titi}"
    ii=$(( 1 + $ii ))
    echo ${ii}. $titi , " tbl ->(${#anArray[*]}) : ["${anArray[$(( -1 + ${ii} ))]}"]"

    f1 ${titi}
done

ii=0
sleep 1

while [[ $ii -lt 9000 ]] ; do
  echo -n -e ".\b"
  ii=$(( 1 + $ii ))
done
echo 

declare tmEnd=$( date +%s )
echo Durée de ${tmStart} à ${tmEnd} ":" $(( ${tmEnd} - ${tmStart} )) "seconde(s)"

