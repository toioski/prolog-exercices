/*
 * EXERCISE 25
 *
 */

% on(X,Y) means pixel active
on(1,1).
on(3,3).
on(3,4).
on(3,5).
on(3,6).
on(3,7).
on(4,3).
on(4,7).
on(5,3).
on(5,7).
on(6,3).
on(6,7).
on(7,3).
on(7,7).

point(X,Y) :-
	on(X,Y),
	XL is X-1,
	XR is X+1,
	YT is Y+1,
	YB is Y-1,
	\+ on(XL,Y),
	\+ on(XR,Y),
	\+ on(X,YT),
	\+ on(X,YB),
	\+ on(XR,YT),
	\+ on(XR,YB),
	\+ on(XL,YT),
	\+ on(XL,YB).

% horizontal line
lineHorizontal(X1,Y1,X2,Y2) :-
	on(X1,Y1),
	XL is X1 - 1,
	\+ on(XL,Y1),
	Y2 = Y1,
	on(X2,Y2),
	X2 =\= X1,
	XR is X2 + 1,
	\+ on(XR,Y2),
	testHorizontalLine(X1,X2,Y1).

% test if between two points the others are all active
testHorizontalLine(S,S,_).
testHorizontalLine(StartX,EndX,Y) :-
	StartX < EndX,
	on(StartX,Y),
	NewStart is StartX + 1,
	testHorizontalLine(NewStart,EndX,Y).

lineVertical(X1,Y1,X2,Y2) :-
	on(X1,Y1),
	YB is X1-1,
	\+ on(X1,YB),
	X2 = X1,
	on(X2,Y2),
	Y2 =\= Y1,
	YT is Y2+1,
	\+ on(X2,YT),
	testVerticalLine(Y1,Y2,X1).

testVerticalLine(S,S,_).
testVerticalLine(StartY,EndY,X) :-
	StartY < EndY,
	on(X,StartY),
	NewStart is StartY + 1,
	testVerticalLine(NewStart,EndY,X).
