%% dynamics -- so that we can modify them  
:- dynamic on/2.
:- dynamic move/3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% FACTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% the table is always clear, 
%% so that we can place objects on it
clear(table).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% RULES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% init/0 
%% initialise  the database with the current state
init :-
   retractall(on(_,_)),  % retract the states 
   retractall(move(_,_,_)), % retract the plan 

   %% start asserting the new initial state
   asserta(on(c,b)), 
   asserta(on(b,a)),
   asserta(on(a,table)),
   currState.


%% makeplan/1 
%% Attempt to make a plan for the goals givein GoalList
makeplan(GoalList) :-       
   attempt_goals(GoalList,GoalList).  % Attempt the goals


%% attempt_goals/2
%% Attempt the goals - boundry condition
attempt_goals([],_).

%% attempt_goals/2
%% Attempt the goals
%% Q. why are we passing arguments?
attempt_goals([Goal|Rest],Allgoals) :-    
	% call the goal, (Invoke Goal as a goal) 
	% if the goal can be satisfied, move on and try the rest
 	call(Goal) ->  (attempt_goals(Rest,Allgoals),!) ; 

	% if not, try to make the goal possible
  	try(Goal),
	% and start again.
   % look carefully at how this works, notice that we only 
 	% ever move to trying to satisfy the rest of the goals
   % if the "call(Goal)" clause succeeds
	attempt_goals(Allgoals,Allgoals).
	
    

%% try/1 
%% try to place X on Y -  Q. why is this version here?
try(on(X,Y)) :-
     try(X,Y).

%% try/2 
%% try to place X on Y
try(X,Y) :-
   (on(X,Y), !, fail); %  if X is on Y, cut the backtracking and fail    
   clear(X),  %  if not, clear X
   clear(Y),  %  clear Y
   retract(on(X,A)),  % retract that X is on some object "A"
   asserta(on(X,Y)),  % assert that X is on Y
   assert(move(X,A,Y)). % NOW add the action performed to the plan

%% clear/1 
%% a fun (backtracking) way of doing 'not' as in the rule below
%% study this carefully and analyse how it works
clear(X):-
   (on(_,X) -> !, fail; true) .

/*
%% clear/1 
%% an object X is clear if there is no other object on it 
clear(X):-
   \+ on(_,X).
*/   
	
%% clear/1 
%% if there is an object Y on X
clear(X):-
   on(Y,X),  % check there is an object (Y) on X
   clear(Y). % if so, clear Y first (notice the recursion)
   retract(on(Y,X)),
   asserta(on(Y, table)),
   assert(move(Y,X,table)).



%% on/2 
%% test whether X is on Y 
on(X,Y):-
	X \= table,
   X \= Y.  


%% currState/0
%% list the current state
currState:-
   nl,write('================='),nl,
   write('The current plan:'),nl,
   write('(Read as move X from Y to Z)'),
   nl,write('================='),
   listing(move),
   
   nl,write('============================'),nl,
   write('The current state of the table:'),nl,
   write('(Read as X is "on" Y )'),
   nl,write('============================'),
   listing(on).   
