#! /usr/bin/ksh

# Afficher dans l'ordre les occurences de snap pour l'ordre UP...

for fifi in $( grep -i -e "UPDATE LBM_VENTE_POSTE V SET TOPGU = 2 WHERE STECAISSE IN (1, 2)" sp__*.lst | cut -d':' -f1 | sort -u  ) 
do
   grep -e "Begin Snap:" $fifi | cut -d":" -f2- | cut  -c12-30  
done | sort
