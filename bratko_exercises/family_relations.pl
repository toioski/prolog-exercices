parent(pam,bob).
parent(tom,bob).
parent(bob,ann).
parent(bob,pat).
parent(tom,liz).
parent(pat,jim).

female(pam).
female(liz).
female(pat).
female(ann).
male(tom).
male(bob).
male(jim).

% EXCERCISE 1.2
% a) Who is Pat's parent?
% parent(X,pat).

% b) Doez Liz have a child?
% parent(liz,X).

% c) Who is Pat's grandparent?
% parent(X,pat), parent(Y,X).

grandparent(X,Z) :-
	parent(X,Y),
	parent(Y,Z).

sister(X,Y) :-
	parent(Z,X),
	parent(Z,Y),
	female(X),
	X \= Y.

brother(X,Y) :-
	parent(Z,X),
	parent(Z,Y),
	male(X),
	X \= Y.

% EXCERCISE 1.3
% a) Everybody who has a child is happy
happy(X) :-
	parent(X,_).
% b) For all X, if X has a child wo has a sister then X has two children
hastwochildren(X) :-
	parent(X,Y),
	sister(_,Y).

% EXCERCISE 1.4
% Define the relation grandchild using the parent relation
grandchild(X,Z) :-
	parent(Y,X),
	parent(Z,Y).

% EXCERCISE 1.5
% Define the relation aunt(X,Y) in terms of the relations parent and
% sister
aunt(Z,Y) :-
	parent(X,Y),
	sister(X,Z).

ancestor(X,Z) :-
	parent(X,Z).
ancestor(X,Z) :-
	parent(X,Y),
	ancestor(Y,Z).

