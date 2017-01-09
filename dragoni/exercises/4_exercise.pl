/*
 * EXERCISE 4
 *
 * Scrivere un programma che sostituisca un intero scelto con un atomo
 * letterale scelto lasciando inalterato l’ordine.
 *
 */
sostituisci([],_,_,[]).
sostituisci([Head|Tail], Integer, Atom, NewList) :-
	Head == Integer ->
	NewList = [Atom|Rest],
	sostituisci(Tail, Integer, Atom, Rest);
	NewList = [Head|Rest],
	sostituisci(Tail, Integer, Atom, Rest).
