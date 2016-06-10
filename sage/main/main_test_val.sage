load("test_val/printer.sage")
print "Lorsque deux valeurs ne correspondent pas, on affiche quelque chose comme:"
test_diff_exact(0,sqrt(2))

# On utilise les fichiers du repertoire test_val


verbose = 0


#################################################################################################################
### On teste les formules qui donnent les probabilites de succes des matrices diagonales par bloc
load("test_val/test_val_block_diagonal_unitaries.sage")


d = 3
nb_tests = 0
max_n_sur_d = 3
for test in range(nb_tests):
	print "\nTest numero", test
	Ud = generation_unitaries_real_float(d)
	test_val_block_diagonal_unitary(Ud,d,max_n_sur_d)


#################################################################################################################
### On teste si pour une matrice de permutation Ps, val(Ps) = 1/2 + (n-t)/(2n(n-1))*(n-pf) ou pf est le nombre de points fixes de s
load("test_val/test_val_perm.sage")
# On le fait pour toutes les permutations (n = 0 permet de ne pas faire dfe test):
n = 0; t = 2
if (n != 0):
	test_val_perm(n,t)



#################################################################################################################
load("test_val/test_val_permuted_block_unitaries.sage")

## On teste la formule pour une matrice diagonale par blocs a laquelle on a applique une permutation
d = 4; n_sur_d = 2; t = 4; nb_tests = 0; test_val_permuted_block_unitaries_random(d,n_sur_d,t,nb_tests)

## On le teste pour des matrices de hadamard

logd = 2; n_sur_d = 2; t = 3; nb_tests = 0; test_val_permuted_block_unitaries_hadamard(logd,n_sur_d,t,nb_tests)


#################################################################################################################
# On teste la valeur theorique de la probabilite de succes pour une matrice diagonale par bloc dxd a laquelle on a applique la permutation i -> i+d
load("test_val/test_val_under_block_diagonal_unitaries.sage")
load("generation/zomoon_generation.sage")
load("generation/unitary_generation.sage")

d = 3
nb_tests = 0
max_n_sur_d = 3
for test in range(nb_tests):
	print "\nTest numero", test
	Ud = generation_unitaries_real_float(d)
	test_val_block_under_diagonal_unitary(Ud,d,max_n_sur_d)




#################################################################################################################
## On teste la valeur theorique des matrices avec 2 entrees non nulles par colonnes
load("test_val/test_val_zomoon.sage")

for nsur2 in range(3,3):
	n = 2*nsur2
	for t in range(1,n+1):
		test_val_zommon_2_0(n,t)
















