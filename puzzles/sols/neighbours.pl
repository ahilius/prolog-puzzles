%		N E I G H B O U R S
%		___________________
%
% 
%Logic Problems Issue 24 page 23
%
%Six couples live in houses situated in the same street. From the clues given
%below, can you work out the names of the pair who occupy each house and allocate
%the correct house number to each dwelling. The houses are numbered in the normal
%way in an uninterrupted sequence of six numbers (15..20), with the odd numbers
%on one side of the road and even numbers on the other side. You have to discover
%from which direction the numbering runs, and which side of the road has the odd
%numbers and which side, the even.
%
%
%                A               B               C
%           |---------|     |---------|     |---------|
% Husband:  |         |     |         |     |         |
% Wife:     |         |     |         |     |         |
% House No. |         |     |         |     |         |
%           |---------|     |---------|     |---------|
%
%        _________________________________________________
%
%
%                       S T R E E T
%
%        _________________________________________________
%
%               D                E               F
%           |---------|     |---------|     |---------|
% Husband:  |         |     |         |     |         |
% Wife:     |         |     |         |     |         |
% House No. |         |     |         |     |         |
%           |---------|     |---------|     |---------|

solve(L) :-
	N = [[a,_,_,_], [b,_,_,_], [c,_,_,_]],
	S = [[d,_,_,_], [e,_,_,_], [f,_,_,_]],

	append(N,S,L),
	order(Nlist),
	fit([N,S],Nlist),

%Clues:
%1. Eric and Sadie have John as a neighbour on one side and Patricia on the other.

	member(X1, [N,S]),
	adjacent([_,eric,sadie,_], [_,john,W1,_], X1),
	adjacent([_,eric,sadie,_], [_,H1,patricia,_], X1),
	W1 \== patricia,
	H1 \== john,

%
%2. Judith, who lives opposite to Eileen, does not live in a house designated by
%   a wovel on the plan; Eileen's house number is higher than that of Judith.

	opposite([D1,_,judith,N1],[_,_,eileen,N2], [N,S]),
	D1 \== a,
	D1 \== e,
	N1 < N2,

%
%3. Pam's house is lettered E on the plan; her husband is not Alec.

	member([_,alec,_,_], L),
	member([e,H2,pam,_], S),
	H2 \== alec,

%
%4. The house lettered F belongs to Oliver and his wife.

	member([f,oliver,_,_], S),

%
%5. Sandra's house, which is no. 15, is not lettered D on the plan.

	member([D2,_,sandra,15],L),
	D2 \== d,

%6. Jim lives at the house with the lowest of the even numbers.
%

	member([_,jim,_,N3], L),
	min_even(N3),

%
%7. Richard is one of the husbands.

	member([_,richard,_,_], L).

adjacent(X,Y,L) :-
        append(_,[X,Y|_],L).
adjacent(X,Y,L) :-
        append(_,[Y,X|_],L).
 
opposite(X,Y,[[X|_],[Y|_]]).
opposite(X,Y,[[Y|_],[X|_]]).
opposite(X,Y,[[_|T1],[_|T2]]) :-
	opposite(X,Y,[T1,T2]).

min_even(16).

order(L) :- numbers(L).
order(R) :- numbers(L), reverse(L, R).

numbers([15,16,17,18,19,20]).
numbers([16,15,18,17,20,19]).

fit(_,[]).
fit([[[_,_,_,D1]|T1], [[_,_,_,D2]|T2]],[D1,D2|T]) :-
	fit([T1,T2],T).
