/*
 * EXERCISE 56
 *
 */
:- op(30,fx,user:non).



exercise56(ClauseList) :-
	refutazione_lineare(ClauseList).

refutazione_lineare(ClauseList)	:-
	member(Clause1, ClauseList),
	member(Clause2, ClauseList),
	Clause1 \== Clause2,
	calcola_risolvente(Clause1, Clause2, Risolvente),
	(   Risolvente == []
	->  !
	;   (   \+ member(Risolvente, ClauseList)
	    ->	write(Clause1), tab(4), write(Clause2), nl,
		write(Risolvente), nl,
		append([Risolvente], ClauseList, NewClauseList),
		refutazione_lineare(NewClauseList)
	    ;	fail
	    )
	).

calcola_risolvente(Clause1, Clause2, Risolvente) :-
	member(L1, Clause1),
	member(L2, Clause2),
	is_complementare(L1, L2),
	exclude(is_equal(L1), Clause1, C1),
	exclude(is_equal(L2), Clause2, C2),
	(   C1 == C2
	->  Risolvente = C1
	;   append(C1, C2, Risolvente)
	).

is_equal(L1, Element) :-
	L1 == Element.

% Controlla se due letterali sono complementari
is_complementare(Term1, Term2) :-
	non X = Term1,
	Term2 == X;
	non X = Term2,
	Term1 == X.
