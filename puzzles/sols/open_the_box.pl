%    LEFT                 +--------------+              RIGHT
%                         |              |
%                         | 1 ---------- |
%                         +--------------+
%                +--------------+ +--------------+
%                |              | |              |
%                | 2 ---------- | | 3 ---------- |
%                +--------------+ +--------------+
%       +--------------+ +--------------+ +--------------+
%       |              | |              | |              |
%       | 4 ---------- | | 5 ---------- | | 6 ---------- |
%       +--------------+ +--------------+ +--------------+

% Six contestants in a television quiz show each won the key to a box containing a prize. From the clues given below, can you work out which contestant won the key to which box, and what prize was featured on the card contained in it?% The boxes formed a pyramid as shown in the diagram.

% 1. Tony's prize, which was not one of the two booby-prizes, was in a box in the row above the hamper.

% 2. The toilet-roll was in the box to the left of the one to which Ethel won the key.

% 3. Avril's prize was the washing-machine; it was in the box to the right of the one containing the holiday.

% 4. Hugh was given the key to box 6, which did not contain the bedroom suite.


% 5. The feather-duster was in box 1, the key to which was not won by Muriel.


% Contestants: avril, ethel, hugh, muriel, nick, tony
% Prizes: bedroom_suite, feather_duster, hamper, holiday, toilet_roll, washing_machine

solve(S):-
	S = [[1,_,_],[ 2,_,_],[3,_,_],[4,_,_],[5,_,_],[6,_,_]],
	member([B1,tony,P1],S), %1
	P1\=feather_duster,
	P1\=toilet_roll,

	member([A1,_,toilet_roll],S), %2
	member([B1,ethel,P1],S),

	member([A1,avril,washing_machine],S), %3


	member([6,hugh,C1],S), %4
	C1\=bedroom_suite,

	member([1,B1,feather_duster],S), %5
	B1\=muriel,
	S.
