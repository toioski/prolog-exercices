/*
 * EXERCISE 58
 *
 * Da terminare: manca riempire la matrice con 1 e trasporla
 */
exercise58(Matrix, MatrixTras) :-
	write('Dimensione matrice: '),
	read(Dimension),
	create_dummy_matrix(Dimension, DummyMatrix),
	write('Elementi diversi da 1?'), nl,
	ask_user(DummyMatrix, Matrix).

ask_user(DummyMatrix, Matrix) :-
	read(List),
	(   List \== basta
	->  populate_matrix(Matrix, List, NewMatrix),
	    ask_user(NewMatrix, Matrix)
	;   fill_matrix_with_1(DummyMatrix, Matrix)
	).


% Crea matrice quadrata con tutti i valori unbound
create_dummy_matrix(Dimension, Matrix) :-
	create_dummy_matrix(Dimension, 0, [], Matrix).
create_dummy_matrix(Dimension, Counter, PartialMatrix, Matrix) :-
	(   Counter < Dimension
	->  NewCounter is Counter + 1,
	    create_dummy_row(Dimension, Row),
	    append(PartialMatrix, [Row], NewPartial),
	    create_dummy_matrix(Dimension, NewCounter, NewPartial, Matrix)
	;   Matrix = PartialMatrix
	).

% Crea lista con tutti valori unbound
create_dummy_row(Length, Row) :-
	create_dummy_row(Length, 0, Row).
create_dummy_row(Length, Counter, Row) :-
	Counter < Length,
	Row = [_|Rest],
	NewCounter is Counter + 1,
	create_dummy_row(Length, NewCounter, Rest).
create_dummy_row(_,_,[]).

populate_matrix(Matrix, Info, NewMatrix) :-
	populate_matrix(Matrix, Info, 1, [], NewMatrix).
populate_matrix([],_,_,M,M).
populate_matrix([Row|Rest], [I,J,Value], CounterI, Partial, NewMatrix) :-
	NewCounterI is CounterI + 1,
	(   CounterI \== I
	->  append(Partial, [Row], NewPartial),
	    populate_matrix(Rest, [I,J,Value], NewCounterI, NewPartial, NewMatrix)
	;   insert_in_row(Row, J, Value, NewRow),
	    append(Partial, [NewRow], NewPartial),
	    populate_matrix(Rest, [I,J,Value], NewCounterI, NewPartial, NewMatrix)
	).

insert_in_row(Row, Position, Value, NewRow) :-
	insert_in_row(Row, Position, 1, Value, [], NewRow).
insert_in_row([],_,_,_,R,R).
insert_in_row([Element|Rest], Position, Counter, Value, Partial, Row) :-
	NewCounter is Counter + 1,
	(   Counter \== Position
	->  append(Partial, [Element], NewPartial),
	    insert_in_row(Rest, Position, NewCounter, Value, NewPartial, Row)
        ;   append(Partial, [Value], NewPartial),
	    insert_in_row(Rest, Position, NewCounter, Value, NewPartial, Row)
	).

