/*
 * EXERCISE 3.13
 *
 * Suggest an appropriate definition of operators ('was','of','the') to
 * be able to write clauses like "diana was the secretary of the
 * department"
 *
 */
:-op(600,xfy,was).
:-op(600,xfy,of).
:-op(500,fx,the).

diana was the secretary of the department.

/*
 * EXERCISE 3.15
 *
 * Write member(Element,List) as 'Element in List'
 * Write conc(List1,List2,List) as 'concatenating List1 and List2 gives
 * List3'
 *
 */

:-op(600,xfx,in).

in(Element,[Element|_]).
in(Element,[_|Tail]) :-
   in(Element,Tail).


:-op(600,fy,concatenating).
:-op(500,xfy,and).
:-op(400,xfx,gives).

concatenating [] and L gives L.
concatenating [T|C1] and L gives [T|C2] :-
	concatenating C1 and L gives C2.


