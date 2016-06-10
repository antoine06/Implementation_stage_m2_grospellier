# Ces fonctions utilisent les fichiers du repertoire generation.
# Le but est d'essayer d'avoir une idee de la forme des matrices qui optimisent la probabilite de succes pour le subset channel.
# La fonction optimisation prend en entree un generateur de matrices unitaires et conserve la matrice avec la plus grand probabilite de succes.
# Le resultat est ecrit dans le terminal et dans le fichier "file_to_write".
load("tools/trace_distance.sage")
load("generation/omoon_generation.sage")
load("generation/unitary_generation.sage")
load("generation/zdomoon_generation.sage")
load("generation/zomoon_generation.sage")


verbose = 0

# L'entree f est telle que f() renvoie un objet dans un ensemble (par exemple f() renvoie une matrice unitaire). Alors generator_to_it(f) est un iterateur d'objet dans cet ensemble (par exemple generator_to_it(f) est un iterateur de matrices unitaires)
def generator_to_it(f):
	while true:
		yield f()





from sage.misc.temporary_file import atomic_write




# Fichier dans lequel ecrire le resultat
file_to_write = 'res_sage.txt'

# Pour ecrire le resultat dans le terminal
def write_to_screen(res,U0,test):
	print "t = ",t_global
	print "k = ",k_global
	print "n = ",n_global
	print res
	print float(res)
	print U0

# Pour ecrire le resultat dans le terminal et dans le fichier
# Cette fonction est appelee a chaque fois qu'une matrice de probabilite de succes superieure a toutes les autres est trouvee
def write_to_file(res,U0,test):
	write_to_screen(res,U0,test)
	with atomic_write(file_to_write, append=True) as f:
		f.write("nombre de test : ")
		f.write(str(test))
		f.write("\n")
		f.write('t = ')
		f.write(str(t_global))
		f.write('\n')
		f.write('k = ')
		f.write(str(k_global))
		f.write('\n')
		f.write('n = ')
		f.write(str(n_global))
		f.write('\n')
		f.write(str((res)))
		f.write('\n')
		f.write(str(float(res)))
		f.write('\n')
		f.write(str(U0))
		f.write('\n\n\n\n')

# Pour ecrire le resultat final dans le fichier et le terminal
def write_to_file_res(res,U0,test):
	print "res_final :"
	with atomic_write(file_to_write, append=True) as f:
		f.write("res_final :\n")
	write_to_file(res,U0,test)

# Pour tester si une matrice est unitaire
def test_unitaries(U,dim):
	if (U*U.H != matrix.identity(dim)):
		print "dans optimization, une matrice n'est pas unitaire"



# Fonction qui applique plusieurs fois U = generation_naive_unitaire(dim) et renvoit la matrice U qui maximise val(U)
# it est un iterateur de matrices unitaires de taille dim*dim
def optimization(nb_tests_max,it):
	U0 = it.next()
	res = proba_success(U0,n_global,t_global)
	write_to_file(res,U0,0)
	test = 0
	for U in it:
		if (mod(test,200000)==0):
			write_to_screen(res,U0,test)
		print test,
		test = test + 1
		v = proba_success(U,n_global,t_global)
		if (float(v) > float(res)):
			res = v
			U0 = U
			write_to_file(res,U0,test)
		if (test > nb_tests_max):
			print "nb_tests_max atteint"
			with atomic_write(file_to_write, append=True) as f:
				f.write("nb_tests_max_atteint\n")
			break
	write_to_file_res(res,U0,test)
	return U0



#################################################################################################################################
#						Variables									#
#################################################################################################################################


t_global = 2 			# parametre du subset channel
n_global = 4		 	# = cardinal de X, nombre d'entrees du subset channel


#########################################
#		Don't touch		#
#########################################

k_global = 2			# nombre de message que l'on veut envoyer
m_global = binomial(n_global,t_global) 	# = cardinal de Y, nombre de sorties du subset channel
ent_dim_global = n_global		# La taille de l'etat quantique


#################################################################################################################################
# Les generateurs des fichiers du repertoire generation:
it_unitaries = generator_to_it(lambda : generation_unitary(ent_dim_global))
it_unitaries_float = generator_to_it(lambda : generation_unitaries_float(ent_dim_global))
it_unitaries_real_float = generator_to_it(lambda : generation_unitaries_real_float(ent_dim_global))
it_zdomoon = it_zdomoog_to_it_zdomoon(generate_zdomoog(ent_dim_global),ent_dim_global)
it_zdomoon_float = it_zdomoog_to_it_zdomoon_float(generate_zdomoog(ent_dim_global),ent_dim_global)
it_zomoon = it_zomoon0(ent_dim_global)
it_zomoon_float = it_zomoon_float0(ent_dim_global)
it_some_zomoon_2_0 = it0_some_zomoon_2_0(ent_dim_global)
it_some_zomoon_2_0_float = it0_some_zomoon_2_0_float(ent_dim_global)
it_omoon = it_omoog_to_it_omoon(generate_omoog(ent_dim_global),ent_dim_global)
it_omoon_float = it_omoog_to_it_omoon_float(generate_omoog(ent_dim_global),ent_dim_global)
#################################################################################################################################



# La fonction teste "nombre_tests_max" matrices
nombre_tests_max = 100
# Prend l'une des fonction precedentes
it = it_omoon_float

U = optimization(nombre_tests_max,it)









