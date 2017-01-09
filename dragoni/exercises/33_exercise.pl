/*
 * EXERCISE 33
 *
 */
possibiliPosizioniCavallo(Riga/Colonna, Positions) :-
	findall(NewPosition, newPosition(Riga/Colonna, NewPosition), Positions).


newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga - 1,
	NewRiga > 0,
	NewColonna is Colonna - 2,
	NewColonna > 0.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga - 1,
	NewRiga > 0,
	NewColonna is Colonna + 2,
	NewColonna < 9.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga - 2,
	NewRiga > 0,
	NewColonna is Colonna - 1,
	NewColonna > 0.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga - 2,
	NewRiga > 0,
	NewColonna is Colonna + 1,
	NewColonna < 9.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga + 1,
	NewRiga < 9,
	NewColonna is Colonna - 2,
	NewColonna > 0.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga + 1,
	NewRiga < 9,
	NewColonna is Colonna + 2,
	NewColonna < 9.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga + 2,
	NewRiga < 9,
	NewColonna is Colonna - 1,
	NewColonna > 0.

newPosition(Riga/Colonna, NewRiga/NewColonna) :-
	NewRiga is Riga + 2,
	NewRiga < 9,
	NewColonna is Colonna + 1,
	NewColonna < 9.



