% Genera tutti i possibili sottoinsiemi di una lista

subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).


% Esplode un atomo in caratteri
%
% atom_chars(Atom, ListOfChars)

% Funzione map
% Result = [2,3,4]
maplist(plus(1), [1,2,3], Result).

% Ordinare lista di liste in base alla lunghezza liste
sort_list(List, Result) :-
	map_list_to_pairs(length, List, PairsList),
	keysort(PairsList, SortPairs),
	pairs_values(SortPairs, Result).

% Funzione filter
% Result = [ciao]
exclude(number,[1,2,ciao,3],Result).

% Lettura/scrittura file
main :-
	open('file.txt', read, ReadStream),
	read_file(ReadStream, Meetings),
	close(ReadStream),
	open('newfile.txt', write, WriteStream),
	write_file(WriteStream, Meetings).

read_file(Stream, []) :-
	at_end_of_stream(Stream).
read_file(Stream, [X|L]) :-
	\+ at_end_of_stream(Stream),
	read(Stream, X),
	read_file(Stream, L).

write_file(Stream, [end_of_file]) :- !, close(Stream).
write_file(Stream, [T|C]) :-
	write(Stream,T), write(Stream,'.'), nl(Stream),
	write_file(Stream,C).

