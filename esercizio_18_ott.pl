% Ricerca percorso


s(arad,zerind).
%s(zerind,arad).
s(arad,sibiu).
s(arad,timisoara).
s(zerind,oradea).
s(oradea,sibiu).
s(timisoara,lugoj).
s(sibiu,fagaras).
s(sibiu,rimnicuVilcea).
s(lugoj,mehadia).
s(mehadia,dobreta).
s(dobreta,craiova).
s(rimnicuVilcea,craiova).
s(craiova,pitesti).
s(rimnicuVilcea,pitesti).
s(fagaras,bucharest).
s(pitesti,bucharest).
s(giurgiu,bucharest).
s(bucharest,urziceni).
s(urziceni,hirsova).
s(hirsova,eforie).
s(urziceni,vaslui).
s(vaslui,iasi).
s(iasi, neamt).
s(oradea,arad).

destinazione(bucharest).

% Se parto dalla destinazione, il cammino per arrivare alla
% destinazione è la destinazione stessa (tappo della ricorsione).
%
% Il DFS va bene se non ci sono cicli e se non ci sono stati infiniti
depthFirstSearch(N,[N]):- destinazione(N).
depthFirstSearch(N,[N|C]):- s(N,N1), depthFirstSearch(N1,C).

% DFS con accumulatore: previene i cicli, ma non funziona con spazi di
% stati infiniti
depthFirstSearchAcc(Perc,Nodo,[Nodo|Perc]):- destinazione(Nodo).
depthFirstSearchAcc(Perc,Nodo,Percorso):-
	s(Nodo,Nodo1),
	\+ member(Nodo1,Perc), % previene i cicli
	depthFirstAcc([Nodo|Perc],Nodo1,Percorso).


searchPath(Node, Path) :- depthFirstSearch(Node,Path).
