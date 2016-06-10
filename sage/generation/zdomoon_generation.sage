## Dans ce fichier on genere toutes les matrice unitaires avec des zeros sur la diagoale et des 1 (-1) ailleurs.
# zdomo = zero diagonal one minus one matrix: matrice avec des 0 sur la diagonale et des 1 et -1 ailleurs
# zdomoog = zdomo matrice avec des colonnes orthogonales
# zdomoon = zdomo matrice avec des colonnes orthonormales (c'est a dire une matrice unitaire)

load("tools/trace_distance.sage")
load("tools/int_to_omo_vector.sage")




# Renvoie une iterateur zdomoon quand it_zdomoog est un iterateur de zdomoog
def it_zdomoog_to_it_zdomoon(it_zdomoog,dim):
	for M in it_zdomoog:
		yield(1/sqrt(dim-1) * M)

# Renvoie une iterateur zdomoon flottant quand it_zdomoog est un iterateur de zdomoog
def it_zdomoog_to_it_zdomoon_float(it_zdomoog,dim):
	f = float(1/sqrt(dim-1))
	for M in it_zdomoog:
		yield(f * M)


# potential_vector est une liste de tous les vecteurs avec un 0 sur la kieme entree et des 1/-1 ailleurs
def create_initial_potential_vector_zdomoon(k,dim):
	potential_vector = []
	for i in range(2**(dim-1)):
		v0 = int_to_omo_vector(i,dim-1)
		v = matrix(1,dim)
		for j in range(k):
			v[0,j] = v0[j]
		for j in range(k+1,dim):
			v[0,j] = v0[j-1]
		potential_vector.append(v)
	return potential_vector






## La fonction generate_zdomoog generent toutes les zdomoon matrices
# Dans generate_zdomoog_rec(k,zdomo_matrix,dim), on suppose que l'on a trouve k zdomo vecteurs orthogonaux entre eux contenus dans les k premieres colonnes de zdomo_matrix.

def generate_zdomoog_rec(k,zdomo_matrix,dim):
	if (k>=dim):
		yield transpose(zdomo_matrix)
	else:
		potential_vector = create_initial_potential_vector_zdomoon(k,dim)
		for j in range(k):
			potential_vector = [v for v in potential_vector if (zdomo_matrix[j] * transpose(v)) == 0]
		for v in potential_vector:
			zdomo_matrix[k] = v
			for zdomo_matrix_res in generate_zdomoog_rec(k+1,zdomo_matrix,dim):
				yield(zdomo_matrix_res)


def generate_zdomoog(dim):
	for zdomoog_matrix in generate_zdomoog_rec(0,matrix(dim,dim),dim):
		yield(zdomoog_matrix)










