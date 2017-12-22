% 	Square Numbers
% 
% Logic Problems Issue 20 page 22
% 
% The squares below contain the numbers 1 to 9 arranged in random order.
% From the clues given below, can you enter the correct number 
% in each square?
% 
% 
% 	     A	     B        C	
% 	+--------+--------+--------+
% 	|        |        |        |
% 1	|        |        |        |
% 	|        |        |        |
% 	+--------+--------+--------+
% 	|        |        |        |
% 2	|        |        |        |
% 	|        |        |        |
% 	+--------+--------+--------+
% 	|        |        |        |
% 3	|        |        |        |
% 	|        |        |        |
% 	+--------+--------+--------+
%
% Hint: remember that an arthimetic error occurs if the variables are not
%	bound to a value before the operations are attempted.


% Solution to square.puz: 
%    use generate-and-test method. 
%    it is not a terribly efficient solution but in this puzzle 
%    it is a natural one.

square(L) :-

	L = [[1,a,N1], [1,b,N4], [1,c,N7], 
		 [2,a,N2], [2,b,N5], [2,c,N8], 
		 [3,a,N3], [3,b,N6], [3,c,N9]],

	match([1,2,3,4,5,6,7,8,9], L),

% Clues:
% 
% 1    Column A contains no odd digits.

	even(N1),
	even(N2),
	even(N3),

% 2    Square C3 minus square C2 equals 4.

	N9 - N8 =:= 4,

% 3    The three digits in row 1 total 17.

	N1 + N4 + N7 =:= 17,

% 4    Number 7 is in column B; its left-hand neighbour is not 4.

	member([R1,b,7], L),
	member([R1,a,M1], L),
	M1 =\= 4,

% 5    The digits of column C add up to 14.

	N7 + N8 + N9 =:= 14,

% 6    2 is not in the same horizontal row as 8, and 9 is not 
%      immediately below 3.

	member([R2,_,2], L),
	member([R3,_,8], L),
	R2 =\= R3,

	member([R4,C1,9], L),
	R5 is R4 - 1,
	member([R5,C1,M2], L),
	M2 =\= 3.

match([], _).
match([X|T], L) :-
	member([_,_,X], L),
	match(T, L).
		
even(N) :- N mod 2 =:= 0.


