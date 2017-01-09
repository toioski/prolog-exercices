/*
 * EXERCISE 30
 *
 */

% DATABASE
from_to(ancona,
     roma,[
	 ora(8:10,9:30,[lun,mar,sab]),
	 ora(9:30,10:40,daily),
	 ora(19:30,20:45,[mer,ven,dom])
     ]
   ).

from_to(roma,
	milano, [
	    ora(10:15,12:00,[lun])
	]
       ).

from_to(milano,
	parigi, [
	    ora(18:00,19:45,[lun])
	]
       ).


% PROGRAM

day(lun).
day(mar).
day(mer).
day(gio).
day(ven).
day(sab).
day(dom).

:- op(500,xfx,:).

generateDaysList(DaysList) :-
	bagof(X, day(X), DaysList).

% Handle only direct flights
trip(Departure, Destination, Day, Itinerary) :-
	from_to(Departure, Destination, FlightCalendar),
	generateDaysList(DaysList),
	member(Day, DaysList),
	write('Day: '), write(Day), nl,
	findSolutions(FlightCalendar, Day, Solutions),
	member((Dep)/(Arr), Solutions),
	Itinerary = perc(Departure, Dep, Destination, Arr),
	write('Percorso: '), write(Itinerary), nl.

findSolutions(FlightCalendar, Day, Solutions) :-
	findSolutions(FlightCalendar, Day, [], Solutions).
findSolutions([],_,S,S).
findSolutions([Flight|Flights], Day, PartialSolutions, Solutions) :-
	arg(1, Flight, DepartureHour),
	arg(2, Flight, ArrivalHour),
	arg(3, Flight, Days),
	(   Days == daily
	->  append(PartialSolutions, [DepartureHour/ArrivalHour], NewPartialSolutions),
	    findSolutions(Flights, Day, NewPartialSolutions, Solutions)
	;   (	member(Day, Days)
	    ->	append(PartialSolutions, [DepartureHour/ArrivalHour], NewPartialSolutions),
		findSolutions(Flights, Day, NewPartialSolutions, Solutions)
	    ;	findSolutions(Flights, Day, PartialSolutions, Solutions)
	    )
	).

% Handle not direct flights
trip1(Departure, Destination, Day, Itinerary) :-
	trip(Departure, Destination, Day, 0:0, [], Itinerary).
trip(Departure, Destination, Day, MinDepartureHour, PartialItinerary, Itinerary) :-
	from_to(Departure, Arrival, FlightCalendar),
	generateDaysList(DaysList),
	member(Day, DaysList),
	findSolutions2(FlightCalendar, Day, MinDepartureHour, Solutions),
	member((Dep)/(Arr), Solutions),
        append(PartialItinerary, [perc(Departure, Dep, Arrival, Arr)], NewPartialItinerary),
	NewMinDepHour = Arr,
	(   Destination \== Arrival
	->  trip(Arrival, Destination, Day, NewMinDepHour, NewPartialItinerary, Itinerary)
	;   Itinerary = NewPartialItinerary
	).

findSolutions2(FlightCalendar, Day, MinDepartureHour, Solutions) :-
	findSolutions2(FlightCalendar, Day, MinDepartureHour, [], Solutions).
findSolutions2([],_,_,S,S).
findSolutions2([Flight|Flights], Day, MinDepartureHour, PartialSolutions, Solutions) :-
	arg(1, Flight, DepartureHour),
	isLater(DepartureHour,MinDepartureHour),
	arg(2, Flight, ArrivalHour),
	arg(3, Flight, Days),
	(   Days = daily
	->  append(PartialSolutions, [DepartureHour/ArrivalHour], NewPartialSolutions),
	    findSolutions2(Flights, Day, MinDepartureHour, NewPartialSolutions, Solutions)
	;   (   member(Day, Days)
	    ->	append(PartialSolutions, [DepartureHour/ArrivalHour], NewPartialSolutions),
		findSolutions2(Flights, Day, MinDepartureHour, NewPartialSolutions, Solutions)
	    ;	findSolutions2(Flights, Day, MinDepartureHour, PartialSolutions, Solutions)
	    )
	).


isLater(H1:M1, H2:M2) :-
	H1 > H2;
	H1 =:= H2,
	M1 > M2.


