## Ce fichier contient des fonctions qui permettent de vérifier si deux iterateurs de matrices generent le meme ensemble de matrice. On l'utilise notamment dans zomoon_generation.sage
##################################################################################################################################

# Cree un tuple a partir d'une matrice
def matrix_to_tuple(M):
	return (tuple(M.list()))



# Cree un ensemble de tuples a partir d'un iterateur de matrices
def it_to_set(it):
	return Set([matrix_to_tuple(U) for U in it])

# Compte le nombre matrices differentes d'un iterateur
def card_matrix_it(it):
	matrix_set = it_to_set(it)
	return (matrix_set.cardinality())






















