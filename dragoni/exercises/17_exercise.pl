/*
 * EXERCISE 17
 *
 */
countLettersInAtom(Atom) :-
	explodeAtom(Atom, ASCIIList),
	calculateFrequencies(ASCIIList, FrequenciesList),
	printTable(FrequenciesList).


explodeAtom(Atom, ASCIIList) :-
	name(Atom, ASCIIList).


% LAUNCHER of CALCULATE FREQUENCIES
% ASCIIList: the entire phrase (in ASCII) with duplicates characters
% LettersToCount: single characters (in ASCII) of the phrase.
calculateFrequencies(ASCIIList, Frequencies) :-
	sort(ASCIIList, LettersToCount),
	calculateFrequencies(LettersToCount, ASCIIList, [], Frequencies).

% CALCULATE FREQUENCIES
% Use the accumulator pattern
calculateFrequencies([],_,F,F).
calculateFrequencies([ASCIILetter|Letters], List, PartialFrequencies, Frequencies) :-
	\+ isCapitalLetter(ASCIILetter) ->
	countElementInList(ASCIILetter, List, Counter),
	name(Letter, [ASCIILetter]),
	append(PartialFrequencies, [Letter/Counter], NewPartial),
	calculateFrequencies(Letters, List, NewPartial, Frequencies);
	calculateFrequencies(Letters, List, PartialFrequencies, Frequencies).


isCapitalLetter(ASCIILetter) :-
	ASCIILetter >= 65,
	ASCIILetter =< 90.

countElementInList(Element, List, Counter) :-
	countElementInList(Element, List, 0, Counter).
countElementInList(_,[],C,C).
countElementInList(Element, [Head|Tail], PartialCounter, Counter) :-
	Element == Head ->
	NewCounter is PartialCounter + 1,
	countElementInList(Element, Tail, NewCounter, Counter);
	countElementInList(Element, Tail, PartialCounter, Counter).

printTable(Frequencies) :-
	tab(4), write('Letter'), tab(4), write('Frequency'), nl,
	printFrequencies(Frequencies).
printFrequencies([]).
printFrequencies([Letter/Frequency|Rest]) :-
	tab(7),write(Letter),tab(7),write(Frequency),nl,
	printFrequencies(Rest).
