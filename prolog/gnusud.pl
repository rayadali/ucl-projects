%TO convert to gnuprolog remove the following two lines.
%then search and replace all_different to fd_all_different

%It should all work.

%I got bored so I coded up a Su Doku solver in prolog using constraints.
%It took less than 30 minutes (mainly because I don't type that fast).
%Searching  on the net people have produced 1.2mb visual basic monsters
%or Apple apps that took 8 hours to code.
%Constraint programming is fast and powerful. Of course there are no bells
%or whistles in this code.

%Look at test1,test2 and see how they are run.
%This is the sicstus version.

test1 :-
	L = [
	     [_,6,_,1,_,4,_,5,_],
	     [_,_,8,3,_,5,6,_,_],
	     [2,_,_,_,_,_,_,_,1],
	     [8,_,_,4,_,7,_,_,6],
	     [_,_,6,_,_,_,3,_,_],
	     [7,_,_,9,_,1,_,_,4],
	     [5,_,_,_,_,_,_,_,2],
	     [_,_,7,2,_,6,9,_,_],
	     [_,4,_,5,_,8,_,7,_]],
	sudoku(L),
	pretty_print(L).

%Fiendish puzzel April 21,2005 Times London
test2 :-
	L = [
	     [_,_,4 ,_,_,3, _,7,_],
	     [_,8,_ ,_,7,_, _,_,_],
	     [_,7,_ ,_,_,8, 2,_,5],
	     [4,_,_ ,_,_,_, 3,1,_],
	     [9,_,_ ,_,_,_, _,_,8],
	     [_,1,5 ,_,_,_, _,_,4],
	     [1,_,6 ,9,_,_, _,3,_],
	     [_,_,_ ,_,2,_, _,6,_],
	     [_,2,_ ,4,_,_, 5,_,_]],
	sudoku(L),
	pretty_print(L).
	

test3 :-
%This is supposed to be hard.
	L=
	[
	 [_,4,3,_,8,_,2,5,_],
	 [6,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,1,_,9,4],
	 [9,_,_,_,_,4,_,7,_],
	 [_,_,_,6,_,8,_,_,_],
	 [_,1,_,2,_,_,_,_,3],
	 [8,2,_,5,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,5],
	 [_,3,4,_,9,_,7,1,_]
	],
	sudoku(L),
	pretty_print(L).

test4 :-
	%Diaboloical puzzel 104 Sunday Torygraph.
	L=
	[
	 [8,_,3,_,2,9,7,1,6],
	 [_,_,6,_,1,8,5,_,4],
	 [_,_,_,_,6,_,_,_,8],
	 [_,_,5,_,4,6,_,8,_],
	 [7,_,9,_,3,5,6,4,2],
	 [_,6,_,_,9,_,1,_,5],
	 [6,_,_,_,7,_,_,5,1],
	 [_,_,1,6,5,_,8,_,_],
	 [5,_,_,9,8,1,4,6,3]
	 ],
	sudoku(L),
	pretty_print(L).

test5 :-
	%An easy sudoku from the web.
	L=[
	   [_,_,_,1,5,_,_,7,_],
	   [1,_,6,_,_,_,8,2,_],
	   [3,_,_,8,6,_,_,4,_],
	   [9,_,_,4,_,_,5,6,7],
	   [_,_,4,7,_,8,3,_,_],
	   [7,3,2,_,_,6,_,_,4],
	   [_,4,_,_,8,1,_,_,9],
	   [_,1,7,_,_,_,2,_,8],
	   [_,5,_,_,3,7,_,_,_]
	   ],
	sudoku(L),
	pretty_print(L).
 
%Expects a list of lists 9 by 9 grid.
sudoku(L) :-
	flatten(L,AllVars),
	fd_domain(AllVars,1,9),
	[R1,R2,R3,R4,R5,R6,R7,R8,R9] = L,
%Each row is different.
	fd_all_different(R1), fd_all_different(R2), fd_all_different(R3),
	fd_all_different(R4), fd_all_different(R5), fd_all_different(R6),
	fd_all_different(R7), fd_all_different(R8), fd_all_different(R9),
	transpose(L,TL),
%Each column is different.
	[C1,C2,C3,C4,C5,C6,C7,C8,C9] = TL,
	fd_all_different(C1), fd_all_different(C2), fd_all_different(C3),
	fd_all_different(C4), fd_all_different(C5), fd_all_different(C6),
	fd_all_different(C7), fd_all_different(C8), fd_all_different(C9),
%Need to put the code in to do each 3x3 square all different.
%There is a much more elegant way of coding this. But for
%illustrative purposes it is fine.
	[X11,X12,X13,X14,X15,X16,X17,X18,X19] = R1,
	[X21,X22,X23,X24,X25,X26,X27,X28,X29] = R2,
	[X31,X32,X33,X34,X35,X36,X37,X38,X39] = R3,
	[X41,X42,X43,X44,X45,X46,X47,X48,X49] = R4,
	[X51,X52,X53,X54,X55,X56,X57,X58,X59] = R5,
	[X61,X62,X63,X64,X65,X66,X67,X68,X69] = R6,
	[X71,X72,X73,X74,X75,X76,X77,X78,X79] = R7,
	[X81,X82,X83,X84,X85,X86,X87,X88,X89] = R8,
	[X91,X92,X93,X94,X95,X96,X97,X98,X99] = R9,
	
	fd_all_different([X11,X12,X13,X21,X22,X23,X31,X32,X33]),
	fd_all_different([X41,X42,X43,X51,X52,X53,X61,X62,X63]),
	fd_all_different([X71,X72,X73,X81,X82,X83,X91,X92,X93]),

	fd_all_different([X14,X15,X16,X24,X25,X26,X34,X35,X36]),
	fd_all_different([X44,X45,X46,X54,X55,X56,X64,X65,X66]),
	fd_all_different([X74,X75,X76,X84,X85,X86,X94,X95,X96]),

	fd_all_different([X17,X18,X19,X27,X28,X29,X37,X38,X39]),
	fd_all_different([X47,X48,X49,X57,X58,X59,X67,X68,X69]),
	fd_all_different([X77,X78,X79,X87,X88,X89,X97,X98,X99]),

		
	labeling([ffc],AllVars).


flatten([],[]).
flatten([H|T],Vars) :-
	flatten(T,TVars),
	append(H,TVars,Vars).

	
/* Transpose a list of lists. */
/* This is modfied from code by Naoyuki Tamura (tamura@kobe-u.ac.jp) *.
/* Used without permisson. */

transpose([Word], Cs) :- !,
/*	reverse(Word, R), */
	R = Word,
	list2columns(R, Cs).
transpose([Word|Words], Cs) :- !,
	transpose(Words, Cs0),
/*	reverse(Word, R), */
	R=Word,
	put_columns(R, Cs0, Cs).
	
list2columns([], []).
list2columns([X|Xs], [[X]|Zs]) :- list2columns(Xs, Zs).

put_columns([], Cs, Cs).
put_columns([X|Xs], [C|Cs0], [[X|C]|Cs]) :- put_columns(Xs, Cs0, Cs).



/* Pretty Print L */

pretty_print([]).
pretty_print([H|T]) :-
	write(H),nl,
	pretty_print(T).