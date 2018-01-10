#! /usr/bin/python3.6

class MyEmptyClass(): ### (object):
    """
      A minimal class definition with an initialize function as bonus
    """
    def __init__(self):
        print("Je suis une classe minimale")
    
    pass

def epelle(mot, sensPositif = True):
    """
        Objet   : epelle le mot reCu en parametre
        Params  : le mot A epeller
                : le sens positif/negatif (True/False), positif par defaut
        Return  : none
        Exemple : epelle("Je suis parvenu au firmament de la connaissance du langage serpentin ...")
    """
    if sensPositif :
        for l in enumerate(mot):
            i, c = l
            print("Position[{:>2}] : {}".format(i, c))
    else :
        i = -1
        n = -1 * len(mot)
        while i >= n :
            print("Position[{:>3}] : {}".format(-n + i, mot[i]))
            i -= 1

def main():
    """
        main (function)
        ----   object  : base and first function of the program
               Params  : none
               Return  : none
               Example : main()
    """
    mot = "A-ha ha, vous n'avez pas dit le mot magique.\nQuel est le mot magique ?"
    print("\nA l'endroit :")
    epelle(mot)
    print("\nEt à l'envers :")
    epelle(mot, False)

main()
mec = MyEmptyClass()
#help(mec)

#help(main)
# ------
#
#mot = "Que pensez-vous de toute cette enqueête qui est sans doute très proche de vous ?"
#i = -1
#n = -1 * len(mot)
#while i >= n :
#    print("{:>3}. {}".format(-n + i, mot[i]))
#    i -= 1
##