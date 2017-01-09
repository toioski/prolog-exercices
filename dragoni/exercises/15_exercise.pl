/*
 * EXERCISE 15
 *
 */

exercise15(List, Tree) :-
	(   nonvar(List)
	->  list_to_tree(List, Tree)
	;   is_tree(Tree),
	    tree_to_list(Tree, List)
	).

% Converte una lista in un albero binario
% Caso induttivo
list_to_tree(List, Tree) :-
	is_list(List),
	nth0(0, List, Value),
	nth0(1, List, SXList),
	nth0(2, List, RXList),
	Tree = alb(Value, SXTree, DXTree),
	list_to_tree(SXList, SXTree),
	list_to_tree(RXList, DXTree).

% Caso base
list_to_tree(Element, Tree) :-
	atomic(Element),
	Tree = alb(Element,nil,nil).

% Controlla che sia un albero binario ben formato
is_tree(nil).
is_tree(alb(Value, SXTree, DXTree)) :-
	atomic(Value),
	is_tree(SXTree),
	is_tree(DXTree).

% Converte un albero binario in una lista
tree_to_list(alb(Value,nil,nil), Value).
tree_to_list(alb(Value, SXTree, DXTree), List) :-
	append([], [Value], VL),
	tree_to_list(SXTree, SXList),
	append(VL, [SXList], SL),
	tree_to_list(DXTree, DXList),
	append(SL, [DXList], List).

