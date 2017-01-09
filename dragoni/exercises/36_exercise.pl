/*
 * EXERCISE 36
 *
 */
password(amico).

exercise36 :-
	ask_password(0).

ask_password(Limit) :-
	Limit < 3,
	write('Password: '),
	read(Input),
	password(Password),
	atom_chars(Input, InputChar),
	atom_chars(Password, PasswordChar),
	(   Input \== Password
	->  (   validate(InputChar, PasswordChar)
	    ->	NewLimit is Limit + 1,
		ask_password(NewLimit)
	    )
	;   !
	).


% Lettera di troppo
validate(Input, Password) :-
	length(Input, LengthInput),
	length(Password, LengthPassword),
	LengthInput =:= LengthPassword + 1,
	write('Hai inserito una lettera di troppo!'), nl.

% Lettera in meno
validate(Input, Password) :-
	length(Input, LengthInput),
	length(Password, LengthPassword),
	LengthInput =:= LengthPassword - 1,
	write('Hai inserito una lettera in meno!'), nl.

% Un sola lettera sbagliata
validate(Input, Password) :-
	length(Input, LengthInput),
	length(Password, LengthPassword),
	LengthInput =:= LengthPassword,
	word_difference(Input, Password, DiffNumber),
	DiffNumber =:= 1,
	write('Una sola lettera è sbagliata!'), nl.

word_difference([],[],0).
word_difference([Char1|Rest1], [Char2|Rest2], DiffNumber) :-
	(   Char1 \== Char2
	->  word_difference(Rest1, Rest2, NewDiffNumber),
	    DiffNumber is NewDiffNumber + 1
	;   word_difference(Rest1, Rest2, DiffNumber)
	).

% Due lettere adiacenti scambiate di posto
validate([First|[Next|_]], [Next|[First|_]]) :-
	write('Due lettere adiacenti scambiate'), nl.
validate([_|Rest1], [_|Rest2]) :-
	validate(Rest1, Rest2).
