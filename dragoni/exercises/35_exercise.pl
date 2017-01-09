/*
 * EXERCISE 35
 *
 */
exercise35(P1, P2, Result) :-
	find_highest_rank(P1, HighestRank1),
	find_highest_rank(P2, HighestRank2),
	max(HighestRank1, HighestRank2, HighestRank),
	sum_polynomials(P1, P2, HighestRank, Result).


max(Number1, Number2, Max) :-
	Number1 >= Number2,
	Max = Number1;
	Max = Number2.

find_highest_rank(Polynomial, HighestRank) :-
	find_highest_rank(Polynomial, 0, HighestRank).
find_highest_rank([],R,R).
find_highest_rank([x(_,_,Rank)|Polynomials], PartialRank, HighestRank) :-
	(   Rank > PartialRank
	->  NewPartialRank is Rank,
	    find_highest_rank(Polynomials, NewPartialRank, HighestRank)
	;   find_highest_rank(Polynomials, PartialRank, HighestRank)
	).

sum_polynomials(P1, P2, HighestRank, Result) :-
	sum_polynomials(P1, P2, 1, HighestRank, [], Result).
sum_polynomials(P1, P2, Counter, HighestRank, PartialResult, Result) :-
	(  Counter < HighestRank + 1
	->  get_monomial_by_rank(P1, Counter, M1),
	    get_monomial_by_rank(P2, Counter, M2),
	    sum_monomials(M1, M2, Monomial),
	    NewCounter is Counter + 1,
	    (	Monomial \== 0
	    ->	append(PartialResult, [Monomial], NewPartialResult),
	        sum_polynomials(P1, P2, NewCounter, HighestRank, NewPartialResult, Result)
	    ;	sum_polynomials(P1, P2, NewCounter, HighestRank, PartialResult, Result)
	    )
	;   Result = PartialResult
	).

get_monomial_by_rank(Polynomial, Rank, Monomial) :-
	get_monomial_by_rank(Polynomial, Rank, [], Monomial).
get_monomial_by_rank([],_,Acc,Result) :-
	length(Acc,Length),
	(   Length > 0
	->  Result = Acc
	;   Result = [x(+,0,_)]
	).
get_monomial_by_rank([x(S,C,P)|Polynomials], Rank, PartialM, Monomial) :-
	(   P =\= Rank
	->  get_monomial_by_rank(Polynomials, Rank, PartialM, Monomial)
	;   append(PartialM, [x(S,C,P)], NewPartialM),
	    get_monomial_by_rank(Polynomials, Rank, NewPartialM, Monomial)
	).

sum_monomials([x(S1,C1,R)], [x(S2,C2,R)], Result) :-
	implode_number(S1,C1,N1),
	implode_number(S2,C2,N2),
	N is N1 + N2,
	(   N > 0
	->  explode_number(N,S,C),
	    Result = x(S,C,R)
	;   Result = 0
	).

implode_number(Sign, Module, Number) :-
	(   Sign == -
	->  Number is -Module
	;   Number = Module
	).

explode_number(Number, Sign, Module) :-
	(   Number >= 0
	->  Sign = +,
	    Module = Number
	;   Sign = -,
	    Module is -Number
	).
