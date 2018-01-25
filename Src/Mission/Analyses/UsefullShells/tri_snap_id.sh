# Affichage des date / heure et id des snapshot

for fifi in $( ls -m1 sp__*.lst ) 
do
  echo $( awk '/Begin Snap/ {printf ("%s %s\n" , $4, $5) }' ${fifi} ) $( echo ${fifi} | awk -F"_" '{printf ("%6.6d %6.6d\n", $3, $4) }' ) $( echo "  " ${fifi})
done  > ../Tmp/Liste_Snap_Id_Horodate.lst

sort ../Tmp/Liste_Snap_Id_Horodate.lst > ../Tmp/../Tmp/ListeTriee_Snap_Id_Horodate.lst
