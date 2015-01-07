fib(0,0).
fib(1,1).

fib(X,Y) :-
 A is X-2,
 fib(A,C),
 B is X-1,
 fib(B,D),
 Y is C+D.