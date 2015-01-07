:- use_module(library(bounds)). 


test0 :-
   L = [2,6,4,9,8,5,_,3,1, 
        1,5,7,3,6,4,2,9,8, 
        8,3,9,2,7,1,6,4,5, 
        6,7,8,1,3,9,4,5,2, 
        5,9,1,4,2,7,3,8,6, 
        3,4,2,6,5,8,9,1,7, 
        7,1,3,8,9,6,5,2,4, 
        4,2,5,7,1,3,8,6,9, 
        9,8,6,5,4,2,1,7,3],
       sudoku(L).

test1 :-
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
            
       

test2 :-
	X = [_,6,_,1,_,4,_,5,_,
	     _,_,8,3,_,5,6,_,_,
	     2,_,_,_,_,_,_,_,1,
	     8,_,_,4,_,7,_,_,6,
	     _,_,6,_,_,_,3,_,_,
	     7,_,_,9,_,1,_,_,4,
	     5,_,_,_,_,_,_,_,2,
	     _,_,7,2,_,6,9,_,_,
	     _,4,_,5,_,8,_,7,_],
	sudoku(X).
       
 
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
      Board= [AA,AB,AC,AD,AE,AF,AG,AH,AI,
              BA,BB,BC,BD,BE,BF,BG,BH,BI,
              CA,CB,CC,CD,CE,CF,CG,CH,CI,
              DA,DB,DC,DD,DE,DF,DG,DH,DI,
              EA,EB,EC,ED,EE,EF,EG,EH,EI,
              FA,FB,FC,FD,FE,FF,FG,FH,FI,
              GA,GB,GC,GD,GE,GF,GG,GH,GI,
              HA,HB,HC,HD,HE,HF,HG,HH,HI,
              IA,IB,IC,ID,IE,IF,IG,IH,II],

%          alldifferent([AA, AB, AC, BA, BB, BC, CA, CB, CC]), 
%          alldifferent([AD, AE, AF, BD, BE, BF, CD, CE, CF]), 
%          alldifferent([AG, AH, AI, BG, BH, BI, CG, CH, CI]), 
 
%          alldifferent([DA, DB, DC, EA, EB, EC, FA, FB, FC]), 
%          alldifferent([DD, DE, DF, ED, EE, EF, FD, FE, FF]), 
%          alldifferent([DG, DH, DI, EG, EH, EI, FG, FH, FI]), 
% 
%          alldifferent([GA, GB, GC, HA, HB, HC, IA, IB, IC]), 
%          alldifferent([GD, GE, GF, HD, HE, HF, ID, IE, IF]), 
%          alldifferent([GG, GH, GI, HG, HH, HI, IG, IH, II]), 
 
          alldifferent([AA, AB, AC, AD, AE, AF, AG, AH, AI]), 
%          alldifferent([BA, BB, BC, BD, BE, BF, BG, BH, BI]), 
%          alldifferent([CA, CB, CC, CD, CE, CF, CG, CH, CI]), 
%          alldifferent([DA, DB, DC, DD, DE, DF, DG, DH, DI]), 
%          alldifferent([EA, EB, EC, ED, EE, EF, EG, EH, EI]), 
%          alldifferent([FA, FB, FC, FD, FE, FF, FG, FH, FI]), 
%          alldifferent([GA, GB, GC, GD, GE, GF, GG, GH, GI]), 
%          alldifferent([HA, HB, HC, HD, HE, HF, HG, HH, HI]), 
%          alldifferent([IA, IB, IC, ID, IE, IF, IG, IH, II]), 
 
%          alldifferent([AA, BA, CA, DA, EA, FA, GA, HA, IA]), 
%          alldifferent([AB, BB, CB, DB, EB, FB, GB, HB, IB]), 
%          alldifferent([AC, BC, CC, DC, EC, FC, GC, HC, IC]), 
%          alldifferent([AD, BD, CD, DD, ED, FD, GD, HD, ID]), 
%          alldifferent([AE, BE, CE, DE, EE, FE, GE, HE, IE]), 
%          alldifferent([AF, BF, CF, DF, EF, FF, GF, HF, IF]), 
%          alldifferent([AG, BG, CG, DG, EG, FG, GG, HG, IG]), 
%          alldifferent([AH, BH, CH, DH, EH, FH, GH, HH, IH]), 
%          alldifferent([AI, BI, CI, DI, EI, FI, GI, HI, II]), 
          
          

          

			portray(Board). 
 
  portray(Board) :- 
          is_list(Board), 
          length(Board,81), 
          !, print_9x9(81,Board). 
 
  print_9x9(81,[D|L]) :- write('\t['), print(D), !, print_9x9(80,L). 
  print_9x9(0,[]) :- write(']'). 
  print_9x9(N,[D|L]) :- 
          write(','), 
          ( N mod 9 =:= 0 -> write('\n\t ') ; true ), 
          print(D), !, 
          N1 is N - 1, 
          print_9x9(N1,L). 