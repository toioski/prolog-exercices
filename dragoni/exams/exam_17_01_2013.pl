/*
 * ESERCIZIO 1 (22 PUNTI)
 *
 * Due porzioni di database Prolog PRIMA1 e PRIMA2, di lunghezza non
 * nota, contengono (come fatti) i risultati di una gara che si svolge
 * in due manche.
 *
 * Ogni fatto della prima porzione contiene il nome del concorrente e un
 * intero che rappresenta il punteggio ottenuto nella prima manche.
 * Analogamente, ogni fatto della seconda porzione contiene il nome del
 * concorrente ed un intero che rappresenta il punteggio ottenuto nella
 * seconda manche.
 *
 * Nella seconda porzione i fatti sono in sequenza diversa e i
 * concorrenti che non sono presenti nella seconda porzione sono da
 * ritenersi squalificati.
 *
 */
prima(sandro,15).
prima(amelia,9).
prima(marco,9).
prima(laura,6).
prima(paolo,7).
prima(sara,10).
prima(gigi,5).

seconda(sandro,10).
seconda(laura,6).
seconda(paolo,9).
seconda(marco,9).
seconda(amelia,9).

/*
 * Scrivere un predicato Prolog gara(L1,L2) che restituisca.
 * 1. nella lista L1 i punteggi complessivi per ogni concorrente,
 * strutturati in funtori concorrente/punteggio, ordinata in ordine
 * decrescente rispetto al punteggio (a parità di punteggio non ha
 * importanza l'ordine dei nomi)
 * 2. nella lista L2 i concorrenti squalificati in ordine
 * alfabeticamente decrescente
 *
 */


gara(L1,L2) :-
	calcola_punteggi(L1),
	trova_squalificati(L2).

calcola_punteggi(Punteggi) :-
	setof(Conc/P1+P2, (prima(Conc,P1), seconda(Conc,P2)), List),
	eval_sum(List, EvalList),
	map_list_to_pairs(punteggio, EvalList, PairsList),
	sort(1, @>=, PairsList, SortPairs),
	pairs_values(SortPairs, Punteggi).

punteggio(_/Punteggio, Punteggio).

eval_sum([],[]).
eval_sum([(Nome/P1+P2)|Other], NewList) :-
	Sum is P1+P2,
	NewList = [Nome/Sum|Rest],
	eval_sum(Other, Rest).


trova_squalificati(Squalificati) :-
	setof(Conc, P1^P2^(prima(Conc,P1), \+seconda(Conc,P2)), Squalificati).
