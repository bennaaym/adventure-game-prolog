:-dynamic currentLocation/1, inventory/1,hasObject/2.

/* define the connection between the different locations */

connected("forest of giants",[location(east,maze),location(south,dungeon)]).
connected(dungeon,[location(north,"forest of giants"),location(south,"final boss room"),location(east,forest)]).
connected("final boss room",[location(north,dungeon)]).
connected(forest,[location(west,dungeon),location(south,temple),location(east,village)]).
connected(temple,[location(north,forest)]).
connected(maze,[location(south,village),location(west,"foret of giants"),location(east,lake)]).
connected(village,[location(north,maze),location(south,"mage place"),location(east,"castle of drangleic"),location(west,forest)]).
connected("mage place",[location(north,village),location(east,"castle of drangleic"),location(south,underworld)]).
connected(underworld,[location(north,"mage place")]).
connected(lake,[location(west,maze)]).
connected("mountain of despair",[location(west,village)]).
connected("castle of drangleic",[location(west,"mage place")]).

/* define the connection between the main locations and sublocations */



hasPlace(temple,"treasure room").

hasPlace(village,house).
hasPlace(village,guild).


hasPlace(underworld,"reaper room").

hasPlace(lake,"water hole").

hasPlace("mountain of despair",hut).

hasPlace("castle of drangleic",cave).

/*define the connections between the mail locations and the characters */

hasChar(forest,"wise man").
hasChar("mage place",mage).

/*define the connections between the places and objects*/

hasObject("forest of giants","pheonix egg").
hasObject(maze,"flower of life").
hasObject(house,"egyptian sword").
hasObject("treasure room","egyptian treasure").
hasObject(guild,worriors).
hasObject(hut,"sword of souls").
hasObject(hut,"sun symbol").
hasObject("castle of drangleic",armor).
hasObject("castle of drangleic","moon symbol").
hasObject("reaper room","flames of regret").



/* define requirements to enter a specific room */
require("forest of giants",[worriors]):-!.
require("final boss room",["key of fire","key of water","key of earth","key of wind"]):-!.
require(temple,["egyptian sword"]):-!.
require(maze,["lantern of truth"]):-!.
require("castle of drangleic",["mage permission"]):-!.
require(underworld,["mage permission","sword of souls"]):-!.
require(lake,["sun symbol","moon symbol"]):-!.


require(_,[]).




/* describe environment */
description(dungeon):-
    nl,
    write("it's dark a cold fire, there is no one here ").

description("forest of giants"):-
    nl,
   write("the place is full of giants status and bodies, it's not a place you can survive it alone"),nl,
   write("with the help of the other warriors, you were able to defeat the giant creature that lives in this forest").



description(forest):-
    nl,
            write("it is  nice and quiet but be aware of it's not always as it looks like").

description(temple):-
    nl,
           write("you're inside an Egyptian temple"),nl,
           write("thanks to the **Egyptian sword** you were able to defeat the creature that protects this temple.").


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



description(house):-
    nl,
    write("pretty old house from the midlle ages").

description(guild):-
    nl,
    write("this is a place where warriors come to train, you might find someone to accompany you").


description(hut):-
    nl,
    write("such a miserable place, negative energy is everywhere, don't stay here long or ...").



/* define interaction with game characters */
talkTo("wise man"):-
  write_ln("Hello warrior, you're at the beginning of a long journey"),
  write_ln("I have a mission for you,"),
  write_ln("bring the hidden treasure inside the old temple and I'll give you the   **lantern of truth**"),
  write_ln("you will need it for the rest of the journey").



talkTo(mage):-
  write_ln("we can talk after you bring me the ** phoenix egg , flower of life **"),
  write_ln("try to check the maze and the forest of giants if you didn't yet").

/* define characters requirements */




/* define movement */

/*initial position when the game start*/

currentLocation(dungeon).


enter(_place):-
  currentLocation(_current),
  hasPlace(_current,_place),
  retract(currentLocation(_current)),
  assert(currentLocation(_place)),
  look,!.

enter(_):-
    currentLocation(_current),
    write("the is no such place in the "),
    write_ln(_current).


exit:-
    currentLocation(_place),
    hasPlace(_current,_place),
    retract(currentLocation(_place)),
    assert(currentLocation(_current)),
    write("you have exit from the "),
    write_ln(_place).


north:- move(north).
south:-move(south).
east:-move(east).
west:- move(west).

move(_direction):-
    currentLocation(_current),
    connected(_current,_locations),
    member(location(_direction,_destination),_locations),
    haveRequirement(_destination),
    retract(currentLocation(_current)),
    assert(currentLocation(_destination)),
    look,
    !.



move(_):-
    write("closed path !").


haveRequirement(_destination):-
    inventory(_collected),
    require(_destination,_requirements),
    subset(_requirements,_collected),!.

haveRequirement(_destination):-
    require(_destination,_requirements),
    write_ln("warrior, you aren't ready for this yet ..."),
    write_ln("you need :"),
    listRequirements(_requirements),
    fail.


/* explore envirement */
look:-
    currentLocation(_current),
    write("you're in the "),write(_current),
    description(_current),
    nl,
    connected(_current,_locations),
    getDirections(_locations),
    nl,
    listPlaces(_current),
    listChars(_current),
    listObjects(_current),
    !.
look:-
    currentLocation(_current),
    listPlaces(_current),
    listChars(_current),
    listObjects(_current),
    !.

getDirection(location(_direction,_)):-
    write("there is a path to :"),
    write(_direction),
    nl,!.



getDirections([]).
getDirections([_location|_rest]):-
    getDirection(_location),
    getDirections(_rest).




/*
listDirections(_current):-

    connected(_current,_direction,_),
    write("there is a path to "),
    write(_direction),
    nl,
    fail.

listDirections(_).
*/


listChars(_current):-
    hasChar(_current,_char),
    write("you can see :"),
    write_ln(_char),
    fail.
listChars(_).


listPlaces(_current):-
  hasPlace(_current,_place),
  write("you can see :"),
  write_ln(_place),
  fail,!.
listPlaces(_).


listObjects(_current):-
    hasObject(_current,_object),
    write("you can see :"),
    write_ln(_object),
    fail.
listObjects(_).



listRequirements([]).
listRequirements([H|Tail]):-
    tab(2),
    write("* "),
    write_ln(H),
    listRequirements(Tail).



/* interact with other objects */

inventory([]).

inventory:-
   inventory(_collected),
   listInventory(_collected).

listInventory([]):-!.
listInventory([_object1|Tail]):-
     tab(2),
     write("- "),
     write_ln(_object1),
     listInventory(Tail),
     !.




pick(_object):-
    currentLocation(_current),
    hasObject(_current,_object),
    retract(hasObject(_current,_object)),
    inventory(_collected),
    append([_object],_collected,_newInventory),
    retract(inventory(_collected)),
    assert(inventory(_newInventory)).


pick(_):-
    write_ln("what are you trying to pick !!!").


pickAll:-
    currentLocation(_current),
    hasObject(_current,_object),
    retract(hasObject(_current,_object)),
    inventory(_collected),
    append([_object],_collected,_newInventory),
    retract(inventory(_collected)),
    assert(inventory(_newInventory)),
    fail.

pickAll.


drop(_object):-
    currentLocation(_current),
    inventory(_collected),
    delete(_collected,_object,_newInventory),
    assert(hasObject(_current,_object)),
    retract(inventory(_collected)),
    asserta(inventory(_newInventory)).



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




/*utility functions */
