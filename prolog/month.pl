*(*).
month(january,31).
month(february,28).
month(march,31).
month(april,30).
month(may,31).
month(june,30).
month(july,31).
month(august,31).
month(september,30).
month(october,31).
month(november,30).
month(december,31).
countStar(0).

countStar(N) :-
 write(*),
 M is N-1,
 countStar(M). 

printMonth(X,Y) :-
 month(X,Y),
 write(X),
 countStar(Y).