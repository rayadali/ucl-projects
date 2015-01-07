:- use_module(library(bounds)). 



test1 :-	sudoku([5,1,7,6,2,4,8,3,_]).
 
/*  L =     [2,6,4,9,8,5,7,3,1, 
           1,5,7,3,6,4,2,9,8, 
           8,3,9,2,7,1,6,4,5, 
           6,7,8,1,3,9,4,5,2, 
           5,9,1,4,2,7,3,8,6, 
           3,4,2,6,5,8,9,1,7, 
           7,1,3,8,9,6,5,2,4, 
           4,2,5,7,1,3,8,6,9, 
           9,8,6,5,4,2,1,7,3] 
  *************************/ 
  
digits([1,2,3,4,5,6,7,8,9]).
		
isMember(A,[A|T]).
isMember(A,[H|T]):-	isMember(A,T).	
	
member(H,[H|_]):-	!. 
member(H,[_|T]):- 	member(H,T).

del(_,[],[]).
del(X,[X|T],L):-	del(X,T,L).
del(X,[H|L1],[H|L2]):-	del(X,L1,L2).

concat([],B,NewList):-	NewList = B.
concat([A|L1],L2,[A|NewList]):-	concat(L1,L2,NewList).

alldifferent([]). 
alldifferent([H|T]):- 	digits(Old),
						checkNumber(H,T,Old),
						not(member(H,T)),
						alldifferent(T). 

checkNumber([],_).

checkNumber([H|T],Old):-checkNumber(H,T,Old).

checkNumber(H,T,Old):-	checkRange(H,Old,New),
						checkNumber(T,New).
						
checkRange(X,Old,New):-	X==1,member(X,Old),del(X,Old,New);
						X==2,member(X,Old),del(X,Old,New);
						X==3,member(X,Old),del(X,Old,New);
						X==4,member(X,Old),del(X,Old,New);
						X==5,member(X,Old),del(X,Old,New);
						X==6,member(X,Old),del(X,Old,New);
						X==7,member(X,Old),del(X,Old,New);
						X==8,member(X,Old),del(X,Old,New);
						X==9,member(X,Old),del(X,Old,New).

checkRange(X,Old,New):- isMember(1,Old)->del(X,Old,New),assignTo1(X,A);
						isMember(2,Old)->del(X,Old,New),assignTo2(X,A);
						isMember(3,Old)->del(X,Old,New),assignTo3(X,A);
						isMember(4,Old)->del(X,Old,New),assignTo4(X,A);
						isMember(5,Old)->del(X,Old,New),assignTo5(X,A);
						isMember(6,Old)->del(X,Old,New),assignTo6(X,A);
						isMember(7,Old)->del(X,Old,New),assignTo7(X,A);
						isMember(8,Old)->del(X,Old,New),assignTo8(X,A);
						isMember(9,Old)->del(X,Old,New),assignTo9(X,A).
						
checkRange(X,Old,New):- isMember(9,Old)->del(X,Old,New),assignTo9(X,A);
						isMember(8,Old)->del(X,Old,New),assignTo8(X,A);
						isMember(7,Old)->del(X,Old,New),assignTo7(X,A);
						isMember(6,Old)->del(X,Old,New),assignTo6(X,A);
						isMember(5,Old)->del(X,Old,New),assignTo5(X,A);
						isMember(4,Old)->del(X,Old,New),assignTo4(X,A);
						isMember(3,Old)->del(X,Old,New),assignTo3(X,A);
						isMember(2,Old)->del(X,Old,New),assignTo2(X,A);
						isMember(1,Old)->del(X,Old,New),assignTo1(X,A).
									
assignTo1(X,A):-	X=1,A=X.
assignTo2(X,A):-	X=2,A=X.
assignTo3(X,A):-	X=3,A=X.
assignTo4(X,A):-	X=4,A=X.
assignTo5(X,A):-	X=5,A=X.
assignTo6(X,A):-	X=6,A=X.
assignTo7(X,A):-	X=7,A=X.
assignTo8(X,A):-	X=8,A=X.
assignTo9(X,A):-	X=9,A=X.

sudoku(Board) :- 
      Board= [AA, AB, AC, BA, BB, BC, CA, CB, CC], 

%Checking individual 9x9
          alldifferent([AA, AB, AC, BA, BB, BC, CA, CB, CC]), 

			portray(Board). 
 
  portray(Matrix) :- 
          is_list(Matrix), 
          length(Matrix,81), 
          !, print_9x9(81,Matrix). 
 
  print_9x9(81,[D|L]) :- write('\t['), print(D), !, print_9x9(80,L). 
  print_9x9(0,[]) :- write(']'). 
  print_9x9(N,[D|L]) :- 
          write(','), 
          ( N mod 9 =:= 0 -> write('\n\t ') ; true ), 
          print(D), !, 
          N1 is N - 1, 
          print_9x9(N1,L). 