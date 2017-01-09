/*
 * EXERCISE 39
 *
 */
exercise39(ListOfWords, Result) :-
	process_words(ListOfWords, Result).

process_words(ListOfWords, Result) :-
	process_words(ListOfWords, [], Result).
process_words([],R,R).
process_words([Word|Words], PartialResult, Result) :-
	atom_chars(Word, CharWord),
	(   has_same_start_end(CharWord)
	->  append(PartialResult, [Word], NewPartialResult),
	    process_words(Words, NewPartialResult, Result)
	;   process_words(Words, PartialResult, Result)
	).

has_same_start_end(Word) :-
	length(Word, Length),
	nth1(1, Word, FirstLetter),
	nth1(Length, Word, LastLetter),
	FirstLetter =  LastLetter.
