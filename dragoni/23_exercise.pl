/*
 * EXERCISE 23
 *
 */
smallest([a(Number)|Rest], a(Smallest)) :-
	smallest([a(Number)|Rest], Number, Smallest).
smallest([],S,S).
smallest([a(Number)|Rest], PartialSmallest, Smallest) :-
	(   Number < PartialSmallest
	->  NewPartial = Number,
	    smallest(Rest, NewPartial, Smallest)
	;   smallest(Rest, PartialSmallest, Smallest)
	).

