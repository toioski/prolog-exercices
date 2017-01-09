/*
 * EXERCISE 43
 *
 */

exercise43(List) :-
	clear_list(List, ClearList),
	sort_by_functorlength(ClearList, SortedList),
	print_list(SortedList).


clear_list(List, ClearList) :-
	clear_list(List, [], ClearList).
clear_list([],S,S).
clear_list([Current|Rest], PartialSolution, Solution) :-
	(   \+ atomic(Current), has_atomic_args(Current)
	->  append(PartialSolution, [Current], NewPartialSolution),
	    clear_list(Rest, NewPartialSolution, Solution)
	;   clear_list(Rest, PartialSolution, Solution)
	).

has_atomic_args([]).
has_atomic_args([Current|Rest]) :-
	!, atomic(Current),
	has_atomic_args(Rest).
has_atomic_args(Current) :-
	Current =.. [_|Args],
	has_atomic_args(Args).

% Genialata per l'ordinamento:
% 1. map_list_to_pairs genera una lista dove ogni elemento è del tipo
%    funtore-elemento (e.g. per-per(i,i))
% 2. keysort ordina una lista key-value in base alla chiave
% 3. pairs_values elimina le chiavi da una lista key-value e lascia solo
%    i value
sort_by_functorlength(List, SortedList) :-
	map_list_to_pairs(custom_functor, List, Pairs),
	keysort(Pairs, Sorted_pairs),
	pairs_values(Sorted_pairs, SortedList).

% Necessario per essere passato a map_list_to_pairs.
% La normale funzione functor/3 verrà chiamata da dentro
% map_list_to_pairs in questo modo:
%
%     call(functor, ListElement, UnboundVar)
%
% che equivale a scrivere functor(ListElement, UnboundVar).
%
% Un predicato functor con arità 2 non esiste ed è per questo che
% ho dovuto definire il predicato qui sotto.
custom_functor(Elem, Functor) :-
	functor(Elem, Functor, _).

print_list(List) :-
	write('FUNTORE'),
	tab(10),
	write('ARGOMENTI'), nl,
	print_list_content(List).

print_list_content([]).
print_list_content([Current|Rest]) :-
	Current =.. [Functor|Args],
	write(Functor),
	tab(16),
	write_args(Args), nl,
	print_list_content(Rest).

write_args([]).
write_args([Arg|Rest]) :-
	write(Arg),
	write(' '),
	write_args(Rest).




