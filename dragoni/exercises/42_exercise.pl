/*
 * EXERCISE 42
 *
 */
vocale(a).
vocale(e).
vocale(i).
vocale(o).
vocale(u).

consonante(b).
consonante(c).
consonante(d).
consonante(f).
consonante(g).
consonante(h).
consonante(l).
consonante(m).
consonante(n).
consonante(p).
consonante(q).
consonante(r).
consonante(s).
consonante(t).
consonante(v).
consonante(z).

exercise42(Word, Anagramma) :-
	anagramma(Word, Anagramma).

anagramma(Word, Anagramma) :-
	atom_chars(Word, CharWord),
	bagof(Permutation, permutation(CharWord, Permutation), Permutations),
	member(PossibleAnagramma, Permutations),
	is_valid_anagramma(PossibleAnagramma),
	Anagramma = PossibleAnagramma.

is_valid_anagramma(Anagramma) :-
        is_valid_anagramma(Anagramma, 0, 0).
is_valid_anagramma([],_,_).
is_valid_anagramma([Char|Chars], VocCounter, ConsCounter) :-
	ConsCounter =< 3,
	VocCounter =< 2,
	(   consonante(Char)
	->  NewConsCounter is ConsCounter + 1,
	    NewVocCounter is 0,
	    is_valid_anagramma(Chars, NewVocCounter, NewConsCounter)
	;   NewVocCounter is VocCounter + 1,
	    NewConsCounter is 0,
	    is_valid_anagramma(Chars, NewVocCounter, NewConsCounter)
	).
