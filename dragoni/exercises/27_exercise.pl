/*
 * EXERCISE 27
 *
 */

% La soluzione funziona in questa maniera:
% 1. converte i due numeri in ingresso nelle corrispettive liste di
%    interi
% 2. aggiunge alla lista di interi più corta tanti zeri da farla
%    diventare lunga come l'altra lista
% 3. sottrae, iterativamente e a partire dal fondo, alla cifra del
%    numero grande la cifra del numero piccolo fino a quando non ha
%    scorso tutte le cifre del numero

diff(Number1, Number2, Difference, Sign) :-
	numberToDigits(Number1, Digits1),
	numberToDigits(Number2, Digits2),
	(   Number1 >= Number2
	->  Sign = +,
	    calcDiff(Digits1, Digits2, Difference)
	;   Sign = -,
	    calcDiff(Digits2, Digits1, Difference)
	).

% Convert a number to char to a list of digits
numberToDigits(Number, ListOfDigits) :-
	number_chars(Number, ListOfChars),
	chars_number(ListOfChars, ListOfDigits).

% Convert a list of chars to a list of integers
chars_number([],[]).
chars_number([Digit|Digits], Number) :-
	atom_number(Digit, NumberDigit),
	Number = [NumberDigit|Rest],
	chars_number(Digits, Rest).

% Add N zeroes to front of the list
addZero(List, N, NewList) :-
	generateZero(N, Zeroes),
	append(Zeroes, List, NewList).

% Generate a list of N zero
generateZero(0,[]).
generateZero(N, Zeroes) :-
	N > 0,
	Zeroes = [0|Rest],
	NewN is N - 1,
	generateZero(NewN, Rest).

clearZero([Current|Rest], NewList) :-
	(   Current \== 0
	->  NewList = [Current|Rest]
	;   clearZero(Rest, NewList)
	).

calcDiff(BigNumber, SmallNumber, Diff) :-
	length(BigNumber, BigLength),
	length(SmallNumber, SmallLength),
	DiffLength is BigLength - SmallLength,
	addZero(SmallNumber, DiffLength, NewSmallNumber),
	Counter = BigLength,
	calcDiff(BigNumber, NewSmallNumber, Counter, [], Diff).

calcDiff(BigNumber, SmallNumber, Counter, PartialDiff, Diff) :-
	(   Counter > 0
	->  nth1(Counter, BigNumber, BigElement),
	    nth1(Counter, SmallNumber, SmallElement),
	    NewCounter is Counter - 1,
	    subtractNumbers(BigElement, SmallElement, Riporto, SubResult),
	    append([SubResult], PartialDiff, NewPartialDiff),
	    (   Riporto \== 0
	    ->  applyRiporto(BigNumber, NewCounter, NewBigNumber),
	        calcDiff(NewBigNumber, SmallNumber, NewCounter, NewPartialDiff, Diff)
	    ;   calcDiff(BigNumber, SmallNumber, NewCounter, NewPartialDiff, Diff)
	    )
	;   clearZero(PartialDiff, Diff)
	).

% Sottrae due cifre e segnala se è stato necessario l'utilizzo del
% riporto
subtractNumbers(Number1, Number2, Riporto, Result) :-
	(   Number1 >= Number2
	->  Result is Number1 - Number2,
	    Riporto = 0
	;   Result is (Number1 + 10) - Number2,
	    Riporto = 1
	).

% Decrementa di 1 la cifra alla posizione Index all'interno della lista
% di cifre Number
applyRiporto(Number, Index, NewNumber) :-
	applyRiporto(Number, 1, Index, NewNumber).
applyRiporto([],_,_,[]).
applyRiporto([Digit|Digits], Counter, Index, NewNumber) :-
	(   Counter =\= Index
	->  NewNumber = [Digit|Rest],
	    NewCounter is Counter + 1,
	    applyRiporto(Digits, NewCounter, Index, Rest)
	;   NewDigit is Digit - 1,
	    NewNumber = [NewDigit|Rest],
	    NewCounter is Counter + 1,
	    applyRiporto(Digits, NewCounter, Index, Rest)
	).
