/*
 * EXERCISE 5.2
 *
 * Define the procedure in a more efficient way
 *
 */
class(0, zero).
class(Number,positive) :- Number > 0, !.
class(_,negative).

/*
 * EXERCISE 5.3
 *
 * Define the procedure: split(Numbers,Positives,Negatives)
 * which splits a list of numbers into two list: positive ones
 * (including zero) and negative ones.
 * Propose two versions: one with a cut and one without
 *
 */
split([],[],[]).
split([Number|Rest],[Number|Positives],Negatives) :-
	Number >= 0,
	split(Rest,Positives,Negatives).
split([Number|Rest],Positives,[Number|Negatives]) :-
	Number < 0,
	split(Rest,Positives,Negatives).

splitWithCut([],[],[]).
splitWithCut([Number|Rest],[Number|Positives],Negatives) :-
	Number >= 0, !,
	splitWithCut(Rest,Positives,Negatives).
splitWithCut([Number|Rest],Positives,[Number|Negatives]) :-
	splitWithCut(Rest,Positives,Negatives).

/*
 * EXERCISE 5.4
 *
 * Given two lists, Candidates and RuledOut, write a seuqnce of goals
 * (using member and not) that will through backtracking find all the
 * items in Candidates that are not RuledOut.
 *
 */
goodCandidates([],_,[]).
goodCandidates([Candidate|Others],RuledOut,[Candidate|GoodOnes]) :-
	\+ member(Candidate,RuledOut), !,
	goodCandidates(Others,RuledOut,GoodOnes).
goodCandidates([_|Others],RuledOut,GoodOnes) :-
	goodCandidates(Others,RuledOut,GoodOnes).

/*
 * EXERCISE 5.5
 *
 * Define the set subtraction relation:
 * set_difference(Set1,Set2,SetDifference)
 * where all the three sets are repsented as lists.
 *
 */
set_difference([],_,[]).
set_difference([Element|RestSet],OtherSet,[Element|RestDifference]) :-
	\+ member(Element,OtherSet), !,
	set_difference(RestSet,OtherSet,RestDifference).
set_difference([_|Set],OtherSet, SetDifference) :-
	set_difference(Set,OtherSet,SetDifference).


