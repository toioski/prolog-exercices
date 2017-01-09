/*
 * ESERCIZIO 1
 *
 *
 * Scrivere un predicato Prolog max_seqs(L), dove L è una lista di
 * interi che stampi la sequenza crescente e la più estesa sequenza
 * decrescente
 *
 * ?- max_seqs([1,2,1,2,3,4,2,1,2,1]).
 * max sequenza crescente [1,2,3,4]
 * max sequenza decrescente [4,2,1]
 * true
 *
 */
max_seqs(IntegerList) :-
	max_ascending(IntegerList, AscendingList),
	write('max sequenza crescente '), write(AscendingList), nl,
	max_descending(IntegerList, DescendingList),
	write('max sequenza decrescente '), write(DescendingList), nl.

max_ascending(IntegerList, AscendingList) :-
	max_ascending(IntegerList, [], [], AscendingList).
max_ascending([First, Next], CurrentMax, Partial, Solution) :-
	(   First < Next
	->  append(CurrentMax, [First, Next], NewCurrentMax)
	;   append(CurrentMax, [First], NewCurrentMax)
	),
	length(NewCurrentMax, CurrentLength),
	length(Partial, PartialLength),
	(   CurrentLength > PartialLength
	->  Solution = NewCurrentMax
	;   Solution = Partial
	).

max_ascending([First,Next|Rest], CurrentMax, Partial, Solution) :-
	(   First < Next
	->  append(CurrentMax, [First], NewCurrentMax),
	    max_ascending([Next|Rest], NewCurrentMax, Partial, Solution)
	;   append(CurrentMax, [First], NewCurrentMax),
	    length(NewCurrentMax, CurrentLength),
	    length(Partial, PartialLength),
	    (	CurrentLength > PartialLength
	    ->	NewPartial = NewCurrentMax,
		max_ascending([Next|Rest], [], NewPartial, Solution)
	    ;	max_ascending([Next|Rest], [], Partial, Solution)
	    )
	).

% Uguale al max_ascending con segno opposto
max_descending.

/*
 * ESERCIZIO 2
 *
 * Scrivere un predicato Prolog cartprod(X), che legge dall'input due
 * qualunque liste e, dopo aver controllato che effettivamente siano
 * liste ben formate di qualcosa, restituisca in X il loro prodotto
 * cartesiano
 *
 */

cartprod(X) :-
	read(List1),
	is_list(List1),
	read(List2),
	is_list(List2),
	prodotto(List1, List2, X).

prodotto(List1, List2, Result) :-
	prodotto(List1, List2, [], Result).
prodotto([], _,R,R).
prodotto([Current|Rest], List2, Partial, Result) :-
	bagof((Current, Other), member(Other, List2), Coppie),
	append(Partial, Coppie, NewPartial),
	prodotto(Rest, List2, NewPartial, Result).

/*
 * ESERCIZIO 3
 *
 * Definire un predicato Prolog take(List,N,Result) che ha successo se e
 * solo e Result è la lista costituita dai primi N elementi di List
 * (nello stesso ordine). Se List ha meno di N elementi o se N è zero o
 * negativo, il goal take(List,N,Result) fallisce segnalando il tipo di
 * errore.
 *
 * Definire inoltre un predicato drop(List,N,Result) che ha successo se
 * e solo se Result è la lista costituita dagli elementi di List (nello
 * stesso ordine) che rimangono quando sono stati eliminati i primi N
 * elementi. Se List ha meno di N elementi o se N è zero o negativo, il
 * goal drop(List,N,Result) fallisce segnalando il tipo di errore.
 *
 * ?- take([a,b,c,d,e,f],4,Result).
 * Result = [a,b,c,d]
 *
 * ?- take([a,b,c,d,e,f],-4,Result).
 * ERRORE: N non positivo
 * false.
 *
 */

take(List, N, _) :-
	length(List, Length),
	Length < N, !,
	write('ERRORE: La lista ha meno di '),
	write(N),
	write(' elementi'),
	fail.

take(_, N, _) :-
	N =< 0, !,
	write('ERRORE: N non positivo'),
	fail.

take(List, N, Result) :-
	take1(List, N, [], Result).

take1([Current|Rest], Counter, Partial, Result) :-
	(   Counter > 0
	->  NewCounter is Counter - 1,
	    append(Partial, [Current], NewPartial),
	    take1(Rest, NewCounter, NewPartial, Result)
	;   Result = Partial
	).

drop(List, N, _) :-
	length(List, Length),
	Length < N, !,
	write('ERRORE: La lista ha meno di '),
	write(N),
	write(' elementi'),
	fail.

drop(_,N,_) :-
	N =< 0, !,
	write('ERRORE: N non positivo'),
	fail.

drop(List, N, Result) :-
	drop1(List, N, [], Result).

drop1([],_,R,R).
drop1([Current|Rest], Counter, Partial, Result) :-
	(   Counter > 0
	->  NewCounter is Counter - 1,
	    drop1(Rest, NewCounter, Partial, Result)
	;   append(Partial, [Current], NewPartial),
	    drop1(Rest, Counter, NewPartial, Result)
	).

