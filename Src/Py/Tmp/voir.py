def cheeseshop(kind, *arguments, **keywords):
    print("-- Do you have any", kind, "?")
    print("-- I'm sorry, we're all out of", kind)
    for arg in arguments:
        print("++", arg)
    print("-" * 40)
    for kw in keywords:
        print(kw, ":", keywords[kw])

cheeseshop("Limburger"
    , "It's very runny, sir."
    , "It's really very, VERY runny, sir."
    , shopkeeper = "Michael Palin"
    , client = "John Cleese"
    , sketch = "Cheese Shop Sketch"
    , spectator = "The-Curious Bibi Fricotin"
    )

def organisation (serie, cle=1) :
    dummy = serie
    dummy.sort(key = lambda pair : pair[cle])
    
serie_1 = [(1, "Jean LECAT"), (2, "Paul Escambe"), (3, "Tawny Edgecombe"), (4, "Zoe Silverbarbe"), (5, "Esther Amblin")]
print("Avant : ", serie_1)
organisation (serie_1)
print("Apres", serie_1)

organisation (serie_1, 0)
print("Original : ", serie_1)

serie_2 = [(1, "Jean", "LECAT"), (5, "Esther", "Amblin"), (4, "Zoe", "Silverbarbe"), (2, "Paul", "Escambe"), (3, "Tawny", "Edgecombe")]
print("Sans tri : ", serie_2)
organisation(serie_2, 0)
print("Tri sur Id :", serie_2)
organisation(serie_2, 1)
print("Tri sur Prenom ", serie_2)
organisation(serie_2, 2)
print("Tri sur le Nom : ", serie_2)
