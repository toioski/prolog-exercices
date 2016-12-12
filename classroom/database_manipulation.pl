% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

% DATABASE
% figlio(mario,francesco).
% figlio(giovanni,francesco).

% Questo comando inserisce in cima all'insieme delle clausole del
% predicato 'figlio'
%
% DATABASE
% figlio(paolo,francesco).
% figlio(mario,francesco).
% figlio(giovanni,francesco).

%asserta(figlio(paolo,francesco)).

% dynamic predicate: Predicato che può essere ritrattato a runtime
% tramite assert e retract

% A :- B1, assert(son(john,sue)), B2
% Analizziamo questa clausola:
% 1. prova a fare B1 e ci riesce
% 2. esegue l'assert (che è procedurale) e restituisce true
% 3. arriva ad eseguire B2 che per risoluzione LSD non unifica e
% restituisce false
% 4. si torna indietro ad 'assert' per backtracking, ma non può essere
% ritrattato perchè è procedurale, quindi restituisce false
% 5. si ritorna a B1 e rinizia la giostra
%
% Il punto critico è il punto 4: cioè l'assert non può essere ritrattato


% assertz in clausole è una tecnica molto usata in Prolog: dopo che al
% passo precedente ho trovato la soluzione, la asserisco in modo tale
% che la prossima volta la ho già senza che la eseguo e il programma
% migliora in continuazione

fai_tabella :-
	L = [1,2,3,4],
	member(X,L), member(Y,L),
	P is X * Y,
	assertz(prodotto(X,Y,P)),
	fail.
fai_tabella.

stampa_tabella :-
	prodotto(X,Y,Z), stampa(X,Y,Z),
	fail.
stampa_tabella.

stampa(X,Y,Z) :-
	write(X), write(' * '),
	write(Y), write(' = '), write(Z), nl.

togli_dalla_tabella :-
	write(' Quale valore del prodotto non vuoi che compaia nella tabella?'),
	nl, read(P), togli_p(P).

togli_p(P) :-
	retract(prodotto(_,_,P)), fail.
% Sarebbe un cut green: lo usiamo per rendere deterministico il
% comportamento
togli_p(_) :- !.


% ESEMPIO
% Calcolo posizione lettera in alfabeto
alphabet([a,b,c,d,e,f,g,h,i,l,m,n,o,p,q,r,s,t,u,v,z]).

letter(A, POS) :-
	alphabet(C),
	letter(A,C,POS).

letter(A, [A|_], 1).
letter(A, [B|C], D):-
	A\== B,
	letter(A,C,E),
	D is E+1.
