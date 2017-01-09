/*
 * EXERCISE 14
 *
 */
run :-
	acquireList(List),
	processList(List).

acquireList(List) :- acquireList([], List).
acquireList(PartialList, List) :-
	read(Number),
	(
	    Number == 0 ->
	    !, List = PartialList;
	    append(PartialList, [Number], NewPartialList),
	    acquireList(NewPartialList, List)
	).

processList(List) :-
	length(List, Length),
	nth1(Length, List, LastElement),
	(
	    LastElement < 10 ->
	    countElementInList(LastElement, List, Counter),
	    writeCount(LastElement, Counter);
	    Index is Length - 1,
	    nth1(Index, List, PrevElement),
	    (
		PrevElement < 10 ->
		countElementInList(PrevElement, List, Counter),
		writeCount(PrevElement, Counter);
		write('Nessun elemento < 10')
	    )
	 ).

countElementInList(Element, List, Counter) :-
	countElementInList(Element, List, 0, Counter).
countElementInList(_,[],C,C).
countElementInList(Element, [Head|Tail], PartialCounter, Counter) :-
	Element == Head ->
	NewCounter is PartialCounter + 1,
	countElementInList(Element, Tail, NewCounter, Counter);
	countElementInList(Element, Tail, PartialCounter, Counter).

writeCount(Element, Count) :-
	write('There are '),
	write(Count),
	write(' elements '),
	write('equal to '),
	write(Element).
