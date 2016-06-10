# On utilise les fichiers du repertoire test_val.
# On va calculer le vecteur alpha pour des matrice particulieres


verbose = 0


#################################################################################################################
#### Pour des matrices diagonales par bloc
load("test_val/test_val_block_diagonal_unitaries.sage")


d = 4
Ud = 1/sqrt(3) * matrix(SR,4,[0,-1,1,1,-1,0,1,-1,-1,1,0,1,-1,-1,-1,0])
beta = compute_beta_block_diagonal_unitary(Ud,d)
alpha = beta_to_alpha_binomial(beta,d)
for v in alpha:
	print RR(v), " = ", v
print ""
# Dans ce fichier on calcule certaines valeurs theoriques pour des matrices diagonales par bloc auquelles on a applique une permutation
#################################################################################################################################################
d = 6
Ud = 1/sqrt(5) * matrix(6,6,[ 0, 1, 1, 1,-1, 1,-1,0,-1,-1,-1, 1, 1, 1, 0,-1,-1,-1,-1,-1, 1,0,-1,-1,-1, 1,-1, 1, 0,-1, 1,-1,-1, 1,-1,0])
beta = compute_beta_block_diagonal_unitary(Ud,d)
alpha = beta_to_alpha_binomial(beta,d)
for v in alpha:
	print RR(v), " = ", v
print ""

##########
print "\n\n\n"
d = 8
Ud = 1/sqrt(7) * matrix(SR,8,[0,-1,-1,1,-1,-1,1,1,-1,0,1,1,-1,1,-1,1,1,1,0,1,1,1,1,1,-1,1,-1,0,1,-1,-1,1,1,-1,-1,-1,0,1,-1,1,-1,-1,1,-1,1,0,1,1,-1,-1,-1,1,1,1,0,-1,1,-1,1,1,1,-1,-1,0])
beta = compute_beta_block_diagonal_unitary(Ud,d)
alpha = beta_to_alpha_binomial(beta,d)
for v in alpha:
	print RR(v), " = ", v
print ""

##########
## Trop long pour aboutir:
print "\n\n\n"
d = 12
Ud = 1/sqrt(11) * matrix(SR,12,[0,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1, 0,1,1,1,1,1,-1,-1,-1,-1,-1,-1,-1, 0,1,1,-1,-1,1,1,1,-1,-1,-1,-1,-1, 0,1,1,-1,1,-1,-1,1,1,-1,-1,-1,-1, 0,1,1,-1,1,1,1,-1,-1,-1,1,-1,-1, 0,1,1,1,-1,-1,1,-1,-1,1,1,-1,-1, 0,-1,-1,1,1,1,-1,1,-1,-1,1,-1,1, 0,-1,1,-1,1,-1,1,-1,1,-1,-1,1,1, 0,-1,1,-1,-1,1,-1,1,-1,1,-1,-1,1, 0,-1,1,-1,1,1,-1,-1,1,-1,1,-1,1, 0,-1,-1,1,1,-1,1,-1,-1,-1,1,-1,1, 0])
#beta = compute_beta_block_diagonal_unitary(Ud,d)
#alpha = beta_to_alpha_binomial(beta,d)
#for v in alpha:
#	print RR(v), " = ", v
#print ""

#################################################################################################################################################
# Lorsque la permutation est i -> i + d
load("test_val/test_val_under_block_diagonal_unitaries.sage")


logd = 0
Ud0 = compute_Hadamard_transformation(logd); d0 = 2**logd; beta = compute_beta_block_under_diagonal_unitary(Ud0,d0); alpha = beta_to_alpha_binomial(beta,2*d0)
print (alpha),"\n"




alpha_res = [1/2]
for v in alpha_res:
	print RR(v), " = ", v
print ""
##########
logd = 1
Ud0 = compute_Hadamard_transformation(logd); d0 = 2**logd; beta = compute_beta_block_under_diagonal_unitary(Ud0,d0); alpha = beta_to_alpha_binomial(beta,2*d0)
print (alpha),"\n"




#a = n-2; b = t-1; c = 2; zero = binomial(a,b) - compute_binomial_expand(a,b,c); v1 = v1 + zero
#v1 = v1.canonicalize_radical()
#v2 = v1/(2 * binomial(n-1,t-1)) + 1/2
#print v2,"\n"



alpha_res = [
1/2,
1/2*sqrt(2) - 1/2
]
for v in alpha_res:
	print RDF(v), " = ", v
print ""
##########
logd = 2
Ud0 = compute_Hadamard_transformation(logd); d0 = 2**logd; beta = compute_beta_block_under_diagonal_unitary(Ud0,d0); alpha = beta_to_alpha_binomial(beta,2*d0)
print (alpha),"\n"




alpha_res = [1/2, sqrt(3) - 3/2, -4*sqrt(3) + 3*sqrt(2) + 3, 2*sqrt(3) - 3*sqrt(2) + 1]
for v in alpha_res:
	print RDF(v), " = ", v
print ""
##########
#logd = 3
#Ud0 = compute_Hadamard_transformation(logd); d0 = 2**logd; beta = compute_beta_block_under_diagonal_unitary(Ud0,d0); alpha = beta_to_alpha_binomial(beta,2*d0)
#print (alpha),"\n"


alpha_res = [
1/2,
sqrt(7)*sqrt(2) - 7/2,
-12*sqrt(7)*sqrt(2) + 14*sqrt(3) + 21,
54*sqrt(7)*sqrt(2) + 14*sqrt(5)*sqrt(2) - 112*sqrt(3) + 21/2*sqrt(2) - 133/2,
-112*sqrt(7)*sqrt(2) - 112*sqrt(5)*sqrt(2) + 350*sqrt(3) + 35*sqrt(2) + 119,
133*sqrt(7)*sqrt(2) + 280*sqrt(5)*sqrt(2) + 14*sqrt(3)*sqrt(2) - 588*sqrt(3) - 266*sqrt(2) + 21*sqrt(sqrt(17) + 7) + 21*sqrt(abs(-sqrt(17) + 7)) - 126,
-148*sqrt(7)*sqrt(2) - 224*sqrt(5)*sqrt(2) - 56*sqrt(3)*sqrt(2) + 448*sqrt(3) + 392*sqrt(2) - 84*sqrt(sqrt(17) + 7) + 168*sqrt(sqrt(2) + 2) - 84*sqrt(abs(-sqrt(17) + 7)) + 168*sqrt(abs(-sqrt(2) + 2)) + 56,
58*sqrt(7)*sqrt(2) + 28*sqrt(5)*sqrt(2) + 28*sqrt(3)*sqrt(2) - 56*sqrt(3) - 82*sqrt(2) + 42*sqrt(sqrt(17) + 9) + 42*sqrt(sqrt(17) + 7) + 56*sqrt(sqrt(3) + 2) - 252*sqrt(sqrt(2) + 2) + 42*sqrt(abs(-sqrt(17) + 9)) + 42*sqrt(abs(-sqrt(17) + 7)) + 56*sqrt(abs(-sqrt(3) + 2)) - 252*sqrt(abs(-sqrt(2) + 2)) - 92]
for v in alpha_res:
	print RDF(v), " = ", v
print ""
























