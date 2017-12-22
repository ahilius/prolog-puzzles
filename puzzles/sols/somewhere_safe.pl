
%             S O M E W H E R E   S A F E
%             ___________________________
%
% Logic Problems Issue 16 page 21
%
% The diagram represents a typical all-pupose chest of drwaers filled with
% a variety of small household objects. From the clues given below, can you
% work out in which drawer each of the items is?
%
%  +----------------------------------------------------+
%  |                                                    |
%  |  +-------------------+     +-------------------+   |
%  |  |        [1]        |     |        [4]        |   |
%  |  +-------------------+     +-------------------+   |
%  |                                                    |
%  |  +-------------------+     +-------------------+   |
%  |  |        [2]        |     |        [5]        |   |
%  |  +-------------------+     +-------------------+   |
%  |                                                    |
%  |  +-------------------+     +-------------------+   |
%  |  |        [3]        |     |        [6]        |   |
%  |  +-------------------+     +-------------------+   |
%  |                                                    |
%  +----------------------------------------------------+
%
% Clues:

solve(L) :-
    L = [[[1, _], [2, _], [3, _]], [[4, _], [5, _], [6, _]]],

% 1. The stationery is in a left-hand drawer.

    L = [LD, RD],
    member([_, stationery], LD),

% 2. The playing-cards are immediately above the table-mats.

    member(L1, L),
    nextto([_, playing_cards], [_, table_mats], L1),

% 3. The fish knives are in an odd-numbered drawer and the pins and needles
%    are immediately below them.

    member(L2, L),
    nextto([N1, fish_knives], [_, pins_needles], L2),
    N1 mod 2 =:= 1,

% 4. The photos are not in a top drawer.

    LD = [_|LDR],
    RD = [_|RDR],

    member(L3, [LDR, RDR]),
    member([_,photos], L3).

nextto(X, Y, [X, Y|_]).
nextto(X, Y, [_|R]) :-
    nextto(X, Y, R).
