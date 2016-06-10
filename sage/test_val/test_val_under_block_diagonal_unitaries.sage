# Dans ce fichier, on teste la valeur theorique de la probabilite de succes pour une matrice diagonale par bloc dxd a laquelle on a applique la permutation i -> i+d

load("tools/trace_distance.sage")
load("test_val/printer.sage")
load("tools/binomial_tools.sage")


#####################################################################################################################
# On suppose que l'on a une unitaire Ud de taille d avec d | n et n >= 2d
# On construit U = Ps * U0 avec U0 diagonale par blocs avec les blocs egaux a Ud et s(i) = mod(i+d,n)
# On verifie alors que:
# proba_success(U) = 1/2 + 1/(8*binomial(n-1,t-1))*sum
# avec sum = Sum{y1,y2 \incl [|0,d-1|]} {trace_norm(rho_y1 - Ud * rho_y2 * Ud.H) * binomial(n-2*d,t - card(y1) - card(y2))
# et rho_y = compute_rhoy(y,d,1)

def compute_beta_block_under_diagonal_unitary(Ud,d):
	beta = [0 for _ in range(d+1)]
	for y1 in Subsets(range(d)):
		c1 = y1.cardinality()
		if (verbose):
			print y1
		rho_y1 = compute_rhoy(y1,d,1)
		for c2 in range(0,d-c1+1):
			for y2 in Subsets(range(d),c2):
				rho_y2 = compute_rhoy(y2,d,1)
				diff_state = rho_y1 - Ud * rho_y2 * Ud.H
				tn = trace_norm(diff_state)
				beta[c1 + c2] = beta[c1 + c2] + tn
	return [v/(4*d) for v in beta[1:d+1]]


def theoretical_val_block_under_diagonal_unitary(Ud,d,n_sur_d,t):
	n = d * n_sur_d
	beta = compute_beta_block_under_diagonal_unitary(Ud,d)
	alpha = beta_to_alpha_binomial(beta,2*d)
	v = alpha_to_sum_binomial(alpha,n,t)
	return (1/2 + v/binomial(n-1,t-1))


def test_val_block_under_diagonal_unitary(Ud,d,max_n_sur_d):
	for n_sur_d in range(2,max_n_sur_d+1):
		n = n_sur_d * d
		print "n:",n
		for t in range(1,n+1):
			v1 = theoretical_val_block_under_diagonal_unitary(Ud,d,n_sur_d,t)
			s = Permutation([ZZ(mod(i+d,n))+1 for i in range(n)])
			Ps = s.to_matrix()
			U = block_diagonal_matrix([Ud for _ in range(n/d)])
			v2 = proba_success(U * Ps,n,t)
			test_diff(v1,v2,10**10)



