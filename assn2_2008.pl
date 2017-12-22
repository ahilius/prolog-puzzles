% Question 2
% a)
 bagify([], []).

 bagify(L, B):-
           L=[H|T],
           bagify(T,B1),
           not(member([H,_], B1)),
           B2 = [[H,1]|B1],
           sort(B2, B).

 bagify(L, B):-
           L=[H|T],
           bagify(T,B1),
           member([H,V], B1),
           delete(B1, [H,V], B2),
           V1 is V + 1,
           B3 = [[H,V1]|B2],
           sort(B3, B).

%% ?- bagify([b,a,c,b,b,b], B).
%% B = [[a, 1], [b, 4], [c, 1]] .

%% ?- bagify([c,c,c,a], B).
%% B = [[a, 1], [c, 3]] .

%% ?- bagify([a], B).
%% B = [[a, 1]] .

%% ?- bagify([], B).
%% B = [] .

% b)
get_lower(A, B, C):-
             A =< B,
             C = A.

get_lower(A, B, C):-
             A > B,
             C = B.

bag_intersection([],_,[]).

bag_intersection(B1, B2, B):-
                     B1 = [H|T],
                     bag_intersection(T, B2, G),
                     H = [K, V],
                     member([K, V2], B2),
                     get_lower(V, V2, V3),
                     B = [[K, V3]| G].

bag_intersection(B1, B2, B):-
                     B1 = [H|T],
                     bag_intersection(T, B2, B),
                     H = [K, _],
                     not(member([K, _], B2)).

%% ?- bag_intersection([[a,3], [b,1], [c,1]], [[a,2], [c,2]], B).
%% B = [[a, 2], [c, 1]] .

%% ?- bag_intersection([[a,3], [b,1], [c,1]], [[g,2], [h,2]], B).
%% B = [] .

%% ?- bag_intersection([[a,3]], [[a,2]], B).
%% B = [[a, 2]] .

%% ?- bag_intersection([[a,1]],[], B).
%% B = [] .

%% ?- bag_intersection([],[[a,1]], B).
%% B = [] .

%% ?- bag_intersection([],[], B).
%% B = [] .

% c)
listify_single([_,0], []).

listify_single(S, L):-
              S = [H,T],
              T =\= 0,
              T2 is T - 1,
              listify_single([H,T2], L2),
              append([H], L2, L).

listify([], []).

listify(B, L):-
                  B = [H|T],
                  listify(T, L2),
                  listify_single(H, A),
                  append(A, L2, L).

bag_union(B1, B2, B):-
              append(B1, B2, A),
              listify(A, L),
              bagify(L, B).

%% ?- bag_union([[a,3], [b,1], [c,1]], [[a,2], [c,2]], B).
%% B = [[a, 5], [b, 1], [c, 3]] .

%% ?- bag_union([[a,0], [b,1], [c,1]], [[a,2], [c,2], [d,5]], B).
%% B = [[a, 2], [b, 1], [c, 3], [d, 5]] .

%% ?- bag_union([[b,1], [c,1]], [], B).
%% B = [[b, 1], [c, 1]] .

%% ?- bag_union([],[[b,1], [c,1]],  B).
%% B = [[b, 1], [c, 1]] .

%% ?- bag_union([],[],  B).
%% B = [] .


% d)
bag_difference([], _, []).

bag_difference(B1, B2, B):-
                   B1 = [H|T],
                   bag_difference(T, B2, P),
                   H = [K,V],
                   member([K,V2], B2),
                   V < V2,
                   B = P.

bag_difference(B1, B2, B):-
                   B1 = [H|T],
                   bag_difference(T, B2, P),
                   H = [K,V],
                   member([K,V2], B2),
                   V > V2,
                   V3 is V - V2,
                   B = [[K,V3]|P].

bag_difference(B1, B2, B):-
                   B1 = [H|T],
                   bag_difference(T, B2, P),
                   H = [K,_],
                   not(member([K,_], B2)),
                   B = [H|P].

%% ?- bag_difference([[a,3], [b,1], [c,1]], [[a,2], [c,2]], B).
%% B = [[a, 1], [b, 1]] .

%% ?- bag_difference([[a,3]], [[c,2]], B).
%% B = [[a, 3]] .

%% ?- bag_difference([[a,3]], [[a,2]], B).
%% B = [[a, 1]] .

%% ?- bag_difference([[a,3]], [], B).
%% B = [[a, 3]] .

%% ?- bag_difference([], [[a,3]], B).
%% B = [] .

%% ?- bag_difference([], [], B).
%% B = [] .



% Question 3
% Strategy:
% i.   Create a skeleton list S, to represent the 12 boxes.

% ii.  Declare all the terms to go in the boxes as members of S.

% iii. Put variables in the spots next to those terms when there is
%      information about them.

% iv.  Run calculations/checks on each of those variables.

% v.   For hint 10, I just counted the number of male/females
%      and made sure it was the right number.

% v.   Create predicates for commonly used checks on the variables.

% vi.  For some of the hints they weren't very clear on exactly what
%      they meant, so at first I left them vague.

%      But later I made them more exact to reduce, the number of results. It
%      turned out that although interpreted correctly, many of them were
%      unnecessary in solving the problem.

%      I added comments with the wording of the hints that I was unsure of
%      next to those checks.


%                      STAR CHART

% Logic Problems, Issue 24, page 16.

% As part of the astrological forecasting system, Susie (who lives in England)
% drew a chart illustrating the twelve signs of the zodiac in random order in
% three rows of four, as shown in the diagram. Incorporated in the design was
% a self-portrait and the portraits of eleven of her friends, each in the
% section appropriate to his or her birth sign. From the clues given below,
% insert the correct sign of the zodiac and name in each of the numbered
% squares in the diagram.

col(A, B):-
          B is A mod 4,
          B =\= 0,
          !.

col(_, 4).

row(A, B):-
       C is A - 1,
       D is C // 4,
       B is D + 1.

same_row(A, B):-
            row(A, A1),
            row(B, B1),
            A1 =:= B1.

same_col(A, B):-
            col(A, A1),
            col(B, B1),
            A1 =:= B1.

below(A, B, C):-
            row(A, A1),
            row(B, B1),
            A1 > B1,
            C is A1 - B1.

above(A, B, C):-
         below(B, A, C).

even(A):-
         B is A mod 2,
         B =:= 0.

left(A, B, C):-
           col(A, A1),
           col(B, B1),
           A1 < B1,
           C is B1 - A1.

male_female(P, M, F):-
               male(P),
               M is 1,
               F is 0.

male_female(P, M, F):-
               female(P),
               M is 0,
               F is 1.

count_genders(P1, P2, P3, P4, M, F):-
                  male_female(P1, M1, F1),
                  male_female(P2, M2, F2),
                  male_female(P3, M3, F3),
                  male_female(P4, M4, F4),
                  M is M1 + M2 + M3 + M4,
                  F is F1 + F2 + F3 + F4,
                  !.

solve(S):-
          S = [[1, _, _], [ 2, _, _], [ 3, _, _], [ 4, _, _],
               [5, _, _], [ 6, _, _], [ 7, _, _], [ 8, _, _],
               [9, _, _], [10, _, _], [11, _, _], [12, _, _]],

% 1. Carrie's portrait is horizontally between the Libra and Scorpio designs,
%    the latter of which is not in square 5.
          member([A1, carrie, _], S),
          member([A2, _, libra], S),
          member([A3, _, scorpio], S),

          col(A1, A1C),
          col(A2, A2C),
          col(A3, A3C),
          A1C > A2C,
          A1C < A3C,
          same_row(A1, A2),
          same_row(A2, A3),

          A3 =\= 5,

% 2. The portrait of Fay, who was born under Aquarius, is an even-numbered
%    square in the same vertical column as, and immediately below, the Leo
%    design.
          member([B1, fay, aquarius], S),
          member([B2, _, leo], S),

          even(B1),

          same_col(B1, B2),

          below(B1, B2, 1),

% 3. Mandy, who was born under a summer sign, as was Philip, has her portrait
%    in one of the corner squares
          member([C1, mandy, C2], S),
          member([_, philip, C3], S),

          summersign(C2),
          summersign(C3),

          cornersquare(C1),

% 4. Adam's portrait is immediately above Alan's which is just to the left
%    of the Taurus design, which incorporates a man's portrait.
          member([D1, adam, _], S),
          member([D2, alan, _], S),
          member([D3, D4, taurus], S),

          above(D1, D2, 1),
          same_col(D1, D2), %immediately?

          left(D2, D3, 1),
          same_row(D2, D3), %just left?

          male(D4),

% 5. The design of Pamela, who is not an Aries, is in square 10.
          member([10, pamela, _], S),
          member([E1, _, aries], S),

          E1 =\= 10,

% 6. The Sagittarian's portrait is two squares to the left of Joy's, in the
%    same row.
          member([F1, _, sagittarius], S),
          member([F2, joy, _], S),

          left(F1, F2, 2),
          same_row(F1, F2),

% 7. Square 2 depicts the Gemini design, also on the top
%    row are both Joy's and Susie's portraits.
          member([2, _, gemini], S),
          member([G1, susie, _], S),

          row(F2, 1),
          row(G1, 1),

% 8. Roy's portrait is in the row below Neil's (which is not in the same row
%    as Tony's) and somewhere to his left.
          member([H1, roy, _], S),
          member([H2, neil, _], S),
          member([H3, tony, _], S),

          below(H1, H2, 1), %row below

          not(same_row(H2, H3)),

          left(H1, H2, _),

% 9. The Virgo design is in the square immediately to the left of Tony's
%    portrait and in the same vertical column as the Capricorn design.
          member([I1, _, virgo], S),
          member([I2, _, capricorn], S),

          left(I1, H3, 1),
          same_row(I1, H3), %immediately?

          same_col(I1, I2),

% 10. Two women and two men are featured in each of the horizontal rows.
          member([1, J11, _], S),
          member([2, J12, _], S),
          member([3, J13, _], S),
          member([4, J14, _], S),
          count_genders(J11, J12, J13, J14, 2, 2),

          member([5, J21, _], S),
          member([6, J22, _], S),
          member([7, J23, _], S),
          member([8, J24, _], S),
          count_genders(J21, J22, J23, J24, 2, 2),

          member([9, J31, _], S),
          member([10, J32, _], S),
          member([11, J33, _], S),
          member([12, J34, _], S),
          count_genders(J31, J32, J33, J34, 2, 2),

% 11. The other two star signs are Cancer and Pisces
          member([_,_,cancer], S),
          member([_,_,pisces], S).

% Names: Adam, Alan, Carrie, Fay, Joy, Mandy,
%        Neil, Pamela, Philip, Roy, Susie, Tony.
% Spring signs: Aries, Taurus, Gemini.
% Summer signs: Cancer, Virgo, Leo
% Autumn signs: Libra, Scorpio, Sagittarius
% Winter signs: Capricorn, Aquarius, Pisces

%                   TOP
%                   +-------------------+
%                   |  1 |  2 |  3 |  4 |
%                   |----|----|----|----|
%                   |  5 |  6 |  7 |  8 |
%                   |----|----|----|----|
%                   |  9 | 10 | 11 | 12 |
%                   +-------------------+
%                   BOTTOM

%
male(adam).
male(alan).
male(neil).
male(philip).
male(roy).
male(tony).
%
female(carrie).
female(fay).
female(joy).
female(mandy).
female(pamela).
female(susie).
%
springsign(aries).
springsign(taurus).
springsign(gemini).
%
summersign(cancer).
summersign(leo).
summersign(virgo).
%
autumnsign(libra).
autumnsign(scorpio).
autumnsign(sagittarius).
%
wintersign(capricorn).
wintersign(aquarius).
wintersign(pisces).
%
cornersquare(1).
cornersquare(4).
cornersquare(9).
cornersquare(12).

%% ?- solve(S).
%% S = [[1, susie, sagittarius], [2, neil, gemini], [3, joy, capricorn], [4, philip, leo], [5, roy, libra], [6, carrie, aries], [7, adam, scorpio], [8, fay, aquarius], [9, mandy, cancer], [10, pamela, pisces], [11, alan, virgo], [12, tony, taurus]] .
