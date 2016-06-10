# zomo = zero_one_minus_one matrix: matrices avec des 0, 1 et -1
# zdomoog = zdomo matrice avec des colonnes orthogonales
# zdomoon = zdomo matrice avec des colonnes orthonormales
# nb_0 = nombres de 0 par colonne d'une zdomoon

load("tools/trace_distance.sage")
load("test_val/printer.sage")
load("tools/matrix_to_tuple.sage")

# Renvoie un iterateur de zomoon quand it_zomoog est un iterateur de zomoog
def it_zomoog_to_it_zomoon(it_zdomoog,dim,nb_0):
	for M in it_zdomoog:
		yield(1/sqrt(dim-nb_0) * M)

# Idem mais les matrices sont dans les flotants
def it_zomoog_to_it_zomoon_float(it_zomoog,dim,nb_0):
	f = float(1/sqrt(dim-nb_0))
	for M in it_zomoog:
		yield(f * M)


# Renvoie une liste de tous les vecteurs de taille dim avec des 0/1/-1 et nb_0 0
def create_initial_potential_vector_zomoon(dim,nb_0):
	potential_vector = []
	for S_not0 in Subsets(range(dim),dim - nb_0):
		v0 = matrix(1,dim)
		for i in S_not0:
			v0[0,i] = -1
		for S1 in Subsets(S_not0):
			v = copy(v0)
			for i in S1:
				v[0,i] = 1
			potential_vector.append(v)
	return potential_vector







# Genere tous les zomoog avec nb_0 0 par colonne
def generate_zomoog_rec(k,zomo_matrix,dim,nb_0,potential_vector):
	if (k>=dim):
		yield transpose(zomo_matrix)
	else:
		for i in range(len(potential_vector)):
			v = potential_vector[i]
			zomo_matrix[k] = v
			for zomo_matrix_res in generate_zomoog_rec(k+1,zomo_matrix,dim,nb_0,[v for v in potential_vector[i+1:] if (zomo_matrix[k] * transpose(v)) == 0]):
				yield(zomo_matrix_res)


# 
def generate_zomoog(dim,nb_0):
	perm = Permutations(dim)
	potential_vector0 = create_initial_potential_vector_zomoon(dim,nb_0)
	for zomoog_matrix in generate_zomoog_rec(0,matrix(dim,dim),dim,nb_0,potential_vector0):
		for p in perm.list():
			P = Permutation(p).to_matrix()
			yield (zomoog_matrix*P)


# Genere tous les zomoog
def it_zomoon0(dim):
	for nb_0 in range(dim):
		for M in it_zomoog_to_it_zomoon(generate_zomoog(dim,nb_0),dim,nb_0):
			yield(M)

def it_zomoon_float0(dim) :
	for nb_0 in range(dim):
		print "nb_0 = ", nb_0
		for M in it_zomoog_to_it_zomoon_float(generate_zomoog(dim,nb_0),dim,nb_0):
			yield(M)


###############################################################################################################
# On fixe nb_0 = n-2
###############################################################################################################
# Renvoie une matrice par blocs 2x2. Les nb_block1 premiers blocs sont [1,1,1,-1] et les autres [-1,-1,1,-1]
def create_basic_zomoog_2_0(dim,nb_block1):
	if (mod(dim,2) != 0):
		print "dim must be even"
		abort
	M0 = matrix(dim)
	for i in range(nb_block1):
		M0[2*i,2*i] = 1
		M0[2*i,2*i+1] = 1
		M0[2*i+1,2*i] = 1
		M0[2*i+1,2*i+1] = -1
	for i in range(nb_block1,dim/2):
		M0[2*i,2*i] = -1
		M0[2*i,2*i+1] = -1
		M0[2*i+1,2*i] = 1
		M0[2*i+1,2*i+1] = -1
	return M0




# Renvoie une matrice par blocs 2x2 avec des blocs [1,1,1,-1]
def create_first_zomoog_2_0(dim):
	return(create_basic_zomoog_2_0(dim,dim/2))




# iterateur de certaines zomoon_2_0 tel que toutes probabilite de succes de zomoon_2_0 sont atteintes
def it0_some_zomoog_2_0(dim):
	U0 = create_first_zomoog_2_0(dim)
	perm = Permutations(dim)
	for p in perm:
		U = p.to_matrix() * U0
		yield(U)


def it0_some_zomoon_2_0(dim):
	for U in it0_some_zomoog_2_0(dim):
		yield(1/sqrt(2) * U)






def it0_some_zomoon_2_0_float(dim):
	f = float(1/sqrt(2))
	for U in it0_some_zomoog_2_0(dim):
		yield(f * U)




# Cette fonction renvoie une zomoog_2_0 avec la probabilite de succes optimale
def optimal_zomoog_2_0(dim):
	U0 = create_first_zomoog_2_0(dim)
	p = Permutation([ZZ(mod(i+2,dim))+1 for i in range(dim)])
	U = p.to_matrix() * U0
	return(U)











