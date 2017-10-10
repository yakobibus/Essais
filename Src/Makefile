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

HDR_LST = $(HDR_DIR)/Essais.h 
SRC_LST = $(SRC_DIR)/Essais.c 
OBJ_LST = $(OBJ_DIR)/Essais.o 


$(EXE_DIR)/Essais.exe : $(OBJ_LST)
	$(CC)  -o $(EXE_DIR)/Essais.exe $(OBJ_LST)

$(OBJ_DIR)/Essais.o : $(SRC_DIR)/Essais.c $(HDR_DIR)/Essais.h
	$(CC) $(ARGS) -c -o $(OBJ_DIR)/Essais.o $(SRC_DIR)/Essais.c -I $(HDR_DIR) -I $(CMN_HDR)


clean :
	rm -f $(EXE_DIR)/Essais.exe $(OBJ_DIR)/*.o
