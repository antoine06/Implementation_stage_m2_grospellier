## Le but est de numeroter les mots
# letter_to_int numerote les lettres de l'alphabet
###################################################################################################################################

# On commence par numeroter les mots de taille fixee
# Cette fonction renvoie le numero de "word"
def word_fixed_size_to_int(word,letter_to_int,number_letters):
	res = 0
	for letter in word:
		res = res*(number_letters) + letter_to_int(letter)
	return (res)

# L'inverse: cette fonction renvoie le mot numero i
def int_to_word_fixed_size(i,int_to_letter,number_letters,size):
	if (size < 0):
		print "size < 0 in int_to_word_fixed_size"
		abort
	if (size == 0):
		return (())
	i_last_letter = ZZ(mod(i,number_letters))
	last_letter = int_to_letter(i_last_letter)
	return (int_to_word_fixed_size((i - i_last_letter)/(number_letters),int_to_letter,number_letters,size-1) + (last_letter,))


# On ne fixe plus la taille des mots

# Cette fonction calcule le nombre de mots de taille inferieure ou egal a 'max_size'
def compute_nb_words(number_letters,max_size):
	res = (number_letters**(max_size+1)-1)/(number_letters-1)
	return res


# Cette fonction renvoie le numero de "word"
def word_to_int(word,letter_to_int,number_letters):
	size = len(word)
	res = compute_nb_words(number_letters,size-1)
	res = res + word_fixed_size_to_int(word,letter_to_int,number_letters)
	return res

# L'inverse: cette fonction renvoie le mot numero i
def int_to_word(i0,int_to_letter,number_letters):
	i = i0
	size = 0
	while(i > compute_nb_words(number_letters,size) - 1):
		size = size + 1
	i = i - compute_nb_words(number_letters,size)
	return int_to_word_fixed_size(i,int_to_letter,number_letters,size)


# Cette fonction renvoie "word" retourne
def star_word(word):
	l = len(word)
	word_star = tuple([word[l - i - 1] for i in range(l)])
	return word_star












