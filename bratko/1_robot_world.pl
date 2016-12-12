see(a,2,5).
see(d,5,5).
see(e,5,2).

on(a,b).
on(b,c).
on(c,table).
on(d,table).
on(e,table).

% Compute z-coordinate of a block
z(Block,0) :-
	on(Block,table).
z(Block,Z) :-
	on(Block,OtherBlock),
	z(OtherBlock,Z0),
	Z is Z0+1.

% Alternative
zz(Block,0) :-
	on(Block,table).
zz(Block,Z0+1) :-
	on(Block,OtherBlock),
	zz(OtherBlock,Z0).

% More complete rule (variable height of blocks)
zzz(Block,0) :-
	on(Block,table).
zzz(Block, Z0 + height(OtherBlock)) :-
	on(Block,OtherBlock),
	zzz(OtherBlock,Z0).
