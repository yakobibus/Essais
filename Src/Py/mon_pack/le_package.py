#! /usr/bin/python3
# -*-coding:Latin-1 -*

"""
    ceci est un exemple de lib dans mon package perso
"""

import os # pour l'appel de os.system() 

def affiche(a):
    """
        Function affiche
           objet : afficher entre crochets le param reçu
           exemple : affiche(23)
               [23]
    """
    print("[{0}]".format(a))

def table_par(quoi):
    """
        Affiche la table de multiplication par le parametre
    """
    #if type(quoi) == int:
    #    sz_quoi = len(str(quoi))
    #elif type(quoi) == str:
    #    sz_quoi = len(quoi)
    #else:
    #    sz_quoi = 2

    sz_quoi = len(str(quoi))
    sz_max = len(str(12 * quoi))
    #
    for pas in range(13):
        print(' . {:>{width}} x {:>2} ='.format(quoi, pas, width=sz_quoi), '{:>{width}}'.format(quoi * pas, width=sz_max))
 
# Test de la fonction affiche

if __name__ == "__main__":

    affiche('Attention, test de la function table_par(12) en cours ...')
    table_par(12)

    os.system("sleep .2s")
