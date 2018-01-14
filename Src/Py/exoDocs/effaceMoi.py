#! /usr/bin/python3.6
# -*- coding: latin-1 -*-

class MyEmptyClass(object):
    """
      A minimal class definition with an initialize function as bonus
    """
    def __init__(self):
        """
          initialize MyEmptyClass
        """
        print("Je suis, {}, une classe minimale".format(self.__class__.__name__))
    
    def dummy(self):
        """
          non sense obviously
        """
        pass
    
    # pass
# ----
def print_values(**kwargs):
    for key, value in kwargs.items():
        print("The value of {} is {}".format(key, value))
def print_values_2(**kwargs):
    for key in kwargs:
        print("The value of {} -> {}".format(key, kwargs[key]))

print_values(my_name="Sammy", your_name="Casey")
print_values_2(my_name="Sammy", your_name="Casey")

# ----

def func_with_dico(**dico):
    """
       object  : Howto use a dictionnary parameter
       example : func_with_dico(enseigne = "LBM", rayon = "epicerie", marchandise = "Saumon fumé")
    """
    for d in dico:
        print("key:{} := value:{}".format(d, dico[d]))

def epelle(mot, sens_positif=True):
    """
        Objet   : epelle le mot reCu en parametre
        Params  : le mot A epeller
                : le sens positif/negatif (True/False), positif par defaut
        Return  : none
        Exemple : epelle("Je suis parvenu au firmament de la connaissance du langage serpentin ...")
    """
    if sens_positif :
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