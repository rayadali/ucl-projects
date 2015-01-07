%should 123456789 
test1:-
		L = [1,2,3,4,5,6,7,8,9],
		alldifferent(L),writelist(L).
		
%should 987654321		
test2:-
		L = [9,8,7,6,5,4,3,2,1],
		alldifferent(L),writelist(L).
		
%should fail		
test3:-
		L = [9,9,2,3,2,2],
		alldifferent(L),writelist(L).
		
%should 123456789		
test4:-
		L = [1,2,3,4,5,6,7,8,_],
		alldifferent(L),writelist(L).
		
%should 123456789		
test5:-
		L = [1,2,3,4,5,6,7,_,_],
		alldifferent(L),writelist(L).
		
%should 123456789		
test6:-
		L = [_,2,3,4,5,6,7,8,9],
		alldifferent(L),writelist(L).
		
%should 987654321		
test7:-
		L = [_,8,7,6,5,4,3,2,1],
		alldifferent(L),writelist(L).
		
%should 123456789 ; 123456784		
test8:-
		L = [1,2,3,_,5,6,7,8,_],
		alldifferent(L),writelist(L).
		
%should 987654321 ; 987154326		
test9:-
		L = [9,8,7,_,5,4,3,2,_],
		alldifferent(L),writelist(L).
		
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

writelist([]).
writelist([H|T]):- 	write(H),
					writelist(T).