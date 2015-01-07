/* Treasure Game ]- d^=^b -[ Rayad Ali */

/* Rooms */
/* */
room(armoury). 
room(kitchen).
room(hall).
room(dungeon).
room(bedroom).
room(secret_chamber).
room(street). 

/* the doors  between rooms */
door(street, hall).
door(kitchen, hall).
door(dungeon, hall).
door(armoury, hall).
door(armoury, dungeon).
door(armoury, kitchen).
door(bedroom, dungeon).
door(bedroom, secret_chamber).

:- dynamic unlocked/1.
:- dynamic locked/1.

/* the unlocked and locked doors */
unlocked(kitchen).
unlocked(hall).
unlocked(dungeon).
unlocked(bedroom).
unlocked(street).
locked(armoury).
locked(secret_chamber).

/* keys for the locked doors */
correct_key(armoury,armoury_key).
correct_key(secret_chamber,secret_chamber_key).

:- dynamic located/2.

/* the content of the hall*/
located(hall, 'there is absolutly NOTHING here!!!').

/* the content of the dungeon. where Y is in/on X using (X,Y)*/
located(dungeon, desk).
located(dungeon, giant_bats).
located(desk, secret_chamber_key).

/* the content of the kitchen */
located(kitchen, counter).
located(counter, apple).
located(counter, pear).
located(counter, banana).
located(counter, 'never ending bowl of fruit').
located(kitchen, cupboard).
located(cupboard, armoury_key).

/* the content of the bedroom */
located(bedroom, bed).
located(bedroom, chair).
located(bedroom, mirror).

/* the content of the armoury */
located(armoury, grenades).
located(armoury, deagle).
located(armoury, ak47).
located(armoury, flamethrower).

/* the content of the secret chamber */
located(secret_chamber, treasure).

/* Food!! */
eatable(apple).
eatable(pear).
eatable(banana).

/* enemies */
enemy(giant_bats).

/* the items agent can pick up */
is_item(apple).
is_item(pear).
is_item(banana).
is_item(treasure).
is_item(grenades).
is_item(deagle).
is_item(ak47).
is_item(flamethrower).
is_item(secret_chamber_key).
is_item(armoury_key).

/* the weapons the agent can use to attack with */
weapon(grenades).
weapon(deagle).
weapon(ak47).
weapon(flamethrower).



:- dynamic here/1.
:- dynamic have/1.
:- dynamic have_rule/1.
:- dynamic display_health/1.
:- dynamic health/1.


/* intialaising */
init:-
	assert(here(street)),
	write(('Find the treasure young bounty hunter!')),nl,
	write(('Remember the following: ')),nl,
	write(('You must open a locked door before entering the locked room.')),nl,
	write(('You need weapons to fight the bats!')),nl,
	write(('If your health reaches 0, you die and lose!')),nl,
	write(('You must return to the street with the treasure to win the game!')),nl,
	nl,
	write(('To take a look around, type "look"')),nl,
	write(('To take something, type "take(<item to take>)"')),nl,
	write(('To open a locked door, type "open(<room to open>,<key for room>)"')),nl,
	write(('To eat something, type "eat(<food>)"')),nl,
	write(('To attack the monstors, type "attack(<monstor>,<weapon>)"')),nl,
	write(('To move to a room, type "goto(<room>)"')),nl,
	write(('Please maximise this window, and good luck, have fun!')).

/* health! */
health(100).
	
/* looking rule */
look:-
	here(A),
	write([' You are in the ', A]),
	nl,
	nl,
	health(X),
	write([' Your health is : ',X, '/100']),
	nl,
	nl,
	write([' Your inventory contains: ']),
	nl,
	nl,
	inventory,
	write([' You can go the following rooms: ']),
	nl,
	nl,
	listConnections(A),!,
	write([' You can see the following things: ']),
	nl,
	nl,
	listThings(A),!.
	
/* where the agent is */
here(B):-
	room().		

/*weapon rule */
weapon_use(X):-
	weapon(X).
	
	
/* display inventory */
inventory:-
	have_rule(X),
	write(X),
	nl,
	fail.
	
inventory:-
	nl,!.
	

/* have -> check whether agent has X */
have_rule(X):-
	have(X),!.
	
have_rule(X):-
	write(('You have nothing in your inventory :( ')),nl,
	fail.
	


/* listing adjacent rooms */
listConnections(A):-
	connected(A,B),
	write((B)),
	nl,
	fail.

listConnections(A):-
	nl,!.


/* the connected rule tells us if two rooms share a door */
connected(X, Y):-
	door(X, Y);
	door(Y, X).

connected(X, Y):-
	door(X, Z), door(Z, X),
	connected(Z, Y).
	
/* listing things in room */
listThings(A):-
	things(A,B),
	write((B)),
	nl,
	fail.

listThings(A):-
	nl,!.


/* rule for things in room */
things(X, Y):-
	located(X, Y);
	located(Y, X).

things(X, Y):-
	located(X, Z), located(Z, Y),
	located(Z, Y).

/* rules to move between rooms */
goto(Room):-
	check_locked(Room),
	can_go(Room),
	move_to(Room),
	moved_to_street(Room),
	moved_to_dungeon(Room),
	look.

check_locked(Room):-
	unlocked(Room),!.
	
check_locked(Room):-
	write(('You cannot enter as the room is locked.')),nl,
	look,fail.

can_go(Room):-
	here(dungeon),
	located(dungeon, giant_bats),
	write(('You cannot go anywhere until the bats are killed! ')),nl,batbite,
	!,
	fail.
	
can_go(Room):-
	here(A),
	connected(A,Room),!.
		
can_go(Room):-
	here(A),
	write(('You cannot go from ',A, 'to' ,Room)),nl,
	fail.

move_to(Room):-
	retract(here(_)),
	asserta(here(Room)).
	
moved_to_street(Room):-
	here(street),
	have(treasure),
	write(('You have won the game!')),nl,
	end,!.

moved_to_street(Room):-
	here(street),
	write(('You cannot leave till you have the treasure!')),nl,
	retract(here(street)),
	asserta(here(hall)),!.

moved_to_street(Room):-
	true.

moved_to_dungeon(Room):-
	here(dungeon),
	located(dungeon, giant_bats),
	write(('Kill the bats quickly!!')),nl,
	write(('Kill the bats quickly!!')),nl,
	write(('Kill the bats quickly!!')),nl,
	write(('Kill the bats quickly!!')),nl,
	write(('Kill the bats quickly!!')),nl,
	write(('Kill the bats quickly!!')),nl,!.

moved_to_dungeon(Room):-
	write(('There are no bats here =]')),nl,!.
	
	
/* rules to take items */
take(Item):-
	is_item(Item),
	can_take(Item),
	obtain(Item),
	look,!.
	
take(Item):-
	write(('You cannot take this!!')),nl,nl,
	look,
	fail.
		
can_take(Item):-
	here(dungeon),
	located(dungeon, giant_bats),
	write(('You cannot take anything until the bats are killed! ')),nl,batbite,
	!,
	fail.
	
can_take(Item):-
	here(A),
	located(A,Item),!.
	
can_take(Item):-
	here(A),
	located(A,B),
	located(B,Item),
	located(B,Item).
	
can_take(Item):-
	write(('You cannot take the item ',Item, 'from here!')),nl,
	fail.
	
obtain(Item):-
	asserta(have(Item)),
	retract(located(A,Item));
	retract(located(B,Item)).

	
/* rules to open doors. open X with Y */
open(X,Y):-
	here(A),
	connected(A,X),
	locked(X),
	have(Y),
	correct_key(X,Y),
	retract(locked(X)),
	asserta(unlocked(X)),
	write((X, 'is now unlocked!')),nl,
	look,!.
	
open(X,Y):-
	here(A),
	connected(A,X),
	locked(X),
	have(Y),
	write(('Wrong key')),
	look,!.
	
open(X,Y):-
	here(A),
	connected(A,X),
	locked(X)
	write(('You need the Key!!)),
	look,!.
	
/* rules to attack. attack X with Y */
attack(X,grenade):-
	here(A),
	enemy(X),
	have(grenade),
	retract(located(A,X)),
	write(('You blew the ',X, 'up!')),nl,
	!.
	
attack(X,deagle):-
	here(A),
	enemy(X),
	have(deagle),
	retract(located(A,X)),
	write(('You shot the ',X, '!!')),nl,
	!.
	
attack(X,ak47):-
	here(A),
	enemy(X),
	have(ak47),
	retract(located(A,X)),
	write(('You obliterated the ',X, '!!')),nl,
	!.
		
attack(X,flamethrower):-
	here(A),
	enemy(X),
	have(flamethrower),
	retract(located(A,X)),
	write(('You burned the ',X, '!!')),nl,
	!.
	
attack(X,Y):-
	weapon(Y),
	write(('You do not have the weapon ',Y,' in your inventory!')),nl,!.
	
attack(X,Y):-
	write(('That is not a weapon!!')),nl,!.
	
/* Eating food! */
eat(Food):-
	eatable(Food),
	have(Food),
	refill,nl,
	retract(have(Food)),
	look.
	
/* Food to give health */
refill:-
	retract(health(X)),
	asserta(health(100))
	write(('Mmmm that filled me up!')),nl,
	write(('You have regained health!')),nl,!.
	
	
/* bat bite damage! */
batbite:-
	health(X),
	Y is X-25,
	retract(health(X)),
	asserta(health(Y)),
	write(('The bats have bitten you and taken 25 health!')),nl,!.	
	
end:-
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl,
	write(('congrats!!!')),nl.
	retractall.