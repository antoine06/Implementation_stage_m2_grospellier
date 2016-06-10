load("sdp/sdp_ncc_cvxpy.sage")
load("sdp/tools_ncc.sage")











#####################################
# On peut changer k0, n0 et t0
####################################
k0 = 2
n0 = 4
t0 = 2



#####################################
# Ne pas changer
####################################

m0 = binomial(n0,t0)
order0 = 1
W0 = create_W_subset_channel(n0,t0)


#####################################
solve_sdp_ncc_cvxpy(k0,n0,m0,W0,order0)



























