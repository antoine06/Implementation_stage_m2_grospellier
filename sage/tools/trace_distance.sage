## Dans ce fichier, on implemente le calcul de la norme trace et on l'applique au calcul des probabilite de gagner

load("tools/quantum_basis.sage")


# Renvoie la somme des valeurs absolue des valeurs propres d'une matrice. C'est à dire la norme trace si A est hermitienne
def trace_norm(A):
	res = 0;
	for eigen in A.eigenvalues():
		res = res + abs(eigen)
	return res


# Renvoie l'etat (1/t * sum_{x in y} |x >< x|)
def compute_rhoy(y,n0,t0):
	rho = matrix(n0,n0)
	for x in y:
		rho = rho + ket(x,n0) * bra(x,n0)
	rho = rho/t0
	return rho


# Renvoie l'etat (sum_{x in y} |x >< x|)
def compute_gammay(y,n0):
	return(compute_rhoy(y,n0,1))


# Renvoie val(n,t,U)
def val(U,n,t):
	res = 0
	for y in Subsets(range(n),t):
		if verbose:
			print y
		gamma = compute_gammay(y,n)
		norm = (trace_norm(gamma - U*gamma*(U.H)))
		res = res + norm
	return res

def val_to_proba_success(v,n,t):
	return (1/2 + v/(4 * n * binomial(n-1,t-1)))

def proba_success_to_val(p,n,t):
	return ((p - 1/2)* 4 * n * binomial(n-1,t-1))

def proba_success(U,n,t):
	v = val(U,n,t)
	return (val_to_proba_success(v,n,t))

def val_to_bias(v,n,t):
	return (v/(2 * n * binomial(n-2,t-1)))

def bias_to_val(p,n,t):
	return (p * 2 * n * binomial(n-2,t-1))

def bias(U,n,t):
	v = val(U,n,t)
	return (val_to_bias(v,n,t))























