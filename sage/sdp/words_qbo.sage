load("tools/word_to_int.sage")
load("tools/word_generator.sage")


def it_letters_qbo(N,M):
	for i in range(N):
		yield('z',i)
	for j in range(M):
		yield('y',j)


def it_words_fixed_size_qbo(N,M,size):
	return(it_words_fixed_size(lambda : it_letters_qbo(N,M),size))

def it_words_qbo(N,M,max_size):
	return (it_words(lambda : it_letters_qbo(N,M),max_size))

def it_pair_words_qbo(N,M,max_size):
	return(it_pair_words(lambda : it_letters_qbo(N,M),max_size))


#N0 = 3
#M0 = 4
#size0 = 2
#L = list(it_words_fixed_size_qbo(N0,M0,size0))
##print L
#for word in L:
#	i = word_to_int_qbo(word,N0,M0)
#	word2 = int_to_word_qbo(i,N0,M0)
#	print word,i
#	print word2
#	print (word == word2)
#
#
#abort







############################################################################################################################################
# We apply word_to_int pour quantum bilinear optimization
# A letter is ('z',i) pour i in [|O,N-1|] or ('y',i) for i in [|0,M-1|]
# Attention: en general utiliser word_to_int_qbo((letter,),N,M) = letter_to_int(letter,N)+1 pour connaitre le numero d'une lettre
def _letter_to_int_qbo(letter,N,M):
	(s,i) = letter
	if (s == 'z'):
		if (i < N):
			return i
	if (s == 'y'):
		if (i < M):
			return (N+i)
	print "problem in _letter_to_int_qbo function"
	abort

# The inverse
def _int_to_letter_qbo(i,N,M):
	if i < N:
		return ('z',i)
	if (i < N+M):
		return ('y',i-N)
	print "problem in _int_to_letter_qbo function"
	abort

def _word_fixed_size_to_int_qbo(word,N,M):
	lti = lambda l : _letter_to_int_qbo(l,N,M)
	res = word_fixed_size_to_int(word,lti,N+M)
	return res

def _int_to_word_fixed_size_qbo(i,N,M,size):
	itl = lambda i0 : _int_to_letter_qbo(i0,N,M)
	res = int_to_word_fixed_size(i,itl,N+M,size)
	return res

def word_to_int_qbo(word,N,M):
	lti = lambda l : _letter_to_int_qbo(l,N,M)
	res = word_to_int(word,lti,N+M)
	return res

def int_to_word_qbo(i,N,M):
	itl = lambda i0 : _int_to_letter_qbo(i0,N,M)
	res = int_to_word(i,itl,N+M)
	return res






