/*
 * EXERCISE 57
 *
 */

ang(alfa,[10,23,18]).
ang(beta,[22,0,38]).
ang(gamma,[12,28,30]).
ang(delta,[21,30,28]).
ang(epsilon,[21,59,58]).

exercise57(Angle) :-
	retractall(user:selezionato(_,_)),
	get_all_differences(Angle).

get_all_differences(Result) :-
	get_all_differences([], Result).
get_all_differences(Partial, Result) :-
	ang(Name1, Val1),
	ang(Name2, Val2),
	Name1 \== Name2,
	(\+ selezionato(Name1, Name2) ; \+ selezionato(Name2, Name1)),
	assert(selezionato(Name1, Name2)),
	angle_diff(Val1, Val2, Diff),
	append(Partial, [Name1/Name2], NewPartial),
	get_all_differences(NewPartial, Result).

angle_diff(Val1, Val2, Diff) :-
	nth0(0, Val1, Gradi1),
	nth0(0, Val2, Gradi2),
	GradiSign is Gradi1 - Gradi2,
	modulo(GradiSign, Gradi),
	nth0(1, Val1, Primi1),
	nth0(1, Val2, Primi2),
	PrimiSign is Primi1 - Primi2,
	modulo(PrimiSign, Primi),
	nth0(2, Val1, Secondi1),
	nth0(2, Val2, Secondi2),
	SecondiSign is Secondi1 - Secondi2,
	modulo(SecondiSign, Secondi),
	Diff = [Gradi,Primi,Secondi].

modulo(Number, Modulo) :-
	Number >= 0,
	Modulo = Number;
	Modulo is -Number.


