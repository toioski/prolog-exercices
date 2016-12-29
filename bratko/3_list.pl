% Definition built-in predicates
mmember(X,[X|_]).

mmember(X,[_|Tail]) :-
	mmember(X,Tail).

conc([],L,L).
conc([X|L1],L2,[X|L3]) :-
	conc(L1,L2,L3).

% EXCERCISE 3.1
% a) Write a goal, using conc, to delete the last three elements of a
% list L
% L = [a,b,c,d,e,f,g,h,s,d], conc(X,[_,_,_],L).

% b) Write a goal to delete the first three elements and the last three
% elements from a list L
% L = [a,b,c,d,e,f,g,h,s,d], conc([_,_,_|X],[_,_,_],L).


% EXCERCISE 3.2
% Define the relation last(Item,List) so that Item is the last element
% of a list
% a) using conc
last(Item,List) :-
	conc(_,[Item],List).

% b) without conc
lastAlt(Item,[Item]).
lastAlt(Item,[_|Tail]) :-
	lastAlt(Item,Tail).

% EXERCISE 3.3
% Define two predicates:
%    evenlength(List) e oddlength(List)
% so that they are true if their argument is a list of even or odd
% length respectively.
even(Number) :-
	Y is mod(Number,2),
	Y =:= 0.

odd(Number) :-
	Y is mod(Number,2),
	Y \= 0.

evenlength(List) :-
	length(List,Length),
	Length \= 0,
	even(Length).

oddlength(List) :-
	length(List,Length),
	Length \= 0,
	odd(Length).


% EXERCISE 3.4
% Define the relation:
%    reverse(List,ReversedList)
% that reverses lists
reverseCustom([A],[A]).
reverseCustom([Head|Tail],R) :-
		reverseCustom(Tail,ReversedList),
		append(ReversedList,[Head],R).

reverseWithAppend([],[]).
reverseWithAppend([Head|Tail],ReversedList) :-
	reverseWithAppend(Tail,ReversedTail),
	append(ReversedTail,[Head],ReversedList).

reverseWithAccumulator([Head|Tail],Acc,Reversed) :-
	reverseWithAccumulator(Tail,[Head|Acc],Reversed).
reverseWithAccumulator([],A,A).
reverseWithAccumulator(List,ReversedList) :-
	reverseWithAccumulator(List,[],ReversedList).


/*
 * EXERCISE 3.5
 *
 * Define the predicate: palindrome(List)
 * A list is a palindrome if it reads the same in the forward and in the
 * backward direction. For example [m,a,d,a,m].
 *
 */
palindrome(List) :-
	reverseWithAccumulator(List,ReversedList),
	List = ReversedList.

/*
 * EXERCISE 3.6
 *
 * Define the relation: shift(List1,List2)
 * so that List2 is List1 'shifted rotationally' by one element to the
 * left. For example if List1=[2,3,4] then List2=[3,4,2]
 *
 */
shift([Head|Tail],List2) :- append(Tail,[Head],List2).

/*
 * EXERCISE 3.7
 *
 * Define the relation: translate(List1,List2)
 * to translate a list of numbers between 0 and 9 to a list of the
 * corresponding words. For example: [3,5,1,3] in [three,five,one,three]
 *
 */
means(0,zero).
means(1,one).
means(2,two).
means(3,three).
means(4,four).
means(5,five).
means(6,six).
means(7,seven).
means(8,eight).
means(9,nine).

translateNumbers([Head|Tail],Acc,List2) :-
	means(Head,Translation),
	append(Acc, [Translation], NewAcc),
	translateNumbers(Tail, NewAcc,List2).
translateNumbers([],A,A).
translateNumbers(L1,L2) :-
	translateNumbers(L1,[],L2).

/*
 * EXERCISE 3.8
 *
 * Define the relation: subset(Set,Subset)
 * where Set and Subset are two lists representing two sets. We would
 * like to be able to use this relation not only to check for the subset
 * relation, but also to generate all possible subset of a given set.
 *
 */
customSubset([], []).
customSubset([E|Tail], [E|NTail]):-
  customSubset(Tail, NTail).
customSubset([_|Tail], NTail):-
  customSubset(Tail, NTail).


/*
 * EXERCISE 3.9
 *
 * Define the relation: dividelist(List,List1,List2)
 * so that the elements of the List are partitioned between List1 and
 * List2, and List1 and List2 are approximately the same length
 *
 */

% If List is even
dividelist(List,List1,List2) :-
	append(List1,List2,List),
	length(List1,N),
	length(List2,N).
% If List is odd
dividelist(List,List1,List2) :-
	append(List1,List2,List),
	length(List1,N),
	N1 is N+1,
	length(List2,N1).

/*
 * EXERCISE 3.10
 *
 * Define the predicate: equal_length(L1,L2)
 * which is true if lists L1 and L2 have equal number of elements.
 *
 */
equal_length(List1,List2) :-
	length(List1,N),
	length(List2,N).

/*
 * EXERCISE 3.11
 *
 * Define the relation: flatten(List,FlatList)
 * where List can be a list of lists, and FlatList is List 'flattened'
 * so that the elements of List's sublists (or sub-sublists) are
 * reorganized as one plain list.
 * Example: [a,b,[c,d],[[[e]]]] -> [a,b,c,d,e]
 *
 */
flatten([],[]) :- !.
flatten(Element, [Element]) :- atom(Element); number(Element).
flatten([Head|Tail], L) :-
	flatten(Head, NewHead),
	flatten(Tail, NewTail), !,
	append(NewHead, NewTail, L).




































