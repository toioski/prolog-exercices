customLength([],0).
customLength([_|Tail],N) :-
	customLength(Tail,N1),
	N is N1+1.

/*
 * EXERCISE 3.16
 *
 * Define the relation: max(X,Y,Max)
 * so that Max is the greater of two numbers X and Y.
 *
 */
max(X,X,X).
max(X,Y,Max) :-
	X > Y,
	Max = X.
max(X,Y,Max) :-
	X =< Y,
	Max = Y.

/*
 * EXERCISE 3.17
 *
 * Define the predicate: maxlist(List,Max)
 * so that Max is the greatest number of a given list of numbers List.
 *
 */
maxlist([],0).
maxlist([Head|Tail],Max) :-
	maxlist(Tail,TailMax),
	Head > TailMax,
	Max is Head.
maxlist([Head|Tail],Max) :-
	maxlist(Tail,TailMax),
	Head =< TailMax,
	Max is TailMax.

/*
 * EXERCISE 3.18
 *
 * Define the predicate: sumlist(List,Sum)
 * so that Sum is the sum of a given list of numbers List.
 *
 */
customSumlist([],0).
customSumlist([Head|Tail],Sum) :-
	customSumlist(Tail,TailSum),
	Sum is Head + TailSum.

/*
 * EXERCISE 3.19
 *
 * Define the predicate: ordered(List)
 * which is true if List is an ordered list of numbers.
 *
 */
ordered([]).
ordered([_]).
ordered([Head,TailHead|Tail]) :-
	Head =< TailHead,
	ordered([TailHead|Tail]).

/*
 * EXERCISE 3.20
 *
 * Define the predicate: subsum(Set,Sum,Subset)
 * so that Set is a list of numbers, Subset is a subset of these
 * numbers, and the sum of the numbers in Subset is Sum
 *
 */
customSubset(Subset,List) :-
	append(_,List2,List),
	append(Subset,_,List2).

subsum(Set,Sum,Subset) :-
	customSubset(Subset,Set),
	customSumlist(Subset,Sum).

/*
 * EXERCISE 3.21
 *
 * Define the procedure: between(N1,N2,X)
 * which, for two given integers N1 and N2, generates through
 * backtracking all the integers X that satisfy the constraint N1 < X <
 * N2
 *
 */
between(Lower,Upper,X) :-
	X is Lower + 1,
	X < Upper.
between(Lower,Upper,X) :-
	NewLower is Lower + 1,
	NewLower < Upper,
	between(NewLower,Upper,X).

