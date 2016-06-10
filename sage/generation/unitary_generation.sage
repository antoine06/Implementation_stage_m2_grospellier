load("tools/trace_distance.sage")

from sage.matrix.constructor import random_unimodular_matrix

# Fonction qui renvoie une matrice unitaire aleatoire de taille dim*dim dans SR
def generation_unitary(dim):
	matrix_space = sage.matrix.matrix_space.MatrixSpace(ZZ, dim)
	A=random_unimodular_matrix(matrix_space);
	G, M = A.gram_schmidt()
	g=G*G.transpose()
	gsqrt=g.apply_map(sqrt)
	q=gsqrt.inverse()
	Gr=q*G
	return Gr



# Fonction qui renvoie une matrice unitaire aleatoire de taille dim*dim dans CDF
def generation_unitaries_float(dim):
	X = random_matrix(CDF,dim);
	Q,R = X.QR();
	diag = [sgn(R[i,i]) for i in range(dim)]
	R = diagonal_matrix(diag);
	U = Q*R;
	return U



# Fonction qui renvoie une matrice unitaire aleatoire de taille dim*dim dans RDF
def generation_unitaries_real_float(dim):
	X0 = random_matrix(RR,dim);
	X = matrix(CDF,X0);
	Q,R = X.QR();
	diag = [sgn(R[i,i]) for i in range(dim)]
	R = diagonal_matrix(diag);
	U = Q*R;
	return U










