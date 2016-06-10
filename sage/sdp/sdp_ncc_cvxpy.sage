load("sdp/words_qbo.sage")
load("tools/word_to_int.sage")
load("sdp/tools_ncc.sage")

import cvxpy as cvx


##############################################################################################################
# We directly create the sdp corresponding to the noisy channel coding

# This funtion returns the objective function (see the objective function of (54) of QBO)
def create_objective_sdp_ncc_cvxpy(k,n,m,W,omega):
	N = compute_N_ncc(k,n)
	M = compute_M_ncc(k,m)
	res = int(0)
	for i in range(k):
		for x in range(n):
			for y in range(m):
				word_alpha = (('z',pair_to_int((x,i),n)),)
				i_alpha = word_to_int_qbo(word_alpha,N,M)
				word_beta = (('y',pair_to_int((i,y),k)),)
				i_beta = word_to_int_qbo(word_beta,N,M)
				res = res + omega[i_alpha,i_beta] * float(W[y,x])
	res = res / int(k)
	return res


# This function add to sdp the constraints of equality:
# forall w,r,s:
# forall i : sum_x{omega[r + (x,i) + s][w]} == omega[r+s][w]
# forall y : sum_i{omega[r + (i,y) + s][w]} == omega[r+s][w]
# w is in it_w() and (r,s) in it_rs()
def add_constraints_eq_ncc_cvxpy(constraints,k,n,m,omega,it_w,it_rs):
	N = compute_N_ncc(k,n)
	M = compute_M_ncc(k,m)
	for w in it_w():
		if verbose:
			print w
		j_omega1 = word_to_int_qbo(w,N,M)
		for (r,s) in it_rs():
			i_omega1 = word_to_int_qbo(r + s,N,M)
			for y in range(m):
				const = int(0)
				for i in range(k):
					word_iy = (('y',pair_to_int((i,y),k)),)
					i_omega2 = word_to_int_qbo(r + word_iy + s,N,M)
					j_omega2 = j_omega1
					const = const + omega[i_omega2,j_omega2]
				constraints.append(const == omega[i_omega1,j_omega1])
			for i in range(k):
				const = int(0)
				for x in range(n):
					word_xi = (('z',pair_to_int((x,i),n)),)
					i_omega2 = word_to_int_qbo(r + word_xi + s,N,M)
					j_omega2 = j_omega1
					const = const + omega[i_omega2,j_omega2]
				constraints.append(const == omega[i_omega1,j_omega1])



# This function add to sdp the constraints >=:
# forall alpha,beta in [|0;N+M+1|]:
# 0 <= sum_rsuv{omega[r + alpha + s][u + beta + v] * |r><s| tensor_product |u><v|}
# (((0 <= sum_rsuv{(omega[r + s][u + beta + v] - omega[r + alpha + s][u + beta + v]) * |r><s| tensor_product |u><v|}))) (peut-etre inutile ???)
# alpha, beta, (r,s) and (u,v) are in it_alpha, it_beta, it_rs and it_uv.
# rsuv_to_Eij(r,s,u,v) gives |r><s| tensor_product |u><v|
def add_constraints_geq_ncc_cvxpy(constraints,N,M,omega,it_alpha,it_beta,it_rs,it_uv,rsuv_to_ijLM,size_LM):
	for alpha in it_alpha():
		if verbose:
			print alpha
		for beta in it_beta():
			LM = cvx.Semidef(int(size_LM))
			for (r,s) in it_rs():
					i_omega = word_to_int_qbo(star_word(r) + alpha + s,N,M)
					for (u,v) in it_uv():
							j_omega = word_to_int_qbo(star_word(u) + beta + v,N,M)
							constraints.append(omega[i_omega,j_omega] == LM[rsuv_to_ijLM(r,s,u,v)])


# This function returns (it_rs,it_uv,rsuv_to_ijLM,size_LM) for the function add_constraints_geq_ncc_cvxpy if we generate words of size less than max_size_uv and max_size_rs
def max_size_rsuv_to_it_cvxpy(N,M,max_size_uv, max_size_rs):
	it_rs = lambda : it_pair_words_qbo(N,M,max_size_rs)
	it_uv = lambda : it_pair_words_qbo(N,M,max_size_uv)
	nb_words_rs = compute_nb_words(N+M,max_size_rs)
	nb_words_uv = compute_nb_words(N+M,max_size_uv)
	size_LM = nb_words_rs*nb_words_uv
	def rsuv_to_ijLM(r,s,u,v):
		i_LM =  word_to_int_qbo(u,N,M) + nb_words_uv * word_to_int_qbo(r,N,M)
		j_LM =  word_to_int_qbo(v,N,M) + nb_words_uv * word_to_int_qbo(s,N,M)
		return((i_LM,j_LM))
	return (it_rs,it_uv,rsuv_to_ijLM,size_LM)




# We create the sdp (54) of QBO
def create_sdp_ncc_cvxpy(k,n,m,W,order) :
	N = compute_N_ncc(k,n)
	M = compute_M_ncc(k,m)
	omega = cvx.Semidef(int(compute_nb_words(N+M,order)))
	constraints = []
	if verbose:
		print "obj0"
	objective0 = int(0)
	objective0 = create_objective_sdp_ncc_cvxpy(k,n,m,W,omega)
	i_epsilon = word_to_int_qbo((),N,M)
	if verbose:
		print "vide,vide"
	constraints.append(omega[i_epsilon,i_epsilon] == int(1))
	if (mod(order,2) == 1):
		it_w = lambda : it_words_qbo(N,M,order)
		max_size_rsuv = (order-1)/2
		(it_rs,it_uv,rsuv_to_ijLM,size_LM) = max_size_rsuv_to_it_cvxpy(N,M,max_size_rsuv,max_size_rsuv)
		it_alpha = lambda : it_words_qbo(N,M,1)
#		for u in it_words_qbo(N,M,order):
#			for v in it_words_qbo(N,M,order):
#				i_u = word_to_int_qbo(u,N,M)
#				i_v = word_to_int_qbo(v,N,M)
#				constraints.append(omega[i_u,i_v] == omega[i_u,0] * omega[i_v,0])
		add_constraints_eq_ncc_cvxpy(constraints,k,n,m,omega,it_w,it_rs)		
		add_constraints_geq_ncc_cvxpy(constraints,N,M,omega,it_alpha,it_alpha,it_rs,it_uv,rsuv_to_ijLM,size_LM)
	else:
		it_w = lambda : it_words_qbo(N,M,order)
		(it_rs,it_uv,rsuv_to_ijLM,size_LM) = max_size_rsuv_to_it_cvxpy(N,M,(order-2)/2,(order-2)/2)
		if verbose:
			print "const_eq"
		add_constraints_eq_ncc_cvxpy(constraints,k,n,m,omega,it_w,it_rs)
		it_alpha = lambda : it_words_fixed_size_qbo(N,M,1)
		def it_epsilon ():
			yield ()

		(it_rs,it_uv,rsuv_to_ijLM,size_LM) = max_size_rsuv_to_it_cvxpy(N,M,order/2,order/2)
		if verbose:
			print "const_geq"
		add_constraints_geq_ncc_cvxpy(constraints,N,M,omega,it_epsilon,it_epsilon,it_rs,it_uv,rsuv_to_ijLM,size_LM)

		(it_rs,it_uv,rsuv_to_ijLM,size_LM) = max_size_rsuv_to_it_cvxpy(N,M,(order)/2,(order-2)/2)
		if verbose:
			print "const_geq"
		add_constraints_geq_ncc_cvxpy(constraints,N,M,omega,it_alpha,it_epsilon,it_rs,it_uv,rsuv_to_ijLM,size_LM)

		(it_rs,it_uv,rsuv_to_ijLM,size_LM) = max_size_rsuv_to_it_cvxpy(N,M,(order-2)/2,(order-2)/2)
		if verbose:
			print "const_geq"
		add_constraints_geq_ncc_cvxpy(constraints,N,M,omega,it_alpha,it_alpha,it_rs,it_uv,rsuv_to_ijLM,size_LM)
	return cvx.Problem(cvx.Maximize(objective0), constraints)



def solve_sdp_ncc_cvxpy(k,n,m,W,order):
	sdp = create_sdp_ncc_cvxpy(k,n,m,W,order)
	if verbose:
		print "begining solve:\a"
	val = sdp.solve(solver=cvx.CVXOPT,verbose = True)
#	val = sdp.solve(solver=cvx.MOSEK,verbose = verbose)
#	val = sdp.solve(solver=cvx.SCS,verbose = True)
	if verbose:
		print val
		print "\a"
	if verbose:
		print "Partie 1"
	return val











