/*
 * EXERCISE 24
 *
 */
nElements([],_,[]).
nElements([List|OtherLists], Index, Result) :-
	(   nth1(Index, List, Element)
	->  Result = [Element|Rest],
	    nElements(OtherLists, Index, Rest)
	;   nElements(OtherLists, Index, Result)
	).

launchNElements(List, Index, Result) :-
	nElements(List, Index, Res),
	sort(Res, Result).

