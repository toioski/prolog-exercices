/*
 * EXERCISE 79
 *
 */

filenomi('dragoni/exercises/79_nomi.txt').
filecodici('dragoni/exercises/79_codici.txt').
fileentrate('dragoni/exercises/79_entrate.txt').
fileuscite('dragoni/exercises/79_uscite.txt').

exercise79 :-
	read_files(NomieCodici, Entrate, Uscite, Codici),

	find_regolari(Entrate, Uscite, NomieCodici, Regolari),
	nl, write('Regolari:'), nl, write(Regolari), nl,

	find_irregolari(Entrate, Uscite, Codici, NomieCodici, Irregolari),
	write('Irregolari:'),nl,write(Irregolari),nl,

	find_assenti(Entrate, Uscite, Codici, NomieCodici, Assenti),
	write('Assenti:'),nl,write(Assenti).




read_files(Nomi, Entrate, Uscite, Codici) :-
	filenomi(FileNomi),
	open(FileNomi, read, Stream1),
	read_file(Stream1, Nomi),
	close(Stream1), !,

	fileentrate(FileEntrate),
	open(FileEntrate, read, Stream2),
	read_file(Stream2, Entrate),
	close(Stream2), !,

	fileuscite(FileUscite),
	open(FileUscite, read, Stream3),
	read_file(Stream3, Uscite),
	close(Stream3), !,

	filecodici(FileCodici),
	open(FileCodici, read, Stream4),
	read_file(Stream4, Codici),
	close(Stream4), !,

	write(Nomi),nl,
	write(Codici),nl,
	write(Entrate),nl,
	write(Uscite), nl.

read_file(Stream,[]) :-
	at_end_of_stream(Stream).
read_file(Stream, [X|Rest]) :-
	\+ at_end_of_stream(Stream),
	read(Stream,X),
	read_file(Stream,Rest).

find_regolari(Entrate, Uscite, NomieCodici, Regolari) :-
	setof(Nome, ID^(
			member(ID, Entrate),
			member(ID, Uscite),
			find_occorrenze(ID, Entrate, N1),
			find_occorrenze(ID, Uscite, N2),
			N1 == N2,
			member(n(ID,Nome), NomieCodici)
		    ), Regolari).

find_irregolari(Entrate, Uscite, Codici, NomieCodici, Irregolari) :-
	setof(Nome, ID^N1^N2^(
			member(ID, Codici),
			find_occorrenze(ID, Entrate, N1),
			find_occorrenze(ID, Uscite, N2),
			N1 \== N2,
			member(n(ID,Nome), NomieCodici)
		    ), Irregolari).

find_assenti(Entrate, Uscite, Codici, NomieCodici, Assenti) :-
	setof(Nome, ID^(
			member(ID, Codici),
			\+ member(ID, Entrate),
			\+ member(ID, Uscite),
			member(n(ID,Nome), NomieCodici)
		    ), Assenti).

find_occorrenze(A, List, Count) :-
	findall(_, member(A,List), Result),
	length(Result, Count).
