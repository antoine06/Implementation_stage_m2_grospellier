## Dans ce fichier, on cree des fonctions qui renvoie des iterateurs de mots
# Un mot est un tuple.
# it_letters est un iterateur des lettres de l'alphabet
# Ces fonctions sont utilisees pour les sdp
#################################################################################################


# Renvoie un iterateur des mots de taille "size".
def it_words_fixed_size(it_letters,size):
	if size == 0 :
		yield(())
	else:
		for w in it_words_fixed_size(it_letters,size-1):
			for l in it_letters():
				yield(w + (l,))


# Renvoie un iterateur des mots de taille inferieure ou egale a "max_size".
def it_words(it_letters,max_size):
	for size in range(max_size + 1):
		for word in it_words_fixed_size(it_letters,size):
			yield(word)




# Renvoie un iterateur de pairs de mots de taille inferieure ou egale a "max_size".
def it_pair_words(it_letters,max_size):
	for w1 in it_words(it_letters,max_size):
		for w2 in it_words(it_letters,max_size):
			yield (w1,w2)



