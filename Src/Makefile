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

HDR_LST = $(HDR_DIR)/Essais.h $(HDR_DIR)/Essai_1.h
SRC_LST = $(SRC_DIR)/Essais.c $(SRC_DIR)/Essai_1.c
OBJ_LST = $(OBJ_DIR)/Essais.o $(OBJ_DIR)/Essai_1.o


$(EXE_DIR)/Essais.exe : $(OBJ_LST)
	$(CC)  -o $(EXE_DIR)/Essais.exe $(OBJ_LST)

$(OBJ_DIR)/Essais.o : $(SRC_DIR)/Essais.c $(HDR_DIR)/Essais.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Essais.o $(SRC_DIR)/Essais.c -I $(HDR_DIR) -I $(CMN_HDR)

$(OBJ_DIR)/Essai_1.o : $(SRC_DIR)/Essai_1.c $(HDR_DIR)/Essai_1.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Essai_1.o $(SRC_DIR)/Essai_1.c -I $(HDR_DIR) -I $(CMN_HDR)


clean :
	rm -f $(EXE_DIR)/Essais.exe $(OBJ_DIR)/*.o
