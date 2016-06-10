# Les fonctions de ce fichier sont utilisees lorsque l'on compare deux valeurs elles le marque quand les deux valeurs sont differentes.

def skip():
	return None

def test_diff(v1,v2,coeff,fct = skip):
	print "test_diff",
	if (round(v1*coeff) != round(v2*coeff)):
		print ""
		fct()
		diff = v1 - v2
		print diff, " = ", float(diff)
		print "  ",v1," = ", float(v1), " ---------------------- ", v2," = ", float(v2)


def test_diff_exact(v1,v2,fct = skip):
	print "test_diff_exact",
	if (v1 != v2):
		print ""
		fct()
		diff = v1 - v2
		print diff, " = ", float(diff)
		print "  ",v1," = ", float(v1), " ---------------------- ", v2," = ", float(v2)



def test_equality(v1,v2,fct = skip):
	print "test_equality",
	if (v1 != v2):
		print ""
		print "test_equality:"
		fct()
		print v1 ,"\n"
		print v2, "\n"








































