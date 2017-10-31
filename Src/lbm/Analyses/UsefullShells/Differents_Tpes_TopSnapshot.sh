# Afficher les différents type de Top des différents SQL des snapshots


grep -h -e "SQL ordered by" sp__*.lst | cut -d' ' -f4- | cut -d':' -f1 | sort -u


#  CPU  DB/Inst
#  Elapsed  DB/Inst
#  Executions  DB/Inst
#  Gets  DB/Inst
#  Parse Calls  DB/Inst
#  Reads  DB/Inst
#  Sharable Memory  DB/Inst
#  Version Count  DB/Inst

# Soit :
#  SQL ordered by CPU  DB/Inst
#  SQL ordered by Elapsed  DB/Inst
#  SQL ordered by Executions  DB/Inst
#  SQL ordered by Gets  DB/Inst
#  SQL ordered by Parse Calls  DB/Inst
#  SQL ordered by Reads  DB/Inst
#  SQL ordered by Sharable Memory  DB/Inst
#  SQL ordered by Version Count  DB/Inst

