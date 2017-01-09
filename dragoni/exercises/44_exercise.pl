/*
 * EXERCISE 44
 *
 */

p(pino).
p(pippo).
p(vino).
p(tonno).
p(ceppo).
p(tino).
p(ceppi).
p(parigino).
p(ticino).
p(micino).
p(camicino).
p(gino).
p(cugino).

exercise44 :-
	write('Inserisci la parola:'),
	read(Word),
	find_rime(Word).

find_rime(Word) :-
	atom_chars(Word, CharsWord),
	length(CharsWord, WordLength),
	find_rime(Word, 1, WordLength).

% Cerca parole che facciano rima con Word per Counter lettere. Stop è
% inizializzato alla lunghezza di Word, in modo che al massimo prenda
% parole lunghe come Word.
find_rime(Word, Counter, Stop) :-
	(   Counter =< Stop
	->  write('Rime di n. '), write(Counter), write(' lettere'),nl,
	    setof(DicWord, p(DicWord), Dictionary), %setof così le ordino già qui
	    find_rime1(Dictionary, Word, Counter, Rime),
	    write(Rime), nl, nl,
	    NewCounter is Counter + 1,
	    find_rime(Word, NewCounter, Stop)
	).

% Launcher del predicato find_rime1 e di clear_rime
find_rime1(Dictionary, Word, NumLetters, Rime) :-
	find_rime1(Dictionary, Word, NumLetters, [], AllRime),
	NewNumLetters is NumLetters + 1,
	clear_rime(AllRime, Word, NewNumLetters, [], Rime).

% Trova tutte le parole nel dizionario che fanno rima con Word per
% NumLetters. Il problema è che non prende le parole che fanno rime SOLO
% per quelle lettere come dice il testo. È per questo che dopo viene
% applicato il predicato clear_rime.
find_rime1([],_,_,R,R).
find_rime1([DicWord|Rest], Word, NumLetters, PartialRime, Rime) :-
	(   check_rima(Word, DicWord, NumLetters)
	->  append(PartialRime, [DicWord], NewPartial),
	    find_rime1(Rest, Word, NumLetters, NewPartial, Rime)
	;   find_rime1(Rest, Word, NumLetters, PartialRime, Rime)
	).

% Pulisce l'insieme di rime create dal predicato find_rime1
clear_rime([],_,_,R,R).
clear_rime([Rima|Rest], Word, NumLetters, Partial, Solution) :-
	(   \+ check_rima(Word, Rima, NumLetters)
	->  append(Partial, [Rima], NewPartial),
	    clear_rime(Rest, Word, NumLetters, NewPartial, Solution)
	;   clear_rime(Rest, Word, NumLetters, Partial, Solution)
	).

% Controlla se due parole fanno rima per NumLetters di lettere
check_rima(Word1, Word2, NumLetters) :-
	atom_chars(Word1, Word1Chars),
	atom_chars(Word2, Word2Chars),
	length(Word1Chars, Word1Length),
	length(Word2Chars, Word2Length),
        Index1 is (Word1Length + 1) - NumLetters,
	Index2 is (Word2Length + 1) - NumLetters,
	word_substring(Word1, Index1, Substring1),
	word_substring(Word2, Index2, Substring2),
	Substring1 == Substring2.


% Prende una sottostringa di Word a partire dalla posizione
% StartPosition
word_substring(Word, StartPosition, Substring) :-
	atom_chars(Word, CharsWord),
	length(CharsWord, Length),
	word_substring(CharsWord, StartPosition, Length, [], CharsSubstring),
	atom_chars(Substring, CharsSubstring).

word_substring(CharsWord, StartPosition, EndPosition, PartialSubstring, Substring) :-
	(   StartPosition =< EndPosition
	->  nth1(StartPosition, CharsWord, Letter),
	    append(PartialSubstring, [Letter], NewPartial),
	    NewStart is StartPosition + 1,
	    word_substring(CharsWord, NewStart, EndPosition, NewPartial, Substring)
	;   Substring = PartialSubstring
	).


