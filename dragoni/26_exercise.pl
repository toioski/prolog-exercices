/*
 * EXERCISE 26
 *
 * Il programma porta perfettamente, è l'esempio del prof che è
 * sbagliato perchè nella sua prima soluzione ci sono 7 'x' e non 6 come
 * imporrebbe il limite!
 *
 */
sviluppo(Partite, MaxX, Max1, Max2, Solution) :-
	sviluppo(Partite, MaxX, Max1, Max2, [], Solution).
sviluppo([],_,_,_,S,S).
sviluppo([Partita|Partite], MaxX, Max1, Max2, PartialSolution, Solution) :-
	member(Value,Partita),
	(   Value == x
	->  NewMaxX is MaxX - 1,
	    NewMaxX >= 0,
	    append(PartialSolution, [Value], NewPartialSolution),
	    sviluppo(Partite, NewMaxX, Max1, Max2, NewPartialSolution, Solution)
	;   Value == 1
	->  NewMax1 is Max1 - 1,
	    NewMax1 >= 0,
	    append(PartialSolution, [Value], NewPartialSolution),
	    sviluppo(Partite, MaxX, NewMax1, Max2, NewPartialSolution, Solution)
	;   Value == 2
	->  NewMax2 is Max2 - 1,
	    NewMax2 >= 0,
	    append(PartialSolution, [Value], NewPartialSolution),
	    sviluppo(Partite, MaxX, Max1, NewMax2, NewPartialSolution, Solution)
	).


printSolution([]).
printSolution([Head|Tail]) :-
	write(Head), write(','),
	printSolution(Tail).
