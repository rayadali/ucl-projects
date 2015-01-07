/* Rayad Ali Theory 1 Coursework */

/* Q1 */

%member(Item, List) succeeds if Item is a member of List.
member(X, [X|_]). %base case
member(X, [_|Tail]) :- %recursive case
member(X, Tail).


/* Q2 */

%conc (A,B,C) concats lists A and B to make C
conc([], L, L). %base case

conc([Item | Tail1], L, [Item | Tail2]) :- %recursive case
	      conc(Tail1, L, Tail2).



/* Q3 */

%built in already

/* Q4 */

%facts for the bool predicate.
boolean(1).
boolean(0).
%bool(X) retures true is X is 1 or 0
bool(X) :-
	boolean(X),
	boolean(1);
	boolean(0).


/* Q5 */

%true for valid binary connectives
bin(v).
bin(a).
bin(i).

/* Q6 */

%true for valid proppositions
prop(p).
prop(q).
prop(x).
prop(y).
prop(z).

/* Q7 */

% true if argument is a valid formula
form(X):-					
	prop(X).				%base case

form(X):-					%negated forumulas
	atom_chars(X, [n|T]),	%convert to list starting with negation
	atom_chars(Y, T),		%convert list T back to character sequence
	form(Y).				%recursion

form(S):-					%binary connective case
	bin(B),					%either v or a or i
	atom_chars(S,L),		%convert to list
	conc([l|F],[B|T],L),	%list starts with left bracket, etc
	conc(G,[r],T),			%ends with right bracket
	atom_chars(Fm1,F),		%convert back
	atom_chars(Fm2,G),		%convert back
	form(Fm1),				%recursion1
	form(Fm2).				%recursion2
	

/* Q8 */

%identifying what type of formula
type(p,p).
type(q,p).
type(x,p).
type(y,p).
type(z,p).
type(F,n):-
		atom_chars(F,[n|X]),
		atom_chars(G,X),
		form(G).
type(F,B):-
		atom_chars(F,L),
		bin(B),
		conc([l|F1],[B|X],L),
		conc(F2,[r],X),
		atom_chars(G,F1),
		atom_chars(H,F2),
		form(G),
		form(H).
		
/* Q9 */

%puts an n at the start
negate(F,G):-
		atom_chars(F,L),
		atom_chars(G,[n|L]),
		write(L).
%removes an n from the start
remove_neg(F,G):-
		type(F,n),
		atom_chars(F,[n|L]),
		atom_chars(G,L),
		write(L).
		
/* Q10 */
	
subs(S,F,G):-
	bin(B), % either v or a or i
	atom_chars(S,L), % convert to a list
	conc([l|A1],[B|T],L), % list starts with left bracket, etc
	conc(A2,[r],T), % ends with rt bracket
	atom_chars(F,A1), % convert back
	atom_chars(G,A2). % convert back


/* Q11 */

lit(X):-
	type(X,p);
	type(X,n).
	
/* Q12 */

lits(L):-
	L=[]. %base case
lits(L):-
	L =[H|T],
	lit(H),
	lits(T).
	
	
/* Q13 */

closed(Lits):-
	Lits =[H|T],
	type(H,p),
	member(H,Lits),
	negate(H,G),
	member(G,Lits),
	closed(T).
	
closed(Lits):-
	Lits =[H|T],
	type(H,n),
	member(H,Lits),
	remove_neg(H,G),
	member(G,Lits),
	closed(T).
	
	
/* Q14 */

closed_lits(LLits):-
	LLits=[].
closed_lits(LLits):-
	LLits=[H|T],
	closed(H),
	closed_lits(T).
	
/* Q15 */

tableau([]).	%null tableau
tableau([F,Lits,Ticked,Left,Right]):-
	form(F),
	lits(Lits),
	bool(Ticked),
	tableau(Left),	%recursion
	tableau(Right),	%recursion
	
/* Q16 */
tick(T1,T2):-
	tableau(T1)==tableau(T2),
	tableau(T2),bool(Ticked).

/* Q17 */
done(T):-
	tableau(T),
	tableau([_,_,1,_,_]).
	
/* Q18 */
left(T,Lt):-
	not(T=[]),
	tableau(T),
	T=[_,_,_,Lt,_].
	
right(T,Rt):-
	not(T=[]),
	tableau(T),
	T=[_,_,_,_,Rt].

/* Q19 */
root([H|T],F):-
	not(T=[]),
	H==F.

/* Q20 */

init_tree(F, Ls, T):-
	lit(F),
	T = [F, Literals, _, [], []],
	root(Literals, F),
	Ls == Literals.

init_tree(F, Ls, T):-
	not(lit(F)),
	T = [F, Literals, _, [], []],
	Ls == Literals.

/* Q21 */
%null tableau is complete
leaves(T,Leaves):-
	T=[].
	
%tableau where root is a leaf is complete
leaves(T,Leaves):-
	T=[F,Lits,B,[],[]],
	Leaves==Lits.
	
%recursion of left subtree
leaves(T,Leaves):-
	T=[F,Lits,B,[H|T],Rt],
	leaves([H|T],Leaves).

/* Q22 */

closed_tab( T):-
	leaves(T, Leaves),
	closed_list(Leaves).

/* Q23 */

addone(_,[],[]).

addone(F,[Form,L,B,[],[]],[Form,L,B,T2,[]]):-
	init_tree(F,L,T2).
	
addone(F,[Form,L,B,Lt1,Rt1],[Form,L,B,Lt2,Rt2]):-
	addone(F,Lt1,Lt2),
	addone(F,Rt1,Rt2).

/* Q24 */


/* Q25 */


/* Q26 */


/* Q27 */