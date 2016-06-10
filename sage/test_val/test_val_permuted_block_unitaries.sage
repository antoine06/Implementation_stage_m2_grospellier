## On teste la formule pour une matrice diagonale par blocs a laquelle on a applique une permutation

load("tools/trace_distance.sage")
#load("tools/quantum_basis.sage")
load("generation/unitary_generation.sage")
load("test_val/printer.sage")

# sigma doit etre une permutation de taille (d * n_sur_d)
def compute_theoretical_value_permuted_block_unitary(Ud, d, n_sur_d, t, sigma):
	n = d * n_sur_d
	sigma_inv = sigma.inverse()
	res = 0
	for q in range(n_sur_d):
		Aq = Set([d*q + i for i in range(d)])
		Bq = Set([sigma_inv[d*q + i] - 1  for i in range(d)])
		Iq = Aq.intersection(Bq)
		card_Iq = Iq.cardinality()
		for y1 in Subsets(range(d)):
			z1 = Set([sigma_inv[d*q + i] - 1 for i in y1])
			card_z1 = z1.cardinality()
			gamma_y1 = compute_rhoy(y1,d,1)
			for y2 in Subsets(range(d)):
				z2 = Set([d*q + i for i in y2])
				card_z2 = z2.cardinality()
				gamma_y2 = compute_rhoy(y2,d,1)
				diff_state = gamma_y1 - Ud * gamma_y2 * Ud.H
				tn = trace_norm(diff_state)
				card_z1z2 = (z1.intersection(z2)).cardinality()
				if (z1.intersection(Iq) == z2.intersection(Iq)):
					res = res + tn * binomial(n-2*d+card_Iq,t-card_z1-card_z2+card_z1z2)
	res = 1/2 + 1/(4*n*binomial(n-1,t-1)) * res
	return res



def test_val_permuted_block_unitaries(d,n_sur_d,t,Ud, sigma):
	n = d * n_sur_d
	Id = matrix.identity(n_sur_d)
	U = sigma.to_matrix() * Id.tensor_product(Ud)
	v1 = proba_success(U,n,t)
	v2 = compute_theoretical_value_permuted_block_unitary(Ud, d, n_sur_d, t, sigma)
	test_diff(v1,v2,10**2,skip)


def test_val_permuted_block_unitaries_random(d,n_sur_d,t,nombre_tests):
	n = d * n_sur_d
	for _ in range(nb_tests):
		sigma = Permutations(n).random_element()
		Ud = generation_unitaries_real_float(d)
		test_val_permuted_block_unitaries(d,n_sur_d,t,Ud, sigma)




#### On le teste pour des matrices de hadamard

def test_val_exact_permuted_block_unitaries(d,n_sur_d,t,Ud, sigma):
	n = d * n_sur_d
	Id = matrix.identity(n_sur_d)
	U = sigma.to_matrix() * Id.tensor_product(Ud)
	v1 = proba_success(U,n,t)
	v2 = compute_theoretical_value_permuted_block_unitary(Ud, d, n_sur_d, t, sigma)
	test_diff_exact(v1,v2,skip)


def test_val_permuted_block_unitaries_hadamard(logd,n_sur_d,t,nombre_tests):
	d = 2**logd
	Ud = compute_Hadamard_transformation(logd)
	n = d * n_sur_d
	for _ in range(nb_tests):
		sigma = Permutations(n).random_element()
		test_val_exact_permuted_block_unitaries(d,n_sur_d,t,Ud, sigma)

















