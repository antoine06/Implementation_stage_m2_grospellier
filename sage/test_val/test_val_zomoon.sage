## On teste la valeur theorique des matrices avec 2 entrees non nulles par colonnes
load("tools/trace_distance.sage")
load("tools/default_value_global.sage")
load("generation/zomoon_generation.sage")
load("test_val/printer.sage")
#load("generation/zdomoon_generation.sage")






###################################################################################################
# We have val(Ps * U0) = 1/2 + 1/(4*n0*binomial(n0-1,t0-1)) * [binomial(n0-2,t0-1)*(2*n0 -(2-sqrt(2))*(S+D)) + binomial(n0-4,t0-2)*((sqrt(2)-1)*2*(n0-2*S))] where:
# S = card { k | 2k \in {s(2k),s(2k+1)} or (2k+1) \in {s(2k),s(2k+1)} } (= sfp - dsfp/2)
# D = card{ k | {2k,2k+1} == {s(2k),s(2k+1)} }



def val_formula_zomoon_2_0(S,D,n0,t0):
#	k0 = n0/t0
#	if (k0 < 2):
#		print "il faut k > 1"
#		return default_value_global
	if (mod(n0,2) != 0):
		print "il faut mod(n,2) == 0"
		return default_value_global
	res = 1/2 + 1/(4*n0*binomial(n0-1,t0-1)) * (binomial(n0-2,t0-1)*(2*n0 -(2-sqrt(2))*(S+D)) + binomial(n0-4,t0-2)*((sqrt(2)-1)*2*(n0-2*S)))
	return res

def compute_S(s):
	res = 0
	for i in range(s.size()/2):
		if (i == floor((s[2*i]-1)/2) or i == floor((s[2*i+1]-1)/2)):
			res = res + 1
	return res


def compute_D(s):
	res = 0
	for i in range(s.size()/2):
		if (i == floor((s[2*i]-1)/2) and i == floor((s[2*i+1]-1)/2)):
			res = res + 1
	return res



def test_val_zommon_2_0(n,t):
	print "\ndebut test_val_zommon_2_0(", n,t
	if (mod(n,2) != 0):
		print " mod(n,2) != 0"
		abort
	P = Permutations(n)
	coeff = 10**3
#	U0 = 1/sqrt(2.) * create_first_zomoog_2_0(n)
	U0 = 1/sqrt(2) * create_first_zomoog_2_0(n)
	for s in P:
		print s[0],
		Ps = s.to_matrix()
		U = Ps * U0
		v1 = proba_success(U,n,t)
		S = compute_S(s)
		D = compute_D(s)
		v2 = val_formula_zomoon_2_0(S,D,n,t)
		test_diff_exact(v1,v2,skip)


# Computes the maximal value when we use zomoon_2_0
def max_value_zomoon_2_0(n,t):
	res = val_formula_zomoon_2_0(0,0,n,t)
	return res





