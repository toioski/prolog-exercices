/*
 * EXERCISE 22
 *
 * Non ho capito perchè alla fine non unifica List con la lista di
 * numeri immessi
 *
 */
medie(List, Limit) :-
	repeat,
	write('Insert number: '),
	read(Number),
	(   Number == 0
	->  !
	;   ( Number < Limit
	    ->	append(List, [Number], NewList),
		calcMedia(NewList, Value),
		printMedia(NewList, Value),
	        medie(NewList, Limit)
	    ;	write('Number discarded'),
		nl,
	        fail
	    )
	).

calcMedia(List, Value) :-
	length(List, Length),
	sumList(List, Sum),
	Value is Sum/Length.

printMedia(List, Value) :-
	write('Has been inserted '),
	length(List, Length),
	write(Length),
	write(' numbers and the medium is '),
	write(Value),
	nl.

sumList(List, Sum) :-
	    sumList(List, 0, Sum).
sumList([],Sum,Sum).
sumList([Number|Numbers], PartialSum, Sum) :-
	NewSum is PartialSum + Number,
	sumList(Numbers, NewSum, Sum).

