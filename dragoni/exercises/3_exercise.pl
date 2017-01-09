/*
 * EXERCISE 3
 *
 * Scrivere due predicati per calcolare l’intersezione e l’unione di due
 * “insiemi" liste
 *
 */
intersezione([],_,[]).
intersezione([Head|Tail], OtherList, Intersection) :-
	member(Head, OtherList) ->
	Intersection = [Head|Rest],
	intersezione(Tail, OtherList, Rest);
	intersezione(Tail, OtherList, Intersection).

unione([],L,L).
unione([Head|Tail], OtherList, Union) :-
	\+ member(Head, OtherList) ->
	Union = [Head|Rest],
	unione(Tail, OtherList, Rest);
	unione(Tail, OtherList, Union).
