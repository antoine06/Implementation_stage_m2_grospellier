## Dans ce fichier on teste comment la probabilite depend de n et t pour une matrice U fixee

load("tools/trace_distance.sage")
load("generation/unitary_generation.sage")
load("tools/classical_value.sage")

#### On calcule val de U pour tout t
# Il semble que val(U,n,n-t) = val(U,n,t) et val est croissant pour t dans [|1,n//2|] et decroissant pour t dans [|(n+1)//2,n|]

def test_dependency_val_t(U,n):
	v = range(n-1)
	for t in range(1,n):
		v[t-1] = val(U,n,t)

	increase = true
	for t in range(1,n//2):
		increase = increase and (v[t-1] <= v[t])

	decrease = true
	for t in range((n+1)//2,n-1):
		decrease = decrease and (v[t-1] >= v[t])

	symetric = true
	coeff = 10**5
	for t in range(1,n//2):
		symetric = symetric and (floor(coeff * v[t-1]) == floor(coeff * v[n-t-1]))

	print "increase val t = ", increase,"decrease val t = ", decrease,"symetric val t = ", symetric
#	print v
#	print [v[i+1] / v[i] for i in range(n-2)]






def test_dependency_val_t_random(n,nb_tests):
	for _ in range(nb_tests):
		U = generation_unitaries_real_float(n)
		test_dependency_val_t(U,n)





### On verifie si val(t1,U1) et val(t1,U2) sont dans le meme ordre que val(t2,U1) et val(t2,U2)
## Resultat : Ca semble faux...

def test_order_t_random(n,nb_matrices,fct):
	matrices = {}
	zero_tuple = tuple([0 for t in range(1,n)])
	values = [(zero_tuple,i) for i in range(nb_matrices)]
	for i in range(nb_matrices):
		matrices[i] = generation_unitaries_real_float(n)
		values[i] = (tuple([fct(matrices[i],n,t) for t in range(1,n)]),i)
	values.sort()
	for i in range(nb_matrices - 1):
		print values[i][0]
	ordered = True
	for i in range(nb_matrices - 1):
		for t in range(1,n):	
			ordered = ordered and (values[i][0][t-1] <= values[i+1][0][t-1])
	return ordered

def test_order_val_t_random(n , nb_matrices):
	if (nb_matrices != 0):
		ordered_val = test_order_t_random(n,nb_matrices,val)
		print "ordered_val = ", ordered_val





### On verifie que pour une matrice donnee, la probabilite de gagner diminue lorsque t augmente
def test_dependency_t(U,n):
	v = range(1,n+1)
	for t in range(n):
		v[t] = proba_success(U,n,t+1)
	decrease = true
	for i in range(n-1):
		decrease = decrease and (v[i] >= v[i+1])
	print "decrease t = ", decrease




def test_dependency_t_random(n,nb_tests):
	for _ in range(nb_tests):
		U = generation_unitaries_real_float(n)
		test_dependency_t(U,n)



# On verifie que pour une matrice donnee U, val(U) <= val(U1) ou U1 est de taille (n+1) avec U en haut a gauche et un 1 en bas a droite
### Resultat: ca a l'air tout le temps faux
def test_dependency_n(U,n,t):
	v1 = proba_success(U,n,t)
	U1 = matrix(RDF,n+1)
	U1[n,n] = 1
	for i in range(n):
		for j in range(n):
			U1[i,j] = U[i,j]
	v2 = proba_success(U1,n+1,t)
	print "increase n = ", (v1 <= v2)


def test_dependency_n_random(n,t,nb_tests):
	for _ in range(nb_tests):
		U = generation_unitaries_real_float(n)
		test_dependency_n(U,n,t)






#### On calcul le biais de U pour tout t
# Il semble que biais(U,n-t) = biais(U,t) et biais est croissant pour t dans [|1,n//2|] et decroissant pour t dans [|(n+1)//2,n|]

def test_dependency_bias_t(U,n):
	v = range(n-1)
	for t in range(1,n):
		v[t-1] = (proba_success(U,n,t) - 1/2)/(classical_value(2,n,t) - 1/2)

	increase = true
	for t in range(1,n//2):
		increase = increase and (v[t-1] <= v[t])

	decrease = true
	for t in range((n+1)//2,n-1):
		decrease = decrease and (v[t-1] >= v[t])

	symetric = true
	coeff = 10**5
	for t in range(1,n//2):
		symetric = symetric and (floor(coeff * v[t-1]) == floor(coeff * v[n-t-1]))

	print "increase bias t = ", increase,"decrease bias t = ", decrease,"symetric bias t = ", symetric
#		print v






def test_dependency_bias_t_random(n,nb_tests):
	for _ in range(nb_tests):
		U = generation_unitaries_real_float(n)
		test_dependency_bias_t(U,n)





def test_order_bias_t_random(n , nb_matrices):
	if (nb_matrices != 0):
		ordered_bias = test_order_t_random(n,nb_matrices,bias)
		print "ordered_bias = ", ordered_bias



