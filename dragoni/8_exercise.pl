/*
 * EXERCISE 8
 *
 */

start :-
	write('Inserisci la lista: '),
	read(List),
	process(List).

process(List) :-
	repeat,
	write('Inserisci l\'atomo di cui vuoi la posizione: '),
	read(Atom),
	(
	Atom == fine,!;
	findPosition(Atom, List, 0),fail
	).

findPosition(Atom,[],_) :-
	write('L\'atomo '),write(Atom), write(' non è presente'), nl.
findPosition(Atom, [Head|Tail], Counter) :-
	Head == Atom ->
	NewCounter is Counter + 1,
	write('L\'atomo si trova in posizione '), write(NewCounter), nl;
	NewCounter is Counter +	1,
	findPosition(Atom, Tail, NewCounter).



