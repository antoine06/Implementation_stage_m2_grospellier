# Ce fichier permet de creer des etats et des transformation quantiques
#####################################################################################################################




# Cette fonction renvoie |i> de dimension "dim" 
def ket(i,dim):
	res = matrix(dim,1)
	res[i] = 1
	return res

# Cette fonction renvoie <i| de dimension "dim" 
def bra(i,dim):
	res = ket(i,dim)
	return (res.transpose())


# Renvoie l'etat maximalement intrique de dimension (dim*dim), c'est a dire (sum_i (|i> tensor |i>))
def maximally_entangled_state(dim):
	res = matrix(dim*dim,1)
	for i in range(dim):
		res = res + (ket(i,dim).tensor_product(ket(i,dim)))
	res = res / (sqrt(dim))
	return res


# Renvoie H^logd ou H est la trasformation de Hadamard. La matrice renvoyee est de dimension 2^logd
def compute_Hadamard_transformation(logd):
	H = 1/sqrt(2) * matrix(2,2,[1,1,1,-1])
	if logd == 0:
		return matrix(1,[1])
	else :
		H = 1/sqrt(2) * matrix(2,2,[1,1,1,-1])
		return (H.tensor_product(compute_Hadamard_transformation(logd-1)))

