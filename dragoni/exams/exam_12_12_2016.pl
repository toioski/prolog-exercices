/*
 * ESERCIZIO 2
 *
 * Si supponga di aver nel database PROLOG un insieme di fatti a due
 * argomenti pezzi(CODICE,QUANTITA), dove CODICE è il codice numerico di
 * un prodotto e QUANTITA è la corrispondente quantita di prodotto
 * presente nel magazzino.
 *
 * Scrivere un predicato run(TOTALE) che la da tastiera un codice-schema
 * CODS (descritto sotto) e restituisca il totale dei pezzi disponibili
 * corrispondenti presenti.
 *
 * Il codice-schema CODS permette di specificare gruppi di codice
 * mediante un carattere jolly, consistente nel punto interrogativo (?),
 * che sostituisce singole cifre e può essere presente un numero di
 * volte qualsiasi.
 *
 * Si supponga che il database sia molto grande e che il numero di
 * caratteri jolly nel CODS sia sempre piccolo. Ad esempio, si
 * suppongano presenti nel database i seguenti fatti:
 *
 */
pezzi(23412,2). pezzi(23414,4). pezzi(23415,3). pezzi(23418,2).
pezzi(23512,1). pezzi(23514,2). pezzi(23518,2). pezzi(23519,8).
pezzi(23712,4). pezzi(23714,5). pezzi(23717,5). pezzi(23519,2).
pezzi(43412,1). pezzi(53412,2). pezzi(63412,9). pezzi(26412,1).

/*
 * Si hanno le seguenti chiamate e risposte:
 *
 * ? - run(T)
 * Dai il codice: '23?1?'
 * T = 40.
 *
 * ?- run(T).
 * Dai il codice: '?3?1?'
 * T = 52.
 *
 */

run(T) :-
       write('Inserisci il codice CODS:'),
       read(CODS),
       findPiecesByCODS(CODS, Pieces),
       getQuantityForPieces(Pieces, Sum),
       T = Sum.

% Get all the 'pezzi' from the DB and then remove the ones which does
% not respect the CODS
findPiecesByCODS(CODS, Pieces) :-
	atom_chars(CODS, CharCODS),
	bagof(Piece/Number, pezzi(Piece, Number), AllPieces), % get all 'pezzi' in DB
	findPiecesByCODS(CharCODS, 0, AllPieces, Pieces).
findPiecesByCODS([],_,S,S).
findPiecesByCODS([CODSLetter|RestCODS], Index, PartialPieces, Pieces) :-
	(   CODSLetter \== ?
	->  filterPiecesByCODS(PartialPieces, CODSLetter, Index, NewPartial),
	    NewIndex is Index + 1,
	    findPiecesByCODS(RestCODS, NewIndex, NewPartial, Pieces)
	;   NewIndex is Index + 1,
	    findPiecesByCODS(RestCODS, NewIndex, PartialPieces, Pieces)
	).

% Solution is a list of Piece (where Piece is
% PieceID/PieceQuantity) where the Index position in PieceID is
% CODSLetter
filterPiecesByCODS(Pieces, CODSLetter, Index, Solution) :-
	filterPiecesByCODS(Pieces, CODSLetter, Index, [], Solution).
filterPiecesByCODS([],_,_,S,S).
filterPiecesByCODS([PieceID/PieceN|Rest], CODSLetter, Index, PartialSolution, Solution) :-
	atom_chars(PieceID, PieceIDExploded),
	(   nth0(Index, PieceIDExploded, CODSLetter)
	->  append(PartialSolution, [PieceID/PieceN], NewPartial),
	    filterPiecesByCODS(Rest, CODSLetter, Index, NewPartial, Solution)
	;   filterPiecesByCODS(Rest, CODSLetter, Index, PartialSolution, Solution)
	).

% Given a list of Piece (where a Piece is PieceID/PieceQuantity),
% return the Sum of all PieceQuantity.
getQuantityForPieces(Pieces, Sum) :-
	getQuantityForPieces(Pieces, 0, Sum).
getQuantityForPieces([],S,S).
getQuantityForPieces([_/PieceNumber|Rest], PartialSum, Sum) :-
	NewPartialSum is PartialSum + PieceNumber,
	getQuantityForPieces(Rest, NewPartialSum, Sum).




/*
 * ESERCIZIO 3
 *
 * Si scriva un predicato PROLOG conta(L, MAX) dove L è una lista di
 * elementi interi compresi tra 0 e 9.
 *
 * Considerando tutte le sequenze di due interi presenti nella lista,
 * valutare qual è la sequenza che si ripete più e restituirlo in MAX
 * (come lista).
 *
 * Ogni sequenza è un termine del tipo NUMERO1/NUMERO2/RIPETIZIONI.
 *
 * In caso più sequenze abbiano lo stesso numero massimo di ripetizioni,
 * MAX sarà una lista che le contiene tutte.
 *
 * Se L = [1,2,9,5,1,5,3,3,8,4,3,0,4,2,5,4,1,5,7,1]
 * MAX = [1/5/2]
 *
 * Se L = [1,2,9,5,1,5,3,3,8,4,1,0,4,2,5,4,1,5,7,1]
 * MAX = [4/1/2, 1/5/2]
 *
 */
count(List, Solution) :-
	calcFrequencies(List, Frequencies),
	findMaxFrequencySequence(Frequencies, Solution).


% Find frequencies of all the sequences
calcFrequencies(List, Frequencies) :-
	calcFrequencies(List,[],Frequencies).
calcFrequencies(List,R,R) :-
	length(List,1).
calcFrequencies([First|[Next|Rest]], PartialResult, Result) :-
	findFrequency(First/Next, [First|[Next|Rest]], SequenceFrequency),
	append(PartialResult, [SequenceFrequency], NewPartial),
	calcFrequencies([Next|Rest], NewPartial, Result).

% Find frequency of a sequence
findFrequency(Sequence, List, Solution) :-
	findFrequency(Sequence, List, 0/0/0, Solution).
findFrequency(_,List,S,S) :- length(List,1).
findFrequency(Int1/Int2, [First|[Next|Rest]], _/_/F, Solution) :-
	(   Int1/Int2 = First/Next
	->  NewF is F + 1,
	    NewPartial = Int1/Int2/NewF,
	    findFrequency(Int1/Int2, [Next|Rest], NewPartial, Solution)
	;   findFrequency(Int1/Int2, [Next|Rest], Int1/Int2/F, Solution)
	).

% Find the sequence/s with highest frequency
findMaxFrequencySequence(List, Solution) :-
	findMaxFrequencySequence(List, 0, [], Solution).
findMaxFrequencySequence([],_,S,S).
findMaxFrequencySequence([Int1/Int2/F|Rest], Max, PartialSolution, Solution) :-
	(   F >= Max
	->  NewMax is F,
	    (	F == Max
	    ->	append(PartialSolution, [Int1/Int2/F], NewPartial) % add solution to the others
	    ;	NewPartial = [Int1/Int2/F] % clear old solutions, add only the new
	    ),
	    findMaxFrequencySequence(Rest, NewMax, NewPartial, Solution)
	 ;  findMaxFrequencySequence(Rest, Max, PartialSolution, Solution)
	).
