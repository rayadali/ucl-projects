:- use_module(library(bounds)). 

test1:-
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
 
%  L =     [2,6,4,9,8,5,7,3,1, 
%           1,5,7,3,6,4,2,9,8, 
%           8,3,9,2,7,1,6,4,5, 
%           6,7,8,1,3,9,4,5,2, 
%           5,9,1,4,2,7,3,8,6, 
%           3,4,2,6,5,8,9,1,7, 
%           7,1,3,8,9,6,5,2,4, 
%           4,2,5,7,1,3,8,6,9, 
%           9,8,6,5,4,2,1,7,3] 

alldifferent([]).
alldifferent([H|T]):- check(H,T),alldifferent(T).
check(_,[]).
check(H1,[H2|T]):- H1#\=H2, check(H1,T).
  
  sudoku(Sudoku):- 
    Board = [AA, AB, AC, AD, AE, AF, AG, AH, AI, 
              BA, BB, BC, BD, BE, BF, BG, BH, BI, 
              CA, CB, CC, CD, CE, CF, CG, CH, CI, 
              DA, DB, DC, DD, DE, DF, DG, DH, DI, 
              EA, EB, EC, ED, EE, EF, EG, EH, EI, 
              FA, FB, FC, FD, FE, FF, FG, FH, FI, 
              GA, GB, GC, GD, GE, GF, GG, GH, GI, 
              HA, HB, HC, HD, HE, HF, HG, HH, HI, 
             IA, IB, IC, ID, IE, IF, IG, IH, II],
             Board in 1..9,
              
%Checking individual 9x9
          alldifferent([AA, AB, AC, BA, BB, BC, CA, CB, CC]), 
          alldifferent([AD, AE, AF, BD, BE, BF, CD, CE, CF]), 
          alldifferent([AG, AH, AI, BG, BH, BI, CG, CH, CI]), 
%Checking individual 9x9 
          alldifferent([DA, DB, DC, EA, EB, EC, FA, FB, FC]), 
          alldifferent([DD, DE, DF, ED, EE, EF, FD, FE, FF]), 
          alldifferent([DG, DH, DI, EG, EH, EI, FG, FH, FI]), 
%Checking individual 9x9 
          alldifferent([GA, GB, GC, HA, HB, HC, IA, IB, IC]), 
          alldifferent([GD, GE, GF, HD, HE, HF, ID, IE, IF]), 
          alldifferent([GG, GH, GI, HG, HH, HI, IG, IH, II]), 
%Checking Rows
          alldifferent([AA, AB, AC, AD, AE, AF, AG, AH, AI]), 
          alldifferent([BA, BB, BC, BD, BE, BF, BG, BH, BI]), 
          alldifferent([CA, CB, CC, CD, CE, CF, CG, CH, CI]), 
          alldifferent([DA, DB, DC, DD, DE, DF, DG, DH, DI]), 
          alldifferent([EA, EB, EC, ED, EE, EF, EG, EH, EI]), 
          alldifferent([FA, FB, FC, FD, FE, FF, FG, FH, FI]), 
          alldifferent([GA, GB, GC, GD, GE, GF, GG, GH, GI]), 
          alldifferent([HA, HB, HC, HD, HE, HF, HG, HH, HI]), 
          alldifferent([IA, IB, IC, ID, IE, IF, IG, IH, II]), 
%Checking Columns
          alldifferent([AA, BA, CA, DA, EA, FA, GA, HA, IA]), 
          alldifferent([AB, BB, CB, DB, EB, FB, GB, HB, IB]), 
          alldifferent([AC, BC, CC, DC, EC, FC, GC, HC, IC]), 
          alldifferent([AD, BD, CD, DD, ED, FD, GD, HD, ID]), 
          alldifferent([AE, BE, CE, DE, EE, FE, GE, HE, IE]), 
          alldifferent([AF, BF, CF, DF, EF, FF, GF, HF, IF]), 
          alldifferent([AG, BG, CG, DG, EG, FG, GG, HG, IG]), 
          alldifferent([AH, BH, CH, DH, EH, FH, GH, HH, IH]), 
          alldifferent([AI, BI, CI, DI, EI, FI, GI, HI, II]), 
		 
          label(Board),
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