solve(L) :-
	/* make sure the tins are ordered */
	L = [[1,_,_,_],[2,_,_,_],[3,_,_,_],[4,_,_,_],[5,_,_,_]],

	delete([N1,danny,_,_], L, L1),
	member([_,_,_,chicken_curry], L1),
	N1 \== 2,
	N1 \== 3,
	N1 \== 4,

	delete([_,_,_,chicken_curry], L, L2),
	member([_,_,williams,_], L2),

	adjacent([N2,philip,_,_], [_,_,jones,spaghetti], L),
	N2 \== 2,
	N2 \== 4,

	appears_before([_,jenny,_,baked_beans], [_,clive,_,_], L),
	
	member([4,_,_,ravioli],L),

	member([_,kate,roberts,_], L),

	member([1,_,smiths,_], L),

	member([_,_,bloggs,_], L),

	member([_,_,_,tomato_soup], L).

adjacent(X,Y,L) :-
	append(_,[X,Y|_],L).
adjacent(X,Y,L) :-
	append(_,[Y,X|_],L).

appears_before(X,Y,[X|T]) :-
        member(Y,T).
appears_before(X,Y,[_|T]) :-
        appears_before(X,Y,T).
 
member(X,[X|_]).
member(X,[_|T]) :-
        member(X,T).

delete(X,[X|T],T).
delete(X,[H|T],[H|Tail]) :-
	delete(X,T,Tail).

append([],L,L).
append([H|T],L,[H|Tail]) :-
        append(T,L,Tail).

