% Versione con accumulatore
% Il problema è che devo inizializzare l'accumulatore a 0 quando lo
% chiamo
lunghezzaListaAcc([],Acc,Acc).
lunghezzaListaAcc([_|C],A,Acc):-
	A1 is A+1,
	lunghezzaListaAcc(C,A1,Acc).

% Definisco quindi un predicato "inizializzatore" del predicato
% precedente così che l'utilizzatore non si deve preoccupare
lunghezzaListaAcc(L,Lunghezza):- lunghezzaListaAcc(L,0,Lunghezza).
