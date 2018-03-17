# /usr/bin/bash

# paramExple.sh
# -------------

# An example of passing parameters to a scrpit an included functions

function f1 {
    local -i argc=$#

    echo "   dans f1 : $argc vars :"
    local -i i=0;

    for toto in "$@" ; do
       i=$(( 1 + $i ))
       echo "   "$i. $toto
    done
}

declare -r ARGC=${#}
declare -i ii=0
declare -a anArray

echo "Il y a $ARGC vars : "

for titi in "${@}"  ; do 
    anArray[${ii}]="${titi}"
    ii=$(( 1 + $ii ))
    echo $ii. $titi , " tbl ->(${#anArray[@]}) : ["${anArray[$(( -1 + ${ii} ))]}"]"

    f1 ${titi}
done

