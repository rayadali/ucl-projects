
% colonne(M, i, Y) : Y = i-ième colonne de M 
colonne([], _, []).
colonne([Ligne | SuiteLignes], I, [Item | SuiteColonne]) :-
	nth(I, Ligne, Item),
	colonne(SuiteLignes, I, SuiteColonne).

transposee(M, M2) :-
 M2 = [L1, L2, L3, L4, L5, L6, L7, L8, L9],
 colonne(M, 1, L1),
 colonne(M, 2, L2),
 colonne(M, 3, L3),
 colonne(M, 4, L4),
 colonne(M, 5, L5),
 colonne(M, 6, L6),
 colonne(M, 7, L7),
 colonne(M, 8, L8),
 colonne(M, 9, L9).

flatten([], []).
flatten([H1|T1], Res) :-
	flatten(T1, Tmp),
	append(H1, Tmp, Res).
 
map(P,[]).
map(P,[X|L]) :- 
	F=..[P,X], 
	call(F), 
	map(P,L).

sudoku_labeling([], 0).

sudoku_labeling([Var|Others], N) :-
	fd_dom(Var, [Value]),
	Var is Value,
	sudoku_labeling(Others, N).
  
sudoku_labeling([Var|Others], N) :-
	fd_size(Var, X),
	X > 1,
	fd_dom(Var, Values),
	member(X, Values),
	Var is X,
	sudoku_labeling(Others, N2),
	N is N2 + 1.
	
      

  
sudoku(M) :-

[L1, L2, L3, L4, L5, L6, L7, L8, L9] = M,
 
flatten(M, All),
fd_domain(All, 1, 9),

% ligne
map(fd_all_different, M),

% colonnes
transposee(M, M2),
map(fd_all_different, M2),
% petits carrés

L1 = [X11, X12, X13, X14, X15, X16, X17, X18, X19],
L2 = [X21, X22, X23, X24, X25, X26, X27, X28, X29],
L3 = [X31, X32, X33, X34, X35, X36, X37, X38, X39],
L4 = [X41, X42, X43, X44, X45, X46, X47, X48, X49],
L5 = [X51, X52, X53, X54, X55, X56, X57, X58, X59],
L6 = [X61, X62, X63, X64, X65, X66, X67, X68, X69],
L7 = [X71, X72, X73, X74, X75, X76, X77, X78, X79],
L8 = [X81, X82, X83, X84, X85, X86, X87, X88, X89],
L9 = [X91, X92, X93, X94, X95, X96, X97, X98, X99],

%1ère colonne
fd_all_different([X11, X12, X13, X21, X22, X23, X31, X32, X33]),
fd_all_different([X41, X42, X43, X51, X52, X53, X61, X62, X63]),
fd_all_different([X71, X72, X73, X81, X82, X83, X91, X92, X93]),

% 2ème colonne
fd_all_different([X14, X15, X16, X24, X25, X26, X34, X35, X36]),
fd_all_different([X44, X45, X46, X54, X55, X56, X64, X65, X66]),
fd_all_different([X74, X75, X76, X84, X85, X86, X94, X95, X96]),

% 3ème colonne
fd_all_different([X17, X18, X19, X27, X28, X29, X37, X38, X39]),
fd_all_different([X47, X48, X49, X57, X58, X59, X67, X68, X69]),
fd_all_different([X77, X78, X79, X87, X88, X89, X97, X98, X99]),

sudoku_labeling(All, N),
format("\nNbr de vars à énumérer : ~d", [N]).


toto(X) :-

X = [
[_, 6, _, 1, _, 4, _, 5, _],
[_, _, 8, 3, _, 5, 6, _, _],
[2, _, _, _, _, _, _, _, 1],
[8, _, _, 4, _, 7, _, _, 6],
[_, _, 6, _, _, _, 3, _, _],
[7, _, _, 9, _, 1, _, _, 4],
[5, _, _, _, _, _, _, _, 2],
[_, _, 7, 2, _, 6, 9, _, _],
[_, 4, _, 5, _, 8, _, 7, _]
],
 
sudoku(X).
