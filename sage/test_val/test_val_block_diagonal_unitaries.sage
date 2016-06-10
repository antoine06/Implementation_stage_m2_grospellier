### Dans ce fichier, on teste les formules qui donnent les probabilites de succes des matrices diagonales par bloc

load("tools/trace_distance.sage")
load("tools/binomial_tools.sage")
#load("tools/quantum_basis.sage")
load("generation/unitary_generation.sage")
load("test_val/printer.sage")


#####################################################################################################################
# We suppose that we have a unitary matrix Ud of size d where d | n
# We construct a unitary matrix U where U is diagonal by block with blocks equal to Ud

def compute_beta_block_diagonal_unitary(Ud,d):
	beta = [0 for _ in range(floor(d/2)+1)]
	for c in range(floor(d/2)+1):
		for y in Subsets(range(d),c):
			if (verbose):
				print y
			rho_y = compute_rhoy(y,d,1)
			diff_state = rho_y - Ud * rho_y * Ud.H
			tn = trace_norm(diff_state)
			beta[c] = beta[y.cardinality()] + tn
	return [v/(4*d) for v in beta[1:]]



def theoretical_val_block_diagonal_unitary(Ud,d,n_sur_d,t):
	n = d * n_sur_d
	beta = compute_beta_block_diagonal_unitary(Ud,d)
	alpha = beta_to_alpha_binomial(beta,d)
	v = alpha_to_sum_binomial(alpha,n,t)
	return (1/2 + v/binomial(n-1,t-1))


def test_val_block_diagonal_unitary(Ud,d,max_n_sur_d):
	for n_sur_d in range(1,max_n_sur_d+1):
		n = n_sur_d * d
		print "n:",n
		for t in range(1,n+1):
			v1 = theoretical_val_block_diagonal_unitary(Ud,d,n_sur_d,t)
			U = block_diagonal_matrix([Ud for _ in range(n/d)])
			v2 = proba_success(U,n,t)
			test_diff(v1,v2,10**10)





