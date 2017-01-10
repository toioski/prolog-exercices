/*
 * EXERCISE 82
 *
 */

exercise82(Atom1, Atom2) :-
	name(Atom1, List1),
	shorten(List1, List2),
	name(Atom2, List2).

shorten(CharList1, CharList2) :-
	shorten(CharList1, [], CharList2).
shorten([C], Partial, Solution) :-
	append(Partial, [C], Solution).
shorten([C1,C2|Rest], Partial, Solution) :-
	C1 == C2,
	shorten([C2|Rest], Partial, Solution).
shorten([C1,C2|Rest], Partial, Solution) :-
	C1 \== C2,
	append(Partial, [C1], NewPartial),
	shorten([C2|Rest], NewPartial, Solution).
