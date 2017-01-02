/*
 * EXERCISE 7: CRIVELLO DI ERATOSTENE
 *
 * Il procedimento è il seguente: si scrivono tutti i naturali a partire
 * da 2 fino ad n in un elenco detto setaccio. Poi si cancellano
 * (setacciano) tutti i multipli del primo numero del setaccio (escluso
 * lui stesso). Si prosegue cosi fino ad arrivare in fondo. I numeri che
 * restano sono i numeri primi minori od uguali a n. E come se si
 * utilizzassero dei setacci a maglie via via più larghe: il primo
 * lascia passare solo i multipli di 2, il secondo solo i multipli di 3,
 * e cosi via.
 *
 */
generateNumbers(N, Numbers) :- % Launcher
	generateNumbers(N, 2, Numbers).
generateNumbers(N, N, [N]). % Base case
generateNumbers(N, Counter, Numbers) :- % Generate first N integer numbers
	Counter < N,
	Numbers = [Counter|Rest],
	NewCounter is Counter + 1,
	generateNumbers(N, NewCounter, Rest).

generatePrimeNumbers([],[]).
generatePrimeNumbers([Number|Numbers], NewNumbers) :-
	deleteMultiplesOf(Number, [Number|Numbers], NoMultiples),
	NewNumbers = [Number|Rest],
	generatePrimeNumbers(NoMultiples, Rest).

deleteMultiplesOf(_,[],[]). % Base case
deleteMultiplesOf(Number, [TestNumber|Numbers], New) :- % Delete mutiples of Number
	Modulo is TestNumber mod Number,
	Modulo =\= 0 -> % Not a multiple
	    New = [TestNumber|Rest],
	    deleteMultiplesOf(Number, Numbers, Rest);
	deleteMultiplesOf(Number, Numbers, New). % Is a multiple, discard

formatSolution([],_,_).
formatSolution([Number|Numbers], Counter, Lines) :-
	Counter < Lines ->
	write(Number), write(' '),
	NewCounter is Counter + 1,
	formatSolution(Numbers, NewCounter, Lines);
	nl,tab(4), write(Number), write(' '),
	NewCounter is 1,
	formatSolution(Numbers, NewCounter, Lines).

solveCrivello(Limit, Solution, TableLines) :-
	generateNumbers(Limit, NumberList),
	generatePrimeNumbers(NumberList, Solution),
	formatSolution(Solution, TableLines, TableLines).

