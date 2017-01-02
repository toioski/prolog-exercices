/*
 * EXERCISE 29
 *
 */
sumComplexNumbers :-
	write('Insert the first complex number: '),
	read(Number1),
	write('Insert the second complex number: '),
	read(Number2),
	write('Insert the operation to execute: '),
	read(Operation),
	processOperation(Number1, Number2, Operation, Result),
	write('The result is: '), write(Result).

processOperation(Number1, Number2, Operation, Result) :-
	(   Operation == +
	->  sumNumbers(Number1, Number2, Result)
	;   subtractNumbers(Number1, Number2, Result)
	).

sumNumbers(n(SR1,R1,SI1,I1), n(SR2,R2,SI2,I2), n(SR,R,SI,I)) :-
	implodeNumber(SR1,R1,Real1),
	implodeNumber(SR2,R2,Real2),
	RealSum is Real1 + Real2,
	explodeNumber(RealSum, SR, R),
	implodeNumber(SI1,I1,Imm1),
	implodeNumber(SI2,I2,Imm2),
	ImmSum is Imm1 + Imm2,
	explodeNumber(ImmSum, SI, I).

subtractNumbers(n(SR1,R1,SI1,I1), n(SR2,R2,SI2,I2), n(SR,R,SI,I)) :-
	implodeNumber(SR1,R1,Real1),
	implodeNumber(SR2,R2,Real2),
	RealDiff is Real1 - Real2,
	explodeNumber(RealDiff, SR, R),
	implodeNumber(SI1,I1,Imm1),
	implodeNumber(SI2,I2,Imm2),
	ImmDiff is Imm1 - Imm2,
	explodeNumber(ImmDiff, SI, I).


implodeNumber(Sign, Module, Number) :-
	(   Sign == +
	->  Number = Module
	;   Number is -Module
	).

explodeNumber(Number, Sign, Module) :-
	(   Number >= 0
	->  Module = Number,
	    Sign = +
	;   Module is -Number,
	    Sign = -
	).
