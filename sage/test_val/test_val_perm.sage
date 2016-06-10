# On verifie que pour une matrice de permutation Ps, val(Ps) = 1/2 + (n-t)/(2n(n-1))*(n-pf) ou pf est le nombre de points fixes de s.


load("test_val/printer.sage")
load("tools/classical_value.sage")



def val_formula(fp,n,t):
	res = 1/2 + (n-t)/(2*n*(n-1))*(n - fp)
	return res



# On verifie que pour toutes les permutations, la formule est vraie
def test_val_perm(n,t):
	P = Permutations(n)
	coeff = 10**5
	for s in P:
		print s,
		Ps = s.to_matrix()
		v1 = proba_success(Ps,n,t)
		v2 = val_formula(s.number_of_fixed_points(),n,t)
		test_diff(v1,v2,coeff)











