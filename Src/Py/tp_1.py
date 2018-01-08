#! /usr/bin/python3
# -*-coding:Latin-1 -*

"""
premier tp
"""

def est_bissextile(annee):
  """
  Verifie que l'année est bisextile ou non
    parametres :
      :param annee: l'année
      :type annee: int
      :return: la reponse
      :rtype: bool
    retourne True/False
  """
  code_ret = False

  if annee % 400 == 0 or (annee % 4 == 0 and annee % 100 != 0):
      code_ret = True 

  return code_ret

def table_par(quoi):
  """
  Affiche la table de multiplication
  """
  for pas in range (11):
    print ('{:>2} x {:>2} = {:>2}'.format(quoi, pas, quoi * pas))

def main():
  """
  ppale fct
  """
  annee = input("Saisissez une année : ")
  annee = int(annee)
  if True == est_bissextile (annee):
    print("L'année ", annee, " est bisextile")
  else :
    print("Falsch ! ", annee, " n'a rien de bisext.")

  table_par(7)

help(est_bissextile)
main()
