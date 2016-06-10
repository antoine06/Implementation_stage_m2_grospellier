







# This function returns the subset channel as a matrix(m,n)
def create_W_subset_channel(n,t):
	m = binomial(n,t)
	W = matrix(RDF,m,n)
	j = -1
	for y in Subsets(range(n),t):
		j = j+1
		for x in y:
			W[j,x] = float(1/binomial(n-1,t-1))
	return W








def compute_N_ncc(k,n):
	return (k*n)

def compute_M_ncc(k,m):
	return (k*m)

# We give a number to each (i,j) for i \in [|0,i_max-1|]
def pair_to_int(pair,i_max):
	(i,j) = pair
	return(j * i_max + i)

def int_to_pair(a,i_max):
	i = ZZ(mod(a,i_max))
	j = (a - i) / i_max
	return (i,j)

#i_max0 = 5
#for a in range(40):
#	pair = int_to_pair(a,i_max0)
#	b = pair_to_int(pair,i_max0)
#	print a, pair,
#	print b
#	print (a == b)
#

























