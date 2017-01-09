/*
 * ESERCIZIO 1 (20 PUNTI)
 *
 * Il file memo.dat contiene i dati relativi agli appuntamenti
 * giornalieri di uno studio legale. Ciascun appuntamento è
 * caratterizzato dal cognome della persona da incontrare e l'ora (dalle
 * 7 alle 13).
 *
 * Es.:
 * memo(verdi,11).
 * memo(rossi,7).
 * memo(bianchi,9).
 * memo(blu,7).
 * memo(neri,11).
 * memo(carli,11).
 * memo(rapini,8).
 *
 * Si scriva un programma in Prolog che:
 * a) realizzi una lista di liste; la dimensione della lista è pari al
 * numero delle ore di ricevimento della giornata e ciascun elemento
 * contiene l'ora e i nominativi (ordinati alfabeticamente)delle persone
 * che verranno ricevute
 * b) letto un cognome dallo standard input, visualizzi a quale ora tale
 * persona verrà ricevuta o un opportuno messaggio se per quella persona
 * non è previsto alcun	appuntamento
 * c) stampi sul file agenda.dat gli elenchi dei nominativi, ciascuno
 * preceduto dall'ora di ricevimento
 *
 */

file('dragoni/exams/memo.dat').
destfile('dragoni/exams/agenda.dat').

go :-
	file(File),
	open(File, read, ReadStream),
	read_file(ReadStream, Meetings),
	close(ReadStream), !,
	Opening is 7,
	Closing is 13,
	create_agenda(Meetings, Opening, Closing, Agenda),
	write('Inserisci il cognome:'), nl,
	read(Cognome),
	search_meeting(Agenda, Cognome),
	destfile(DestFile),
	open(DestFile, write, WriteStream),
	write_file(WriteStream, Meetings).

read_file(Stream, []) :-
	at_end_of_stream(Stream).
read_file(Stream, [X|L]) :-
	\+ at_end_of_stream(Stream),
	read(Stream, X),
	read_file(Stream, L).

write_file(Stream, [end_of_file]) :- !, close(Stream).
write_file(Stream, [T|C]) :-
	T = memo(Name,Hour),
	write(Stream,Hour),
	write(Stream,' '),
	write(Stream,Name),
	nl(Stream),
	write_file(Stream,C).

create_agenda(Meetings, Opening, Closing, Agenda) :-
	create_agenda(Meetings, Opening, Closing, [], Agenda).
create_agenda(Meetings, Opening, Closing, Partial, Agenda) :-
	(   Opening =< Closing
	->  (    bagof(Name, member(memo(Name,Opening),Meetings), Names)
	    ->	 sort(Names, SortedNames),
	         append(Partial, [[ora(Opening), persone(SortedNames)]], NewPartial)
	    ;	 append(Partial, [ora(Opening), persone(nessuna)], NewPartial)
	    ),
	    NewOpening is Opening + 1,
	    create_agenda(Meetings, NewOpening, Closing, NewPartial, Agenda)
	;   Agenda = Partial
	).

search_meeting(Agenda, Cognome) :-
        member([ora(Hour), persone(Persone)],Agenda),
	member(Cognome, Persone),
	write(Cognome),
	write(' ha appuntamento per le '),
	write(Hour).
search_meeting(_,Cognome) :-
	write('Nessun appuntamento per '),
	write(Cognome).

/*
 * ESERCIZIO 2 (10 PUNTI)
 *
 * Scrivere un predicato Prolog cambia(L1,L2,L3,L4) dove:
 * - L1 è una lista di atomi Prolog consistenti in una lettera
 * - L2 è una lista di elementi di tipo a/b in cui a è dello stesso tipo
 *   di atomi di L1 e b un intero
 * - L3 è la lista che si ottiene cambiando in L1 ogni occorenza
 *   dell'elemento a di L1 con b.
 *   Qualora a non fosse presente in L2 lo si sostituisca con 0. Gli
 *   elementi di L1 possono essere ripetuti. In L2 possono essere
 *   presenti degli a/b con a non presente in L1; tali a/b vanno
 *   restituiti nella lista L4.
 *
 *   ?- cambia([a,d,s,a,c,t], [d/8,t/3,q/7,s/2,u/9], L3, L4)
 *   L3 = [0,8,2,0,0,3]
 *   L4 = [q/7, u/9]
 *
 */

cambia(L1,L2,L3,L4) :-
	bagof(Int, Atom^I^(
		  member(Atom,L1),
		  (   member(Atom/I,L2)
		  ->  Int = I
		  ;   Int = 0
		  )
	      ),L3),
	bagof(Atom/Int, (
		  member(Atom/Int,L2),
		  \+ member(Atom, L1)
	       ), L4).
