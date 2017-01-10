/*
 * EXERCISE 81
 *
 */

exercise81(List, EncodedList) :-
	conta_atomi(List, EncodedList).

conta_atomi(List, EncodedList) :-
	conta_atomi(List, 1, [], EncodedList).
conta_atomi([A], Counter, Partial, Solution) :-
	append(Partial, [[Counter,A]], Solution).
conta_atomi([A1,A2|Rest], Counter, Partial, Solution) :-
	A1 == A2,
	NewCounter is Counter +	1,
	conta_atomi([A2|Rest], NewCounter, Partial, Solution).
conta_atomi([A1,A2|Rest], Counter, Partial, Solution) :-
        A1 \== A2,
	(   Counter == 1
	->  append(Partial, [A1], NewPartial)
	;   append(Partial, [[Counter, A1]], NewPartial)
	),
	conta_atomi([A2|Rest], 1, NewPartial, Solution).
