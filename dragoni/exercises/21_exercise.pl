/*
 * EXERCISE 21
 *
 */
order(IntegerList, LB, UB, List) :-
	orderNumbers(IntegerList, LB, UB, UnsortedList),
	sort(UnsortedList, List).
orderNumbers([],_,_,[]).
orderNumbers([Integer|Integers], LB, UB, List) :-
	isOutsideInterval(Integer, LB, UB) ->
	List = [Integer|Rest],
	orderNumbers(Integers, LB, UB, Rest);
	orderNumbers(Integers, LB, UB, List).

isOutsideInterval(Integer, LowerBound, UpperBound) :-
	Integer > UpperBound;
	Integer < LowerBound.
