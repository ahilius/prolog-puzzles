%               C A G E W O R K
%               _______________
%
% Logic Problems Issue 10 page 44
%
%There are nine cages in the local zoo, in the positions shown below. From the
%clues given below, can you state which animal is in which cage? Throughout
%the clues, east means due east, north-west means due north-west etc.
%
%Clues:
%1. The lion is north of the bear, but south of the hippopotamus.
%2. The ape is west of the tiger.
%3. The giraffe is immediately south-east of the camel.
%4. The rhinoceros is east of the lion.
%5. The elephant is immediately south-west of the rhinoceros.
%
%----------     ----------      -----------
%|        |     |        |      |         |
%|    1   |     |    2   |      |    3    |
%|        |     |        |      |         |
%----------     ----------      -----------
%
%----------     ----------      -----------
%|        |     |        |      |         |
%|    4   |     |    5   |      |    6    |
%|        |     |        |      |         |
%----------     ----------      -----------
%
%----------     ----------      -----------
%|        |     |        |      |         |
%|    7   |     |    8   |      |    9    |
%|        |     |        |      |         |
%----------     ----------      -----------

solve(L) :-
	/* use the cage numbers */
	L = [[[1,_],[2,_],[3,_]],[[4,_],[5,_],[6,_]],[[7,_],[8,_],[9,_]]],

/* Clue 1 */
	
	columns(C, L),

	appears_before([_,lion],[_,bear],C),
	appears_before([_,hippo],[_,lion], C),	

/* Clue 2 */

	member(R1,L),
	appears_before([_,ape],[_,tiger],R1),

/* Clue 3 */

	nextto([C1,C2,_],[_,C5,C6],L),
	member([[_,camel],[_,giraffe]],[[C1,C5],[C2,C6]]),

/* Clue 4 */

	member(R2,L),
	appears_before([_,lion],[_,rhino],R2),

/* Clue 5 */
	
	nextto([_,C8,C9],[C10,C11,_],L),
	member([[_,rhino],[_,elephant]],[[C8,C10],[C9,C11]]).

columns([C1,C4,C7],[[C1,_,_],[C4,_,_],[C7,_,_]]).
columns([C2,C5,C8],[[_,C2,_],[_,C5,_],[_,C8,_]]).
columns([C3,C6,C9],[[_,_,C3],[_,_,C6],[_,_,C9]]).

appears_before(A,B,[A|Rest]) :-
        member(B,Rest).
appears_before(A,B,[_|Rest]) :-
        appears_before(A,B,Rest).

nextto(A,B,[A,B|_]).
nextto(A,B,[_|Rest]) :-
        nextto(A,B,Rest).

