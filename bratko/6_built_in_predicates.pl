/*
 * Interesting interpretation of expression simplifier
 * LINK: http://stackoverflow.com/questions/20171175/replacing-parts-of-expression-in-prolog
 *
 */
csimplify(1*X, X1) :- csimplify(X, X1).
csimplify(X*1, X1) :- csimplify(X, X1).
csimplify(0+X, X1) :- csimplify(X, X1).
csimplify(X+0, X1) :- csimplify(X, X1).
csimplify(X+X,2*X1) :- atom(X), csimplify(X,X1).

csimplify(X, X)       :- number(X) ; atom(X) ; var(X).
csimplify(X+Y, X1+Y1) :- csimplify(X, X1), csimplify(Y, Y1).
csimplify(X-Y, X1-Y1) :- csimplify(X, X1), csimplify(Y, Y1).
csimplify(X*Y, X1*Y1) :- csimplify(X, X1), csimplify(Y, Y1).
csimplify(X/Y, X1/Y1) :- csimplify(X, X1), csimplify(Y, Y1).

/*
 * EXERCISE 6.1
 *
 * Write a procedure simplify to simbolically simplify summation
 * expressions with numbers and symbols (lower-case letters). Let the
 * procedure rearrange the expressions so that all the symbols precede
 * numbers.
 *
 */
:- op(500,xfy,user:(+)).

simplify(Expression, Simplified) :-
	split(Expression, Symbols0, Numbers0),
	sumlist(Numbers0, Numbers),
	append(Symbols0, [Numbers], Symbols),
	unparse(Symbols, Simplified).

split(X+Y, [X|Symbols], Numbers) :- atom(X), split(Y, Symbols, Numbers).
split(X+Y, Symbols, [X|Numbers]) :- integer(X), split(Y, Symbols, Numbers).
split(X, [X], [])                :- atom(X).
split(X, [], [X])		 :- integer(X).

unparse([X], X).
unparse([X|Xs], X+Y)             :- unparse(Xs, Y).

/*
 * EXERCISE 6.2
 *
 * Define the procedure: add_to_tail(List,Item)
 * to store new element into a list. List contains all the stored
 * elemens followed by a tail that is not instantiated and can thus
 * accomodate new elements. Example: List = [a,b,c|Tail].
 *
 */

add_to_tail(Item, [_|Tail]) :-
	var(Tail),
	Tail = [Item|Tail].
add_to_tail(Item, [_|Tail]) :-
	add_to_tail(Item, Tail).

/*
 * EXERCISE 6.3
 *
 * Define the predicate: ground(Term)
 * so that it is true if Term does not contain any uninstantiated
 * variables.
 *
 */

% NON FUNZIONA, MA È LA COSA PIÙ VICINA CHE SONO RIUSCITO A FARE
cground([]) :- !.
cground([Head|Tail]) :-
	compound(Head),
	Head =.. [_|Args],
	cground(Args),
	cground(Tail).
cground([Head|Tail]) :-
	nonvar(Head),
	cground(Tail).
cground(Term) :-
	Term =.. [_|Args],
	cground(Args).

/*
 * EXERCISE 6.6
 *
 * a) Write a Prolog question to remove the wole product table from the
 * database.
 * b) Modify the question so that it only removes those entries where
 * the product is 0.
 *
 */
maketable :-
	L = [0,1,2,3,4,5,6,7,8,9],
	member(X, L),
	member(Y, L),
	Z is X*Y,
	assert(product(X, Y, Z)),
	fail.

removetable :-
	retract(product(_,_,_)),
	fail.

removeProductByID(Id) :-
	retract(product(_,_,Id)),
	fail.

/*
 * EXERCISE 6.8
 *
 * Use bagof to define the relation powerset(Set,Subsets) to compute the
 * set of all subsets of a given set (all sets represented as lists).
 *
 */
powerset(Set, Subsets):-
	findall(Subset, append(Subset,_,Set), Subsets).

/*
 * EXERCISE 6.13
 *
 * Define the relation: starts(Atom,Character)
 * to check whether Atom starts with Character
 *
 */
starts(Atom, Character) :-
	name(Atom, Letters),
	name(Character, Char),
	arg(1,Letters, Letter),
	Letter =:= Char.

/*
 * EXERCISE 6.14
 *
 * Define the procedure plural that will convert nouns into their plural
 * form.
 *
 */
plural(SingleWord, PluralWord) :-
	name(SingleWord, Letters),
	name(s,S),
	append(Letters, S, PluralLetters),
	name(PluralWord, PluralLetters).
