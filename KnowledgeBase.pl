:-dynamic currentLocation/1.

/* define the connection between the different locations */

connected("forest of giants",east,maze).
connected("forest of giants",south,dungeon).

connected(dungeon,north,"forest of giants").
connected(dungeon,south,"final boss room").
connected(dungeon,east,forest).

connected(forest,west,dungeon).
connected(forest,south,temple).
connected(forest,east,village).


connected(temple,north,forest).


connected(maze,south,village).
connected(maze,west,"forest of giants").
connected(maze,east,lake).

connected(village,north,maze).
connected(village,south,"mage place").
connected(village,east,"mountain of despair").


connected("mage place",north,village).
connected("mage place",east,"casle of drangleic").
connected("mage place",south,underworld).


connected(underworld,north,"mage place").


connected(lake,west,maze).


connected("mountain of despair",west,village).

connected("castle of drangleic",west,"mage place").


/* define the connection between the main locations and sublocations */

hasPlace(temple,"treasure room").

hasPlace(village,house).
hasPlace(village,guild).


hasPlace(underworld,"reaper room").

hasPlace(lake,cave).

hasPlace("mountain of despair",house).

hasPlace("castle of drangleic",cave).

/*define the connections between the mail locations and the characters */

hasChar(forest,"wise man").
hasChar("mage place",mage).

/*define the connections between the places and objects*/




/* describe environment */
description(dungeon):-
    nl,
    write("it's dark a cold fire, there is no one here ").

description("forest of giants"):-
    nl,
   write("the place is full of giants status and bodies, it's not a place you can survive it alone").



description(forest):-
    nl,
            write("it is  nice and quiet but be aware of it's not always as it looks like").

description(temple):-
    nl,
           write("you're inside an Egyptian temple").


description("treasure room"):-
    nl,
           write("there is a treasure in the middle of the room").


description(village):-
    nl,
           write("a casual village with few citizens").



description(maze):-
    nl,
           write("you can't find your way without the lantern of truth").

description("mage place"):-
           write("a quiet place with a lot of magic power around").


description(underworld):-
    nl,
           write("you can see souls and hear their screams of regret").


description(lake):-
    nl,
           write("you can see a huge lake in front of you").


description("mountain of despair"):-
    nl,
          write("welcome to mountain of despair you can see death  bodies and skillets be carefull or you end like them").



description("castle of drangleic"):-
    nl,
         write("a good place to get an armor...").




/* define movement */

/*initial position when the game start*/

currentLocation(dungeon).


north:- move(north).
south:-move(south).
east:-move(east).
west:- move(west).

move(_direction):-
    currentLocation(_current),
    connected(_current,_direction,_destination),
    retract(currentLocation(_current)),
    assert(currentLocation(_destination)),
    look,
    !.



move(_):-
    write("closed path !").


/* explore envirement */
look:-
    currentLocation(_current),
    write("you're in the "),write(_current),
    description(_current),
    nl,
    listDirections(_current),
    nl,
    listChars(_current).



listDirections(_current):-

    connected(_current,_direction,_),
    write("the is a path to "),
    write(_direction),
    nl,
    fail.

listDirections(_).



listChars(_current):-
    hasChar(_current,_char),
    write_ln("you can see :"),
    write_ln(_char),
    fail.
listChars(_).








/* game entry */
start:-
    write("Hello warrior, welcome to the dungeon,"),nl,
    write("you came here looking after power, glory, and fortune."),nl,
    write("You're standing in front of the dungeon guardian"),nl,
    write("he will ask you a question,"),nl,
    write("you have to solve the next enigma in order to start your journey."),nl,
    write("if you respond wrongly you'll be killed by the guardian"),nl,
    write("do you want to accept ? (yes/no)"),nl,
    read(_decision),
    acceptFirstExam(_decision).



acceptFirstExam(yes):-
    nl,
    write_ln("you're a courageous warrior, this is you're enigma :"),
    write_ln("who is the human greatest enemy ?"),
    read(_answer),
    firstExamAnswer(_answer).

acceptFirstExam(_):-
    nl,
     write_ln("you're not qualified to get this journey .come back when you get strong"),nl.

firstExamAnswer(himself):-
    nl,
    write_ln("Gongrats you've passed your first test"),
    write_ln("you can start your journey now good luck"),
    write_ln(", you will need it..."),nl.
firstExamAnswer(_):-
    nl,
    write_ln("you're not qualified to get this journey . I'll take your soul now . shine!!").





/* ending game */

