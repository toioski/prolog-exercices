% Consideriamo la seguente conoscenza e cerchiamo di rappresentarla:
% "La lezione di IA viene tenuta dalle ore 15:30 alle ore 17:30 da
% Aldo Dragoni a Quota 155 aula D2"

% lezione(ia, merc, 1530, 1730, 155, d2, afdragoni).

% Quella sopra è una possibile interpretazione, ma non ci permette di
% fare grandi manipolazioni/inferenze perchè è tutto messo insieme.
% Conviene spacchettizzare il più possibile:
%  - un atomo per la materia
%  - una struttura (simbolo di funzione) per l'orario
%  - una struttura per l'aula
%  - un atomo per il docente

lezione(ia, orario(merc, 1530, 1730), luogo(155, d2), afdragoni).

% Scrivere un programma docente(Docente, Corso)
docente(Docente, Corso) :- lezione(Corso,_,_,Docente).

% Scrivere un programma durata(Insegnamento, Durata)
% durata(Insegnamento, Durata) :- lezione(Insegnamento, orario(_, Inizio,
% Fine),_,_,_), Durata is Fine - Inizio.


%--OPERATORI--
%
% "Aldo suona chitarra e tastiera"
% Bisogna definire gli operatori "suona" e "e"

% Operatore non associativo
:- op(400, xfx, 'suona').
% Operatore associativo a destra
:- op(300, xfy, 'e').

aldo suona chitarra e tastiera.
ugo suona chitarra e basso e tastiera.

