/*
 * EXERCISE 41
 *
 */
exercise41(NumberList, Result) :-
	sum_number_list(NumberList, NumericSum),
	number_chars(NumericSum, Result).

sum_number_list(NumberList, Sum) :-
	sum_number_list(NumberList, 0, Sum).
sum_number_list([],S,S).
sum_number_list([NumberList|Numbers], PartialSum, Sum) :-
	get_number_from_list(NumberList, Number),
	NewPartialSum is PartialSum + Number,
	sum_number_list(Numbers, NewPartialSum, Sum).

% Convert a list of integers into a number
get_number_from_list(NumberList, Number) :-
	convert_to_char_list(NumberList, CharList),
	number_chars(Number, CharList).

% Convert a list of integers into a list of chars
convert_to_char_list([],[]).
convert_to_char_list([Number|Numbers], CharList) :-
	atom_number(Char,Number),
	CharList = [Char|Rest],
	convert_to_char_list(Numbers, Rest).
