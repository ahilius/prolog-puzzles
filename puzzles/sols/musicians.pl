% Prolog program for the musicians problem: version2
%-----------------------------------------------------
% consult this program and enter the following query:
%   ?- solve(B).
%-----------------------------------------------------
solve(B) :-
   B = band(soloist(_,_,_), soloist(_,_,_), soloist(_,_,_)),

   first_member(soloist(_,_,piano), B),

   order_members(soloist(john,_,sax), soloist(_,australia,_),B),
   order_members(soloist(mark,us,_), soloist(_,_,violin),B),

band_member(soloist(_,japan,_), B),
band_member(soloist(sam,_,_), B).

first_member(X,band(X,_,_)).     % X is the first one

order_members(X,Y,band(X,Y,_)).  % X plays before Y
order_members(X,Z,band(X,_,Z)).  % X plays before Z
order_members(Y,Z,band(_,Y,Z)).  % Y plays before Z

band_member(X,band(X,_,_)).      % X is a member
band_member(Y,band(_,Y,_)).      % Y is a member
band_member(Z,band(_,_,Z)).      % Z is a member

