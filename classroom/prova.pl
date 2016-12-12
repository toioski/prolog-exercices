succ(civitanova, montegranaro).
succ(civitanova, montecosaro).
succ(montecosaro, morrovalle).
succ(morrovalle, macerata).

destinazione(macerata).


dfs(N, [N]):- destinazione(N).
dfs(N, [N|C]):-
	succ(N, N1),
	dfs(N1, C).
