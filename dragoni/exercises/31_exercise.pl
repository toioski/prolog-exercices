/*
 * EXERCISE 31
 *
 */

rotate(Times, List, RotatedList) :-
	rotate(Times, 0, List, RotatedList).
rotate(C,C,S,S).
rotate(Times, Counter, PartialSolution, Solution) :-
	Counter < Times,
	NewCounter is Counter + 1,
	leftRotate(PartialSolution, NewPartialSolution),
	rotate(Times, NewCounter, NewPartialSolution, Solution).

leftRotate([Head|Tail], NewList) :-
	append(Tail,[Head],NewList).
