# Makefile du projet Essais
# ----------------------
#

CC = g++
ARGS = -std=c++17

PRG_HOME = /cygdrive/c/Users/Jacques/GitHubRepository/Essais

EXE_DIR = .
OBJ_DIR = ./Obj

# --

CMN_DIR = $(PRG_HOME)/Src/Common
CMN_SRC = $(CMN_DIR)/C
CMN_HDR = $(CMN_DIR)/H

PRG_DIR = $(PRG_HOME)/Src
SRC_DIR = $(PRG_DIR)/C
HDR_DIR = $(PRG_DIR)/H

HDR_LST = $(HDR_DIR)/Essais.h $(HDR_DIR)/Essai_1.h $(HDR_DIR)/Smart_Ptr.h $(HDR_DIR)/fileEssais.h $(HDR_DIR)/Exple_1.h $(HDR_DIR)/Music.h
SRC_LST = $(SRC_DIR)/Essais.c $(SRC_DIR)/Essai_1.c $(SRC_DIR)/Smart_Ptr.c $(SRC_DIR)/fileEssais.c $(SRC_DIR)/Exple_1.c $(SRC_DIR)/Music.c
OBJ_LST = $(OBJ_DIR)/Essais.o $(OBJ_DIR)/Essai_1.o $(OBJ_DIR)/Smart_Ptr.o $(OBJ_DIR)/fileEssais.o $(OBJ_DIR)/Exple_1.o $(OBJ_DIR)/Music.o


$(EXE_DIR)/Essais.exe : $(OBJ_LST)
	$(CC)  -o $(EXE_DIR)/Essais.exe $(OBJ_LST)

$(OBJ_DIR)/Essais.o : $(SRC_DIR)/Essais.c $(HDR_DIR)/Essais.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Essais.o $(SRC_DIR)/Essais.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/Essai_1.o : $(SRC_DIR)/Essai_1.c $(HDR_DIR)/Essai_1.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Essai_1.o $(SRC_DIR)/Essai_1.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/Smart_Ptr.o : $(SRC_DIR)/Smart_Ptr.c $(HDR_DIR)/Smart_Ptr.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Smart_Ptr.o $(SRC_DIR)/Smart_Ptr.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/fileEssais.o : $(SRC_DIR)/fileEssais.c $(HDR_DIR)/fileEssais.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/fileEssais.o $(SRC_DIR)/fileEssais.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/Exple_1.o : $(SRC_DIR)/Exple_1.c $(HDR_DIR)/Exple_1.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Exple_1.o $(SRC_DIR)/Exple_1.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/Music.o : $(SRC_DIR)/Music.c $(HDR_DIR)/Music.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Music.o $(SRC_DIR)/Music.c -I $(HDR_DIR) -I $(CMN_HDR)


clean :
	rm -f $(EXE_DIR)/Essais.exe $(OBJ_DIR)/*.o
