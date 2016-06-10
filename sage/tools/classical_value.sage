# Cette fonction renvoie la probabilité de succès optimale lorsque Alice et Bob ont des stratégies quantiques pour le subset channel
def classical_value(k,n,t):
	res = ZZ(n) / ZZ(k*t) * (1-binomial(n-k,t)/binomial(n,t))
	return res


