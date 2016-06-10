# On utilise le fichier test_val/test_dependency.sage


verbose = 0


#################################################################################################################
# On regarde pour le subset channel comment la probabilite de succes depend de n et t
# Pour cette partie on peut modifier les parametres "n" et "nb_tests" (nb_tests = 0 signifie que le test n'est pas fait)
load("test_val/test_dependency.sage")

#### On calcule val de U pour tout t pour U generee au hasard
# Il semble que val(U,n,n-t) = val(U,n,t) et val est croissant pour t dans [|1,n//2|] et decroissant pour t dans [|(n+1)//2,n|]
# resultat apres tests: ca semble vrai...
n = 8; nb_tests = 0; test_dependency_val_t_random(n,nb_tests)



### On verifie si val(t1,U1) et val(t1,U2) sont dans le meme ordre que val(t2,U1) et val(t2,U2) (pour l'odre < sur les reels)
## Resultat apres tests : Ca semble faux...
n = 4; nb_matrices = 0;test_order_val_t_random(n,nb_matrices)




### On verifie que pour une matrice donnee, la probabilite de gagner diminue lorsque t augmente
# Resultat apres tests: ca semble vrai...
n = 8; nb_tests = 0; test_dependency_t_random(n,nb_tests)



# On verifie que pour une matrice donnee U, val(U) <= val(U1) ou U1 est de taille (n+1) avec U en haut a gauche et un 1 en bas a droite
### Resultat apres tests : ca a l'air tout le temps faux
n = 8; t =4; nb_tests = 0; test_dependency_n_random(n,t,nb_tests)



#### On calcul le biais de U pour tout t
# Il semble que biais(U,n-t) = biais(U,t) et biais est croissant pour t dans [|1,n//2|] et decroissant pour t dans [|(n+1)//2,n|]
# Resultat apres tests: ca semble vrai
n = 8; nb_tests = 0; test_dependency_bias_t_random(n,nb_tests)


### On verifie si biais(t1,U1) et biais(t1,U2) sont dans le meme ordre que val(t2,U1) et val(t2,U2) (pour l'odre < sur les reels)
## Resultat apres tests : Ca semble faux...
n = 4; nb_tests = 0;test_order_bias_t_random(n,nb_tests)


