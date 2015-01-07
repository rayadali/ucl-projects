%	GNU Prolog code to solve sudoku puzzels
%	written by Niels & Andreas


:- dynamic(counter/1).

go :-
	File = 'sudoku.txt',		% the file to read from, file should have 9 lines, each 9 charaters
	start(File).			% 0 or spaces should be used for unknown values
	

start(File) :-					
	statistics(cputime,Cpu),	% to count cpu time+
	write(trying_file(File)),nl,	% writeln doesn't work in GNU prolog
	see(File),			% open file

	(	readall(List),nl,	% read the file into the List
		write('list after reading: '),nl,
		pretty_sudo_print(List),nl,	% print to see if reading went ok
		retractall(counter(_)),
		SolveTimes = 10,
		assert(counter(SolveTimes)),
		solve(List,SolveTimes)
		;
		true
	),
	seen,
	write('cpu time taken: '),
	statistics(cputime,CpuNew),
	CpuUsed is CpuNew - Cpu,
	writeln(CpuUsed).				% close the file


solve(List,C) :-			%solve List max C times
	correct_whole(List),!,
	fill_numbers_in(List),
	retract(counter(X)),
	Xnew is X -1,
	Numb is C - X +1,
	write('number '),write(Numb),write(' found: '),
	pretty_sudo_print(List),nl,
	
	(	Xnew < 1,!,
		write('solving completed: '),write(C),write(' solutions found.... there might be more out there ... '),
		fail;
		true
	),
	assert(counter(Xnew)),
	fail.

solve(List,_) :-
	writeln(not_able_to_solve(List)).

	
correct_whole(List) :-		% check the file which was read for mistakes already existing
	control_hori(List),
	control_verti(List),
	control_regio(List).
	
% check if all rows have no double items
control_hori([]).	
control_hori([H|T]) :-
	all_different(H),
	control_hori(T).
	
% check if all columns have no double items	
control_verti([[],[],[],[],[],[],[],[],[]]).	
control_verti([[A|TA],[B|TB],[C|TC],[D|TD],[E|TE],[F|TF],[G|TG],[H|TH],[I|TI]]) :-
	all_different([A,B,C,D,E,F,G,H,I]),
	control_verti([TA,TB,TC,TD,TE,TF,TG,TH,TI]).

% check if every 3x3 area has no double items
control_regio([]).
control_regio([A,B,C|T]) :-
	control_regio_row([A,B,C]),
	control_regio(T).
	
control_regio_row([[],[],[]]).
control_regio_row([[A,B,C|TA],[D,E,F|TB],[G,H,I|TC]]) :-
	all_different([A,B,C,D,E,F,G,H,I]),
	control_regio_row([TA,TB,TC]).

	

correct_part(List,X,Y) :-	% control a part of the sudoku with locations X and Y
	control_part_verti(List,Y),
	control_part_regio(List,X,Y),!.

	
control_part_verti([[A|_],[B|_],[C|_],[D|_],[E|_],[F|_],[G|_],[H|_],[I|_]],1) :-	%right column found
	!,
	all_different([A,B,C,D,E,F,G,H,I]).

control_part_verti([[_|TA],[_|TB],[_|TC],[_|TD],[_|TE],[_|TF],[_|TG],[_|TH],[_|TI]],Y) :-	
	Ynew is Y -1,
	control_part_verti([TA,TB,TC,TD,TE,TF,TG,TH,TI],Ynew).		%check next column
	
	
control_part_regio(List,X,Y) :-	
	Xnew is (X -1)// 3,	% make the 9x9 to a 3x3
	Ynew is (Y -1)// 3,
	control_part_regio_area(List,Xnew,Ynew).

control_part_regio_area([Row1,Row2,Row3|_],0,Y) :-
	!,control_part_regio_row([Row1,Row2,Row3],Y).	% rows where the 3x3 area is are found

control_part_regio_area([_,_,_|List],X,Y) :-	
	Xnew is X -1,
	control_part_regio_area(List,Xnew,Y).	% try next rows
	

control_part_regio_row([[A,B,C|_],[D,E,F|_],[G,H,I|_]],0) :-	% 3x3 area found
	!,all_different([A,B,C,D,E,F,G,H,I]).		
	
control_part_regio_row([[_,_,_|TA],[_,_,_|TB],[_,_,_|TC]],Y) :-
	Ynew is Y -1,
	control_part_regio_row([TA,TB,TC],Ynew).	%check next columns	
		
	

all_different([]) :- !.		% an empty list has no double items :)


all_different([H|T]) :-
	(	var(H)		% if H is a Var, don't let it match with other items in the list 
		;
		not(membervar(H,T))	% else, make sure H is not in T
	),!,
	all_different(T).	%check rest of list
	
	
membervar(H,[Var|T]) :-
	var(Var),!,	% don't match Var with H
	membervar(H,T).	% check if H is in T
	
membervar(H,[H|_]) :- !.

membervar(H,[_|T]) :-
	!,membervar(H,T).
	

fill_numbers_in(List) :-
	findanVar(H,List,0,X,Y,Sublist),	%find an var
	difference([1,2,3,4,5,6,7,8,9],Sublist,Choices),
	!,
	member(H,Choices),		% find available number for that row
	correct_part(List,X,Y),
	fill_numbers_in(List).		%check if it is correct

fill_numbers_in(_).	%there are no vars to fill in anymore.
	

% give difference bewteen List and another list, all items which are in 1st but not in 2nd
difference(List,[],List) :- !.

difference(List,[H|Sublist],Difference) :-
	var(H),!,difference(List,Sublist,Difference),!.
	
difference(List,[H|Sublist],Difference) :-
	remove(H,List,Newlist),
	difference(Newlist,Sublist,Difference),!.

% remove item from the list
remove(H,[H|T],T) :- !.	%there is always max one time H in the list
remove(_,[],[]).
remove(H,[V|T],[V|NewT]) :-
	remove(H,T,NewT).
	
findanVar(V,[Row|_],X,Xend,Yend,Row) :-	
	Xnew is X +1,
	findaVar(V,Row,Xnew,1,Xend,Yend).	% find a Var inside this row

findanVar(V,[_|Rest],X,Xend,Yend,Sublist) :-	
	Xnew is X +1,
	findanVar(V,Rest,Xnew,Xend,Yend,Sublist).	%loop thru all horizontal rows
	

findaVar(V,[V|_],X,Y,X,Y) :-	%lovely.. :]
	var(V),!.
	
findaVar(V,[_|T],X,Y,Xend,Yend) :-
	Ynew is Y + 1,
	findaVar(V,T,X,Ynew,Xend,Yend),!.
	
	
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
	(	(Y == 32;Y == 48),!;
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
	