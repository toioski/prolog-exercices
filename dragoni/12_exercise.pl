/*
 * EXERCISE 12
 *
 */
longer(ListOfList, LongerList, Length) :-
	findLongerList(ListOfList, UnsortedLongerList),
	sort(UnsortedLongerList, LongerList),
	length(LongerList, Length).

findLongerList(ListOfList, LongerList) :-
	findLongerList(ListOfList, [], LongerList).
findLongerList([],L,L).
findLongerList([List|OtherLists], PartialLongerList, LongerList) :-
	PartialLongerList == 0 ->
	findLongerList(OtherLists, List, LongerList);
	length(List, Length),
	length(PartialLongerList, MaxLength),
	Length > MaxLength ->
	NewPartialLongerList = List,
	findLongerList(OtherLists, NewPartialLongerList, LongerList);
	findLongerList(OtherLists, PartialLongerList, LongerList).
