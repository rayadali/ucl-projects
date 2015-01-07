:- use_module(library('clp/bounds')).

test2 :-
   L = [_,_,_,9,_,_,7,_,_,
        _,_,_,_,_,4,2,_,_,
        8,_,_,_,_,1,6,_,_,
        _,7,_,_,3,_,_,5,_,
        _,9,_,_,_,_,_,8,_,
        _,4,_,_,5,_,_,1,_,
        _,_,3,8,_,_,_,_,4,
        _,_,5,7,_,_,_,_,_,
        _,_,6,_,_,2,_,_,_],
       sudoku(L).

valid_numbers(Y) :- Y in 1..9.

different([]).
different([H|T]):- notin(H,T),different(T).
notin(_,[]).
notin(H1,[H2|T]):- H1#\=H2, notin(H1,T).

sudoku(X) :-
         X = [A1, A2, A3, A4, A5, A6, A7, A8, A9,
              B1, B2, B3, B4, B5, B6, B7, B8, B9,
              C1, C2, C3, C4, C5, C6, C7, C8, C9,
              D1, D2, D3, D4, D5, D6, D7, D8, D9,
              E1, E2, E3, E4, E5, E6, E7, E8, E9,
              F1, F2, F3, F4, F5, F6, F7, F8, F9,
              G1, G2, G3, G4, G5, G6, G7, G8, G9,
              H1, H2, H3, H4, H5, H6, H7, H8, H9,
              I1, I2, I3, I4, I5, I6, I7, I8, I9],

  
X1=[A1,A2,A3,A4,A5,A6,A7,A8,A9],
X2=[B1,B2,B3,B4,B5,B6,B7,B8,B9],
X3=[C1,C2,C3,C4,C5,C6,C7,C8,C9],
X4=[D1,D2,D3,D4,D5,D6,D7,D8,D9],
X5=[E1,E2,E3,E4,E5,E6,E7,E8,E9], 
X6=[F1,F2,F3,F4,F5,F6,F7,F8,F9],
X7=[G1,G2,G3,G4,G5,G6,G7,G8,G9],
X8=[H1,H2,H3,H4,H5,H6,H7,H8,H9],
X9=[I1,I2,I3,I4,I5,I6,I7,I8,I9],

X10=[A1,B1,C1,D1,E1,F1,G1,H1,I1],
X11=[A2,B2,C2,D2,E2,F2,G2,H2,I2],
X12=[A3,B3,C3,D3,E3,F3,G3,H3,I3],
X13=[A4,B4,C4,D4,E4,F4,G4,H4,I4],  
X14=[A5,B5,C5,D5,E5,F5,G5,H5,I5],
X15=[A6,B6,C6,D6,E6,F6,G6,H6,I6],
X16=[A7,B7,C7,D7,E7,F7,G7,H7,I7],
X17=[A8,B8,C8,D8,E8,F8,G8,H8,I8],
X18=[A9,B9,C9,D9,E9,F9,G9,H9,I9],

X19=[A1,A2,A3,B1,B2,B3,C1,C2,C3],
X20=[A4,A5,A6,B4,B5,B6,C4,C5,C6],
X21=[A7,A8,A9,B7,B8,B9,C7,C8,C9],      
X22=[D1,D2,D3,E1,E2,E3,F1,F2,F3],    
X23=[D4,D5,D6,E4,E5,E6,F4,F5,F6],
X24=[D7,D8,D9,E7,E8,E9,F7,F8,F9],
X25=[G1,G2,G3,H1,H2,H3,I1,I2,I3],
X26=[G4,G5,G6,H4,H5,H6,I4,I5,I6],
X27=[G7,G8,G9,H7,H8,H9,I7,I8,I9],

  different(X1),different(X2),different(X3),different(X4),different(X5),different(X6),different(X7),different(X8),different(X9),different(X10),
  different(X11),different(X12),different(X13),different(X14),different(X15),different(X16),different(X17),different(X18),different(X19),different(X20),
  different(X21),different(X22),different(X23),different(X24),different(X25),different(X26),different(X27),
 

         valid_numbers(A1),valid_numbers(A2),valid_numbers(A3),valid_numbers(A4),valid_numbers(A5),valid_numbers(A6),valid_numbers(A7),valid_numbers(A8),valid_numbers(A9),  
         valid_numbers(B1),valid_numbers(B2),valid_numbers(B3),valid_numbers(B4),valid_numbers(B5),valid_numbers(B6),valid_numbers(B7),valid_numbers(B8),valid_numbers(B9),
         valid_numbers(C1),valid_numbers(C2),valid_numbers(C3),valid_numbers(C4),valid_numbers(C5),valid_numbers(C6),valid_numbers(C7),valid_numbers(C8),valid_numbers(C9),             
         valid_numbers(D1),valid_numbers(D2),valid_numbers(D3),valid_numbers(D4),valid_numbers(D5),valid_numbers(D6),valid_numbers(D7),valid_numbers(D8),valid_numbers(D9),
         valid_numbers(E1),valid_numbers(E2),valid_numbers(E3),valid_numbers(E4),valid_numbers(E5),valid_numbers(E6),valid_numbers(E7),valid_numbers(E8),valid_numbers(E9),
         valid_numbers(F1),valid_numbers(F2),valid_numbers(F3),valid_numbers(F4),valid_numbers(F5),valid_numbers(F6),valid_numbers(F7),valid_numbers(F8),valid_numbers(F9),
         valid_numbers(G1),valid_numbers(G2),valid_numbers(G3),valid_numbers(G4),valid_numbers(G5),valid_numbers(G6),valid_numbers(G7),valid_numbers(G8),valid_numbers(G9),
         valid_numbers(H1),valid_numbers(H2),valid_numbers(H3),valid_numbers(H4),valid_numbers(H5),valid_numbers(H6),valid_numbers(H7),valid_numbers(H8),valid_numbers(H9),
         valid_numbers(I1),valid_numbers(I2),valid_numbers(I3),valid_numbers(I4),valid_numbers(I5),valid_numbers(I6),valid_numbers(I7),valid_numbers(I8),valid_numbers(I9),


 
         label(X),  %sign a value to the variable
  
          print_sudoku([A1,A2,A3,A4,A5,A6,A7,A8,A9]),print_sudoku([B1,B2,B3,B4,B5,B6,B7,B8,B9]),print_sudoku([C1,C2,C3,C4,C5,C6,C7,C8,C9]),write('--- --- ---'),nl,
          print_sudoku([D1,D2,D3,D4,D5,D6,D7,D8,D9]),print_sudoku([E1,E2,E3,E4,E5,E6,E7,E8,E9]),print_sudoku([F1,F2,F3,F4,F5,F6,F7,F8,F9]),write('--- --- ---'),nl,
          print_sudoku([G1,G2,G3,G4,G5,G6,G7,G8,G9]),print_sudoku([H1,H2,H3,H4,H5,H6,H7,H8,H9]),print_sudoku([I1,I2,I3,I4,I5,I6,I7,I8,I9]).

        print_sudoku([X1,X2,X3,X4,X5,X6,X7,X8,X9]):-
          write(X1),write(X2),write(X3),write('|'),write(X4),write(X5),write(X6),write('|'),write(X7),write(X8),write(X9),nl.






%ask a query like this:   X=[5,3,_,_,7,_,_,_,_,6,_,_,1,9,5,_,_,_,_,9,8,_,_,_,_,6,_,8,_,_,_,6,_,_,_,3,4,_,_,8,_,3,_,_,1,7,_,_,_,2,_,_,_,6,_,6,_,_,_,_,2,8,_,_,_,_,4,1,9,_,_,5,_,_,_,_,8,_,_,7,9],sudoku(X)



