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
%Checking individual 9x9
          all_different([AA, AB, AC, BA, BB, BC, CA, CB, CC]), 
          all_different([AD, AE, AF, BD, BE, BF, CD, CE, CF]), 
          all_different([AG, AH, AI, BG, BH, BI, CG, CH, CI]), 
%Checking individual 9x9 
          all_different([DA, DB, DC, EA, EB, EC, FA, FB, FC]), 
          all_different([DD, DE, DF, ED, EE, EF, FD, FE, FF]), 
          all_different([DG, DH, DI, EG, EH, EI, FG, FH, FI]), 
%Checking individual 9x9 
          all_different([GA, GB, GC, HA, HB, HC, IA, IB, IC]), 
          all_different([GD, GE, GF, HD, HE, HF, ID, IE, IF]), 
          all_different([GG, GH, GI, HG, HH, HI, IG, IH, II]), 
%Checking Rows
          all_different([AA, AB, AC, AD, AE, AF, AG, AH, AI]), 
          all_different([BA, BB, BC, BD, BE, BF, BG, BH, BI]), 
          all_different([CA, CB, CC, CD, CE, CF, CG, CH, CI]), 
          all_different([DA, DB, DC, DD, DE, DF, DG, DH, DI]), 
          all_different([EA, EB, EC, ED, EE, EF, EG, EH, EI]), 
          all_different([FA, FB, FC, FD, FE, FF, FG, FH, FI]), 
          all_different([GA, GB, GC, GD, GE, GF, GG, GH, GI]), 
          all_different([HA, HB, HC, HD, HE, HF, HG, HH, HI]), 
          all_different([IA, IB, IC, ID, IE, IF, IG, IH, II]), 
%Checking Columns
          all_different([AA, BA, CA, DA, EA, FA, GA, HA, IA]), 
          all_different([AB, BB, CB, DB, EB, FB, GB, HB, IB]), 
          all_different([AC, BC, CC, DC, EC, FC, GC, HC, IC]), 
          all_different([AD, BD, CD, DD, ED, FD, GD, HD, ID]), 
          all_different([AE, BE, CE, DE, EE, FE, GE, HE, IE]), 
          all_different([AF, BF, CF, DF, EF, FF, GF, HF, IF]), 
          all_different([AG, BG, CG, DG, EG, FG, GG, HG, IG]), 
          all_different([AH, BH, CH, DH, EH, FH, GH, HH, IH]), 
          all_different([AI, BI, CI, DI, EI, FI, GI, HI, II]), 
		 
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