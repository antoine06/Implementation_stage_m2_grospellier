# Dans ce fichier on genere toutes les matrices unitaires avec des 1 et des (-1)
# int_to_omo_vector est defini dans tools/int_to_omo_vector.sage
# On represente un vecteur de 1 et (-1) par un nombre. Par exemple, on represente [-1,...,-1] par 0 et [1,...,1] par 2^(dim+1) - 1 et [-1,...,-1,1] by 1
# omo = one_minus_one matrice: matrice avec des 1 et -1
# omoog = omo matrice avec des colonnes orthogonales
# omoon = omo matrice avec des colonnes orthonormales. C'est a dire une matrice unitaire avec des 1 et (-1)
########################################################################################################################

load("tools/trace_distance.sage")
load("tools/int_to_omo_vector.sage")


# Renvoie un iterateur de omoon en supposant que it_omoog est un iterateur de omoog
def it_omoog_to_it_omoon(it_omoog,dim):
	for M in it_omoog:
		yield(1/sqrt(dim) * M)

# Renvoie un iterateur de omoon dans les flottants en supposant que it_omoog est un iterateur de omoog
def it_omoog_to_it_omoon_float(it_omoog,dim):
	for M in it_omoog:
		yield(float(1/sqrt(dim)) * M)



## La fonction generate_omoog generent toutes les omoon matrices
# Dans generate_omoog_rec(potential_vector0,k,omo_matrix,dim), on suppose que l'on a trouve k omo vecteurs orthogonaux entre eux contenus dans les k premieres colonnes de omo_matrix. potential_vector0 est le set des vecteurs orthogonaux à ces k omo vecteurs.
def generate_omoog_rec(potential_vector0,k,omo_matrix,dim):
	if (k>=dim):
		yield transpose(omo_matrix)
	else:
		for i in range(len(potential_vector0)):
			omo_matrix[k] = potential_vector0[i]
			potential_vector = [v for v in potential_vector0[i+1:] if (omo_matrix[k] * matrix(dim,1,v) == 0)]
			for omo_matrix_res in generate_omoog_rec(potential_vector,k+1,omo_matrix,dim):
				yield(omo_matrix_res)


# On genere en fait des omoon matrices avec les colonnes triees. En effet, appliquer une permutation sur les colonnes ne change pas la val de la matrice. Pour generer toutes les matrices il suffit de decommente les 4 lignes.

def generate_omoog(dim):
#	perm = Permutations(dim)
	for omo_matrix in generate_omoog_rec([int_to_omo_vector(i,dim) for i in range(2**dim)],0,matrix(dim,dim),dim):
		yield(omo_matrix)
#		for p in perm.list():
#			P = Permutation(p).to_matrix()
#			yield (omo_matrix*P)














