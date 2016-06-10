#############################################################################
# Ce fichier implémente le lemme sur les coefficients binomiaux
# alpha et beta sont représentés sous forme de listes avec alpha[i] = alpha_(i+1) et beta[i] = beta_(i+1)
#############################################################################

# Cette fonction renvoie alpha à partir de beta.
# alpha et beta sont représentés sous forme de listes avec alpha[i] = alpha_(i+1) et beta[i] = beta_(i+1)
# l'entrée beta0 et la sortie sont de taille f
def beta_to_alpha_binomial(beta0,e):
	f = e//2
	A = matrix(f)
	beta = matrix(f,1,beta0)
	for i in range(f):
		for j in range(f):
			A[i,j] = binomial(e-2*(j+1), i-j)
	alpha = A.inverse() * beta
	return ([alpha[i,0] for i in range(f)])



# Cette fonction retourne \sum_{j=1}^{len(alpha)} \alpha_j\binom{n-2j}{t-j}
def alpha_to_sum_binomial(alpha,n,t):
	res = 0
	for j in range(0,len(alpha)):
		res = res + alpha[j]*binomial(n-2*(j+1),t-j-1)
	return res






