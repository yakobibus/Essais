#! /usr/bin/python3
# -*-coding:Latin-1 -*

import random

def specifications():
    """
       Objet : donner les règles de l'application
    """
    specifs = """
    Notre règle du jeu
    ------------------
    Bon, la roulette, c'est très sympathique comme jeu, mais un peu trop compliqué
    pour un premier TP. Alors, on va simplifier les règles et je vous présente tout
    de suite ce que l'on obtient :
    Le joueur mise sur un numéro compris entre 0 et 49 (50 numéros en tout). En
    choisissant son numéro, il y dépose la somme qu'il souhaite miser.
    La roulette est constituée de 50 cases allant naturellement de 0 à 49. Les numéros
    pairs sont de couleur noire, les numéros impairs sont de couleur rouge. Le croupier
    lance la roulette, lâche la bille et quand la roulette s'arrête, relève le numéro
    de la case dans laquelle la bille s'est arrêtée. Dans notre programme, nous ne
    reprendrons pas tous ces détails « matériels » mais ces explications sont aussi à
    l'intention de ceux qui ont eu la chance d'éviter les salles de casino jusqu'ici.
    Le numéro sur lequel s'est arrêtée la bille est, naturellement, le numéro gagnant.
    Si le numéro gagnant est celui sur lequel le joueur a misé (probabilité de 1/50,
    plutôt faible), le croupier lui remet 3 fois la somme misée.
    Sinon, le croupier regarde si le numéro misé par le joueur est de la même couleur
    que le numéro gagnant (s'ils sont tous les deux pairs ou tous les deux impairs). Si
    c'est le cas, le croupier lui remet 50 % de la somme misée. Si ce n'est pas le cas,
    le joueur perd sa mise.
    
    Dans les deux scénarios gagnants vus ci-dessus (le numéro misé et le numéro gagnant
    sont identiques ou ont la même couleur), le croupier remet au joueur la somme
    initialement misée avant d'y ajouter ses gains. Cela veut dire que, dans ces deux
    scénarios, le joueur récupère de l'argent. Il n'y a que dans le troisième cas qu'il
    perd la somme misée. On utilisera pour devise le dollar $ à la place de l'euro pour
    des raisons d'encodage sous la console Windows.
    """
    # print(specifs)

def my_count(tableau):
    count = 0
    for i in tableau[:] :
        count = i
    return count

# Lambda functions :
couleur_case = lambda a : 'Rouge' if a % 2 == 0 else 'Noir'
pair_impair = lambda a : 'Pair' if a% 2 == 0 else 'Impair'

def saisir_mise(pot_de_depart):
    """
      Saisir un montant de mise au clavier et le retourner
      prm 1 : si b_pot_de_depart == True
                alors saisir la mise initiale (le pot de départ)
              sinon
                alors saisir la relance en cours dans la partie qui sera au maximum de pot_de_depart
      return : la somme misée (type float), positive ou nulle
    """
    if pot_de_depart == True and type(pot_de_depart) == type(True) :
        question = "Saisir la mise initiale dans le pot : "
        mise_max = 100.0
    elif type(float(pot_de_depart)) == type(0.01) :
        question = "Quelle est votre mise ({} au maximum) ? ".format(pot_de_depart)
        mise_max  = float(pot_de_depart)
    
    la_mise = -.01
    while la_mise < 0 or la_mise > mise_max :
        la_mise = input(question)
        try :
            la_mise = float(la_mise)
        except (ValueError) :
            la_mise = -.01
            print("Erreur de saisie, prière de saisir un montant numérique")
        
        #la_mise = float(la_mise) if type(float(la_mise)) == type(0.01) else -.01
    #
    return la_mise

def jeu_casino():
    """
       Pour les règles, se reporter aux spécifications
    """
    #roulette = [0:50]
    nb_cases = 19

    roulette = range (nb_cases) # (50)
    print(roulette)
    for i in roulette :
        if roulette[i]%2 == 0 : 
            couleur = 'Noir' 
        else: 
            couleur = 'Rouge'
        #print('{}.'.format(1+i), '{:>{width}}'.format(couleur, width=6), '<:{:>{width}}:>'.format(roulette[i], width=2))

    # Mise
    somme_misee = saisir_mise(77) ###  input("Quelle somme misez-vous ? ")
    case_pari = input("Sur quelle case misez-vous (entre 0 et {} )? ".format(-1 + nb_cases))

    # Tirer un nombre de 0 à 49 :
    tirage = random.randint(0, -1 + nb_cases) ## 49)
    print('Tirage = {}, couleur : {}'.format(tirage, couleur_case(tirage)))
    
    tx_gains = 52

    if tirage == int(case_pari):
        gains = tx_gains * int(somme_misee)
    elif couleur_case( tirage ) == couleur_case( int(case_pari) ) :
        gains = 1/2 * int(somme_misee)
    else :
        gains = 0
    #
    couleur_pari = couleur_case(int(case_pari))
    couleur_tirage = couleur_case(tirage)
    print('Pari : {} {}, tirage {} {}, mise : {}, Gains {} euros'.format(case_pari, couleur_pari, tirage, couleur_tirage, somme_misee, gains))

def the_main():
    """
      Objetct : fonction principale
      -------
    """
    jeu_casino()

    #
    if False:
        specifications()

# --------
the_main()