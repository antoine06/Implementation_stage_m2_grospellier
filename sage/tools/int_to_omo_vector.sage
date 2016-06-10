


# Sur l'entree n0, cette fonction renvoie un vecteur de taille "dim" qui represente la decomposition binaire de n0. On utilise cette fonction principalement dans omo_generation.sage pour generer les vecteurs avec des 1 et des (-1).
# On doit avoir n0 < 2^dim
# Par exemple, on represente [-1,...,-1] par 0 et [1,...,1] par 2^(dim+1) - 1 et [-1,...,-1,1] by 1
def int_to_omo_vector(n0,dim):
	n = n0
	v = range(dim)
	for i in range(dim-1,-1,-1):
		if (mod(n,2) == 1):
			v[i] = 1
			n = (n-1)/2
		else:
			v[i] = -1
			n = n/2
	return v



# L'inverse: v est un vecteur avec des 1 et (-1) de taille dim
def omo_vector_to_int(v,dim):
	res = 0
	for i in range(dim):
		res = 2*res + (v[i]+1)/2
	return res

