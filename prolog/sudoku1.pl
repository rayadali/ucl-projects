%%%%%%%%%%%%%%%%%%%%%%%%%
%    sudoku solver	%
%%%%%%%%%%%%%%%%%%%%%%%%%

% Distributed under GPL
% email -- cjp501 [at] cs [dot] york [dot] ac [dot] uk


solve :-
    initial(X),
    solve(X).

solve(Grid) :-
    goal(Grid),
    draw(Grid).

solve(Grid) :-
    findallmoves(Grid, AllMoves),
    findbestmoves(AllMoves, BestMoves),
    nth1(_, BestMoves, AMove),
    applymove(Grid, AMove, NewGrid),
    solve(NewGrid).


%%%%%%%%%%%%%%%%%%%%%%%%%
%    sudoku program	%
%%%%%%%%%%%%%%%%%%%%%%%%%

% a blank grid
%row(1, [-,-,-,-,-,-,-,-,-]).
%row(2, [-,-,-,-,-,-,-,-,-]).
%row(3, [-,-,-,-,-,-,-,-,-]).
%row(4, [-,-,-,-,-,-,-,-,-]).
%row(5, [-,-,-,-,-,-,-,-,-]).
%row(6, [-,-,-,-,-,-,-,-,-]).
%row(7, [-,-,-,-,-,-,-,-,-]).
%row(8, [-,-,-,-,-,-,-,-,-]).
%row(9, [-,-,-,-,-,-,-,-,-]).

% a solvable grid
row(1, [-,5,7,-,-,1,-,4,-]).
row(2, [-,-,6,-,-,-,2,7,-]).
row(3, [4,-,-,6,9,-,-,-,5]).
row(4, [8,-,-,4,-,-,3,-,1]).
row(5, [-,3,2,-,7,-,5,8,-]).
row(6, [1,-,5,-,-,6,-,-,2]).
row(7, [7,-,-,-,8,5,-,-,3]).
row(8, [-,9,3,-,-,-,6,-,-]).
row(9, [-,8,-,9,-,-,4,2,-]).

% a VERY hard grid to solve
%row(1, [8,-,3,-,2,9,7,1,6]).
%row(2, [-,-,6,-,1,8,5,-,4]).
%row(3, [-,-,-,-,6,-,-,-,8]).
%row(4, [-,-,5,-,4,6,-,8,-]).
%row(5, [7,-,9,-,3,5,6,4,2]).
%row(6, [-,6,-,-,9,-,1,-,5]).
%row(7, [6,-,-,-,7,-,-,5,1]).
%row(8, [-,-,1,6,5,-,8,-,-]).
%row(9, [5,-,-,9,8,1,4,6,3]).

digits([1,2,3,4,5,6,7,8,9]).

initial([R1,R2,R3,R4,R5,R6,R7,R8,R9]) :-
	row(1, R1),
	row(2, R2),
	row(3, R3),
	row(4, R4),
	row(5, R5),
	row(6, R6),
	row(7, R7),
	row(8, R8),
	row(9, R9).

goal([]).
goal([H|T]) :-
	\+ nth1(_,H,'-'),
	goal(T).

column(_, [],  []).
column(Number, [G|Gs], [C|Cs]) :-
	nth1(Number, G, C),
	column(Number, Gs, Cs).

nine-square(X, Y, Grid, Result) :-
	Row1 is ((Y - 1) * 3) +1,
	Row2 is Row1 +1,
	Row3 is Row2 +1,
	Column is ((X - 1) * 3) +1,
	nine-square_x(Row1, Column, Grid, R1, 0),
	nine-square_x(Row2, Column, Grid, R2, 0),
	nine-square_x(Row3, Column, Grid, R3, 0),
	append(R1, R2, NewR),
	append(NewR, R3, Result).
	
nine-square_x(_ , _, _, [], 3).
nine-square_x(Row, Column, Grid, [R|Rs], X) :-
	nth1(Row, Grid, ARow),
	nth1(Column, ARow, R),
	Column2 is Column +1,
	X2 is X +1,
	nine-square_x(Row, Column2, Grid, Rs, X2).

findmove(Grid, X, Y, Value, Rank) :-
    digits(Digits),
    nth1(_, Digits, X),
    nth1(_, Digits, Y),
    findall(
	    AValue,
	    findmove(Grid, X, Y, AValue),
	    Possible
    ),
    length(Possible, Rank),
    findmove(Grid, X, Y, Value).

findmove(Grid, X, Y, Value) :-
    nth1(Y, Grid, Line),
    nth1(X, Line, '-'),
    digits(Digits),
    nth1(_, Digits, Value),
    not(member(Value, Line)),
    column(X, Grid, Column),
    not(member(Value, Column)),
    Xarea is (X + 2) // 3,
    Yarea is (Y + 2) // 3,
    nine-square(Xarea, Yarea, Grid, NineSquare),
    not(member(Value, NineSquare)).

findallmoves(Grid, SortedMoves) :-
    findall(
	    move(Rank, coord(X, Y), Value),
	    findmove(Grid, X, Y, Value, Rank),
	    Moves
    ),
    sort(Moves, SortedMoves).
    
findbestmoves([M|Ms], BestMoves) :-
    M = move(Rank, coord(_X, _Y), _Value),
    findbestmoves([M|Ms], Rank, BestMoves).

findbestmoves([M|Ms], Rank, [M|Bs]) :-
    M = move(Rank, coord(_X, _Y), _Value),
    findbestmoves(Ms, Rank, Bs),
    !.
    
findbestmoves(_Moves, _Rank, []).

applymove([['-'|Hs]|Gs], move(_Rank, coord(1, 1), Value), [[Value|Hs]|Gs]) :-
    !.

applymove([[H|Hs]|Gs], move(_Rank, coord(X, 1), Value), [[H|Ns]|Gs]) :-
    NewX is X -1,
    applymove([Hs], move(_Rank, coord(NewX, 1), Value), [Ns]),
    !.

applymove([G|Gs], move(_Rank, coord(X, Y), Value), [G|Ns]) :-
    NewY is Y -1,
    applymove(Gs, move(_Rank, coord(X, NewY), Value), Ns).


%%%%%%%%%%%%%%%%%%%%%%%%%
%   Draw su-doku grid	%
%%%%%%%%%%%%%%%%%%%%%%%%%

draw(Grid) :-
    write('\n'),
    length(Grid, Size),
    draw_aux(Grid, Size),
    !.

draw_aux([], Size) :-
    draw_separator2(Size).
draw_aux([H|T], Size) :-
    length(T, ToDo),
    0 is (ToDo + 1) mod 3,
    length(H, LineSize),
    draw_separator2(LineSize),
    draw_line(H),
    draw_aux(T, Size).
draw_aux([H|T], Size) :-
    length(H, LineSize),
    draw_separator(LineSize),
    draw_line(H),
    draw_aux(T, Size).
    
draw_separator(0) :-	
    write('+\n').
draw_separator(Size) :-
    write('+---'),
    NewSize is Size -1,
    draw_separator(NewSize).
draw_separator2(0) :-	
    write('=\n').
draw_separator2(Size) :-
    write('===='),
    NewSize is Size -1,
    draw_separator2(NewSize).
    
draw_line([]) :-
    write('#\n').
draw_line(['-'|T]) :-
    length(T, Remain),
    draw_line_aux(Remain),
    write('   '),
    draw_line(T).
draw_line([H|T]) :-
    length(T, Remain),
    draw_line_aux(Remain),
    write(' '),
    write(H),
    write(' '),
    draw_line(T).
draw_line_aux(Remain) :-
    0 is (Remain +1) mod 3,
    write('#').
draw_line_aux(_) :-
    write('|').
