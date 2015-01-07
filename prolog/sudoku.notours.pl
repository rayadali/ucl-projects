%TO convert to gnuprolog remove the following two lines.
%:- use_module(library(clpfd)).
%:- use_module(library(lists)).
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

:- initialization(go).
:- dynamic(counter/1).

go :-
        argument_value(1, File),
        %File = 'sudoku.txt',           % the file to read from, file should have 9 lines, each 9 charaters
        start(File).                    % 0 or spaces should be used for unknown values

start(File) :-
        %statistics(cputime,Cpu),       % gnu prolog
        cpu_time(Cpu),                  % swi-prolog
        write(trying_file(File)),nl,
        see(File),                      % open file

        (       readall(List),nl,       % read the file into the List
                write('list after reading: '),nl,
                pretty_sudo_print(List),nl,     % print to see if reading went ok
                 X = 1,!,
                (       inc(1,Inc,100),
                        retractall(counter(_)),
                        assertz(counter(X)),
                        %write(test(Inc,List)),nl,
                        solve(List,X)
                        ;
                        true
                )
        ),
        seen,
        write('cpu time taken: '),
        cpu_time(CpuNew),               % gnu prolog
        %statistics(cputime,CpuNew),    %for swi-prolog
        CpuUsed is CpuNew - Cpu,
        write(CpuUsed),nl,                              % close the file
        halt.   % gnu prolog

% to read from the file
readall(List) :-
        List = [_,_,_,_,_,_,_,_,_],
        readrows(List),!.

readall(_) :-
        write('reading failed :/'),!,fail.

readrows([]).
readrows([H|T]) :-
        readrow(H),
        readrows(T).

%read one row
readrow(Var) :-
        Var = [_,_,_,_,_,_,_,_,_],
        readchars(Var).

readchars([]) :-
        get0(Y),
        (Y == 10 ; Y == 13; Y == -1),!.


readchars([H|T]) :-
        get0(Y),
        (((Y == 10 ; Y == 13),!,readchars([H|T]));
        (       (Y == 32;Y == 48),!;
                (Y > 48,Y < 58,!,H is Y - 48)
        ),
        readchars(T)).


% pretty printing \0/
pretty_sudo_print([]).
pretty_sudo_print([A,B,C|T]) :-
        nl,printsudorow(A),
        printsudorow(B),
        printsudorow(C),
        pretty_sudo_print(T).

printsudorow([]) :- nl.
printsudorow([A,B,C|T]) :-
        writerepv(A),tab(1),
        writerepv(B),tab(1),
        writerepv(C),tab(3),
        printsudorow(T).

writerepv(X) :-
        var(X),!,write(' ').

writerepv(X) :-
        write(X).

inc(X,X,_).

inc(X,Xnew,Max) :-
	X < Max,
	Xtemp is X + 1,
	inc(Xtemp,Xnew,Max).

solve(List,C) :-
        assertz(counter(C)),
        sudoku(List),
        retract(counter(X)),
        Xnew is X -1,
        Numb is C - X +1,
        write('number '),write(Numb),write(' found: '),pretty_sudo_print(List),nl,

        (       Xnew < 1,!,
                write('solving completed: '),write(C),write(' solutions found.... there might be more out there '),
                fail;
                true
        ),
        assertz(counter(Xnew)),
        fail.

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
	L=
	[
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_],
	 [_,_,_,_,_,_,_,_,_]
	],
	sudoku(L),
	pretty_print(L).

%Expects a list of lists 9 by 9 grid.
sudoku(L) :-
	flatten(L,AllVars),
	%domain(AllVars,1,9),
	fd_domain(AllVars,[1,2,3,4,5,6,7,8,9]),
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

		
	%labeling([ffc],AllVars).
	fd_labeling(AllVars).
	%label(AllVars).


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
	printline(H),nl,
	pretty_print(T).
	
printline([]).
printline([H|T]) :-
	write(H), printline(T).

% All variables in List are in the domain of Min...Max
%domain([], _, _).
%domain([H|T], Min, Max) :-
%	H in Min..Max,
%	domain(T, Min, Max).
	
% All variables in list are different
all_different([]).
all_different([H|T]) :-
	\+ member(H, T),
	all_different(T).

%labeling(_, L)
