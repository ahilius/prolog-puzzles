solve(L) :-
	M = [[1,_], [2,_], [3,_], [4,_], [5,_], [6,_]],
	T = [[1,_], [2,_], [3,_], [4,_], [5,_], [6,_]],
	L = [M,T],

	nextto([_,put_on_tie],  [_,put_on_shoes],M),
	nextto([_,put_on_shoes],[_,put_on_tie],  T),

	member([N1,doing_up_cuffs],M),
	even(N1),

	member([N2,doing_up_cuffs],T),
	odd(N2),

	member([N3,open_curtains],M),	
	member([N3,put_on_watch],T),	

	member([N4,comb_hair],M),	
	member([N4,open_curtains],T),	

	member([N5,put_on_tie],M),	
	member([N5,doing_up_cuffs],T),	
	
	nextto([_,comb_hair],[N5,put_on_tie],M),

	member([N6,put_on_watch],M),	
	member([N6,put_on_tie],T),	

	appears_before([_,put_on_watch],[_,comb_hair],M),

	member([_,comb_hair],T).	

appears_before(A,B,[A|Rest]) :-
        member(B,Rest).
appears_before(A,B,[C|Rest]) :-
        appears_before(A,B,Rest).

member(X,[X|_]).
member(X,[_|T]) :-
        member(X,T).

nextto(X,Y,[X,Y|_]).
nextto(X,Y,[_|T]) :- nextto(X,Y,T).

even(N) :-
	0 =:= N mod 2.
odd(N) :-
	1 =:= N mod 2.
