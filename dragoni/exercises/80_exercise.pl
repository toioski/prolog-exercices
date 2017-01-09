/*
 * EXERCISE 80
 *
 */


exercise80 :-
	write('Le terne sono:'),nl,
	bagof([X,Y,Z], (terne([X,Y,Z])), Terne),
	write_terne(Terne),
	somma_terne(Terne, Somma),
	nl,nl,write('La somma è: '),write(Somma).

cifre([0,1,2,3,4,5,6,7,8,9]).

terne([X,Y,Z]) :-
	cifre(Cifre),
	member(X,Cifre),
	member(Y,Cifre),
	member(Z,Cifre),
	X \== Y,
	X \== Z,
	Y \== Z,
	(10*X+Y)*Z =:= (10*Y+Z)*X.

write_terne([]).
write_terne([Terna|Rest]) :-
	write(Terna), nl,
	write_terne(Rest).

somma_terne([],0).
somma_terne([Terna|Rest], Somma) :-
	sumlist(Terna, S),
	somma_terne(Rest, SS),
	Somma is S + SS.

