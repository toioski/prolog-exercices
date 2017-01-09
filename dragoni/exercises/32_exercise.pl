/*
 * EXERCISE 32
 *
 */
sublistSum(IntegerList, Sum, Result) :-
	findall(List, subset(IntegerList, List), Sublists),
	member(Sublist, Sublists),
	sumlist(Sublist, Sum),
	Result = Sublist.

subset([], []).
subset([E|Tail], [E|NTail]):-
  subset(Tail, NTail).
subset([_|Tail], NTail):-
  subset(Tail, NTail).
