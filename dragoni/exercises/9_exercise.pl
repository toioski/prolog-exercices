/*
 * EXERCISE 9
 *
 */

exercise9 :-
	ask_for_numbers(List),
	sort(List, SortedList),
	create_bst(SortedList, BST),
	write(BST).


ask_for_numbers(List) :-
	ask_for_numbers([],List).
ask_for_numbers(PartialList, List) :-
	write('Inserisci numero: '),
	read(Number),
	(   Number \== stop
	->  append(PartialList, [Number], NewPartiaList),
	    ask_for_numbers(NewPartiaList, List)
	;   List = PartialList
	).

% L'algoritmo funziona solo la lista ha un numero (2^n-1) di elementi,
% altrimenti non sarebbe possibile costruire il Binary Search Tree.
%
% Ref: https://it.wikipedia.org/wiki/Albero_binario_di_ricerca#/media/File:Albero-su-array.png
create_bst([Single], Single).
create_bst(List, BST) :-
	partition_list(List, MidValue, LeftPart, RightPart),
	BST = alb(MidValue, SXTree, DXTree),
	create_bst(LeftPart, SXTree),
	create_bst(RightPart, DXTree).


partition_list(List, MidValue, LeftPart, RightPart) :-
	length(List, Length),
	Index is (Length+1)/2,
	nth1(Index, List, MidValue),
	LeftStop is Index - 1,
	sub_list(List, 1, LeftStop, LeftPart),
	RightStart is Index + 1,
	sub_list(List, RightStart, Length, RightPart).

sub_list(List, Start, Stop, Sublist) :-
	sub_list(List, Start, Stop, [], Sublist).
sub_list(List, Start, Stop, Partial, Sublist) :-
        (   Start =< Stop
	->  nth1(Start, List, Value),
	    append(Partial, [Value], NewPartial),
	    NewStart is Start + 1,
	    sub_list(List, NewStart, Stop, NewPartial, Sublist)
	;   Sublist = Partial
	).



