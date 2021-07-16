:-dynamic currentLocation/1, inventory/1,hasObject/2,charSpeech/2,
    bossNarrative/2,finished/1.
/* defines the connection between the different locations */

connected("forest of giants",[location(east,maze),location(south,dungeon)]).
connected(dungeon,[location(north,"forest of giants"),location(south,"final boss room"),location(east,forest)]).
connected(forest,[location(west,dungeon),location(south,temple),location(east,village)]).
connected(temple,[location(north,forest)]).
connected(maze,[location(south,village),location(west,"forest of giants"),location(east,lake)]).
connected(village,[location(north,maze),location(south,"mage place"),location(east,"mountain of despair"),location(west,forest)]).
connected("mage place",[location(north,village),location(east,"castle of drangleic"),location(south,underworld)]).
connected(underworld,[location(north,"mage place")]).
connected(lake,[location(west,maze)]).
connected("mountain of despair",[location(west,village)]).
connected("castle of drangleic",[location(west,"mage place")]).

/* defines the connection between the main locations and sublocations */

hasPlace(temple,["treasure room"]).
hasPlace(village,[house,guild]).
hasPlace(underworld,["reaper room"]).
hasPlace(lake,["water hole"]).
hasPlace("mountain of despair",[hut]).
hasPlace("castle of drangleic",[cave]).

/*defines the connections between the main locations and the characters */

hasChar(forest,"wise man").
hasChar("mage place",mage).

/*defines the connections between the places and objects*/

hasObject("forest of giants",["phoenix egg","key of earth"]).
hasObject(maze,["flower of life"]).
hasObject(house,["egyptian sword"]).
hasObject("treasure room",["egyptian treasure"]).
hasObject(guild,[warriors]).
hasObject(hut,["sword of souls","sun symbol"]).
hasObject("castle of drangleic",[armor,"moon symbol"]).
hasObject("reaper room",["flames of regret"]).
hasObject("water hole",["key of water","sword of ice and fire"]).
hasObject(cave,["key of wind"]).
hasObject(underworld,["key of fire"]).


/* defines requirements to enter a specific location */
require("forest of giants",[warriors]):-!.
require("final boss room",["key of fire","key of water","key of earth","key of wind",armor,"sword of ice and fire"]):-!.
require(temple,["egyptian sword"]):-!.
require(maze,["lantern of truth"]):-!.
require("castle of drangleic",["mage permission"]):-!.
require(underworld,["mage permission","sword of souls"]):-!.
require(lake,["sun symbol","moon symbol","magic stick","flames of regret"]):-!.
require(_,[]).

/* Bosses narrative */

bossNarrative(giant,"with the help of the other warriors, you were able to defeat the giant creature that lives in this forest").

bossNarrative(cerberus,"Cerberus attacked you from no where ... , you were able to kill him using the power of sword of souls").

bossNarrative(aquaDragon,"the monster protecting this place attacked you. the monster protecting this place attacked you. you used the power of the magic stick,moon symbol and sun symbol to evaporate the lake").

bossNarrative("egyptian creature","thanks to the **Egyptian sword** you were able to defeat Egyptian boss that protects this temple.").


writeNarrative(_boss):-
     nl,
     bossNarrative(_boss,_narrative),
     write_ln(_narrative),
     retract(bossNarrative(_boss,_narrative)),
     assert(bossNarrative(_boss,"")).


/* describe environment */
description(dungeon):-
    nl,
    write("it's dark a cold fire, there is no one here ").

description("forest of giants"):-
    nl,
   write("the place is full of giants status and bodies, it's not a place you would survive it alone"),
   nl,
   writeNarrative(giant).




description(forest):-
    nl,
            write("it is  nice and quiet but be aware of it's not always as it looks like").

description(temple):-
    nl,
           write("you're inside an Egyptian temple"),nl,
           writeNarrative("egyptian creature").

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
           write("you can see souls and hear their screams of regret"),
           writeNarrative(cerberus).


description(lake):-
    nl,
           write("you can see a huge lake in front of you"),nl,
           writeNarrative(aquaDragon).


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

description(cave):-
    nl,
    write("a pretty cold cave, you can hear the drop of water a powerfull wind is coming from the inside").

description("water hole"):-
    write("you can't see much").

description("reaper room"):-
    write("flames are every where around ...").




description("final boss room"):-
    nl,
    write("the boss attacked  you but your armor is solid enough to protect you"),
    nl,
    write("using the sword of ice and fire you killed the final boss"),
    nl,
    write("a secret door opened you can see the one piece of this world"),
    nl,
    write("it is the treasure that can give you all what you need"),
    nl,
    write("power,glory and fortune"),
    nl,
    retract(finished(no)),
    asserta(finished(yes)),
    write("***********************end**********************").

/* define characters requirements and gifts */
charRequire("wise man",["egyptian treasure"]).
charRequire(mage,["flower of life","phoenix egg"]).


charGive("wise man",["lantern of truth"]).
charGive(mage,["mage permission","magic stick"]).


charSpeech("wise man","Hello warrior, you're at the beginning of a long journey. I have a mission for you, bring me the egyptian treasure inside the old temple and I'll give you the **lantern of truth**.you will need it for the rest of the journey").

charSpeech(mage,"we can talk after you bring me the ** phoenix egg , flower of life **.try to check the maze and the forest of giants if you didn't yet").


/* defines interactions with game characters */
talkTo(_char):-
  currentLocation(_current),
  hasChar(_current,_char),
  charSpeech(_char,_speech),
  write_ln(_speech).


talkTo(_):-
    write_ln("who are you talking too !!!").


give(_char,_objects):-
    currentLocation(_current),
    hasChar(_current,_char),
    charRequire(_char,_requirement),
    subset(_objects,_requirement),
    inventory(_collected),
    subset(_objects,_collected),
    subtract(_collected,_objects,_newInventory),
    charGive(_char,_gives),
    append(_newInventory,_gives,_newInventory2),
    retract(inventory(_collected)),
    asserta(inventory(_newInventory2)),
    write("Great job warrior, I give you"),
    write_ln(_gives),
    write_ln("check your inventory"),
    charSpeech(_char,_speech),
    retract(charSpeech(_char,_speech)),
    asserta(charSpeech(_char,"sorry warrior, I can't offer you more objects")),

    !.

give(_,_):-
     write_ln("warrior!! what are you trying to do").



/* define movement */

/*initial position when the game start*/

currentLocation(dungeon).


/* entering and exiting closed locations */

enter(_place):-
  currentLocation(_current),
  hasPlace(_current,_places),
  member(_place,_places),
  retract(currentLocation(_current)),
  asserta(currentLocation(_place)),
  look,!.

enter(_):-
    currentLocation(_current),
    write("the is no such place in the "),
    write_ln(_current).


exit:-
    currentLocation(_place),
    hasPlace(_current,_places),
    member(_place,_places),
    retract(currentLocation(_place)),
    assert(currentLocation(_current)),
    write("you have exit from the "),
    write_ln(_place).


/* moving from a main location to another */

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
    write_ln("closed path !").


/* defines contraints to access some locations */

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

/* in case of a closed location */
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



listChars(_current):-
    hasChar(_current,_char),
    write("you can see :"),
    write_ln(_char),
    fail.
listChars(_).





listPlaces(_current):-
  hasPlace(_current,_places),
  listPlaces(_places),
  !.

listPlaces([]).
listPlaces([_place|_rest]):-
    write("you can see :"),
    write_ln(_place),
    listPlaces(_rest).

listPlaces(_).


listObjects(_current):-
    hasObject(_current,_objects),
    listObjects(_objects),
    !.

listObjects([]).
listObjects([_object|_rest]):-
    write("you can see :"),
    write_ln(_object),
    listObjects(_rest).

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
     inventory([]),
     write_ln("your inventory is empty try to collect some objects first :) "),
     !.

inventory:-
   inventory(_collected),
   listInventory(_collected).

listInventory([]):-!.
listInventory([_object1|Tail]):-
     tab(2),
     write("- "),
     write_ln(_object1),
     listInventory(Tail).



pick(_object):-
    currentLocation(_current),
    hasObject(_current,_objects),
    member(_object,_objects),
    delete(_objects,_object,_rest),
    retract(hasObject(_current,_objects)),
    asserta(hasObject(_current,_rest)),
    inventory(_collected),
    append([_object],_collected,_newInventory),
    retract(inventory(_collected)),
    assert(inventory(_newInventory)).


pick(_):-
    write_ln("what are you trying to pick !!!").


pickAll:-
    currentLocation(_current),
    hasObject(_current,_objects),
    retract(hasObject(_current,_objects)),
    inventory(_collected),
    append(_objects,_collected,_newInventory),
    retract(inventory(_collected)),
    asserta(inventory(_newInventory)),
    !.

pickAll:-
     write_ln("there is nothing pickable here").


drop(_object):-
    currentLocation(_current),
    inventory(_collected),
    member(_object,_collected),
    delete(_collected,_object,_newInventory),
    hasObject(_current,_objects),
    append([_object],_objects,_newObjects),
    retract(hasObject(_current,_objects)),
    asserta(hasObject(_current,_newObjects)),
    retract(inventory(_collected)),
    asserta(inventory(_newInventory)),
    !.
drop(_object):-
     currentLocation(_current),
     inventory(_collected),
     member(_object,_collected),
     delete(_collected,_object,_newInventory),
     asserta(hasObject(_current,[_object])),
     retract(inventory(_collected)),
     asserta(inventory(_newInventory)),
     !.

drop(_):-
    write_ln("what are you trying to drop !!!").



/* game entry */

/* game entry point */
start:-
    asserta(finished(no)),
    nl,
    write("Hello warrior, welcome to the dungeon,"),nl,
    write("you came here looking after power, glory, and fortune."),nl,
    write("You're standing in front of the dungeon guardian"),nl,
    write("he will ask you a question,"),nl,
    write("you have to solve the next enigma in order to start your journey."),nl,
    write("if you respond wrongly you'll be killed by the guardian"),nl,
    write("do you want to accept ? (yes/no)"),nl,
    readln(_decision),
    delete(_decision,.,_decision2),
    acceptFirstExam(_decision2),
    look,
    gameLoop,
    !.
start.



gameLoop:-
     repeat,
     process_sentence(_c),
     execute_command(_c),
     (_c==quit; end).



execute_command(instructions):-instructions,!.
execute_command(look):-look,!.
execute_command(inventory):-inventory,!.
execute_command(north):-north,!.
execute_command(east):-east,!.
execute_command(south):-south,!.
execute_command(west):-west,!.
execute_command(move(_direction)):-move(_direction),!.
execute_command(enter(_place)):-enter(_place),!.
execute_command(exit):-exit,!.
execute_command(pick(_object)):- pick(_object),!.
execute_command(pickAll):-pickAll,!.
execute_command(drop(_object)):-drop(_object),!.
execute_command(talkTo(_char)):-talkTo(_char),!.
execute_command(give((_char,_objects))):-give(_char,_objects),!.
execute_command(quit):-quit,!.

execute_command(_):-
     write_ln("warrior, what are you trying to say !!!"),!.


quit:-
     write_ln("you quit the game").



end:-
     finished(yes),!.


answersPool([himself,"himself","human himself","human","itself"]).

acceptFirstExam([yes]):-
    nl,
    write_ln("you're a courageous warrior, this is you're enigma :"),
    write_ln("who is the human greatest enemy ?"),
    readln(_answer),
    delete(_answer,.,_answer2),
    firstExamAnswer(_answer2),
    !.

acceptFirstExam(_):-

    nl,
     write_ln("you're not qualified to get this journey .come back when you get strong"),
     nl,
     retract(finished(no)),
     asserta(finished(yes)),
     fail.


firstExamAnswer([H|_]):-
    answersPool(_possibleAnswers),
    member(H,_possibleAnswers),
    nl,
    write_ln("Gongrats you've passed your first test"),
    write_ln("you can start your journey now good luck"),
    write_ln(", you will need it..."),nl,
    !.

firstExamAnswer(_):-
    nl,
    write_ln("you're not qualified to get this journey . I'll take your soul now . shine!!"),
    retract(finished(no)),
     asserta(finished(yes)),
     fail.





/* NLP */

process_sentence(_c):-
     nl,
     readln(_s),
     delete(_s,.,_s2),
     sentence(_parsedList,_s2,[]),
     _c=.._parsedList,
     !.

process_sentence(_):-
         write_ln("warrior, are you trying to say something ?"),fail.

sentence([_pred,_arg])-->verb(_pred,_type),nounphrase(_type,_arg).
sentence([_pred])-->pred(_pred).



verb(move,player_move)-->[go];[move].
verb(talkTo ,talk_to_char)-->[talk, to];[ask].
verb(give,give_char)-->[give].
verb(enter,enter_place)-->[enter];[go,into].
verb(pick,pick_object)-->[pick].
verb(drop,drop_object)-->[drop].

nounphrase(_type,_noun)-->determiner,noun(_type,_noun).
nounphrase(_type,_noun)-->noun(_type,_noun).

determiner-->[the].
determiner-->[a].


noun(player_move,_arg)-->pred(_arg).
noun(talk_to_char,_arg)-->[_arg].
noun(talk_to_char,"wise man")-->[wise,man].
noun(give_char,(mage,["phoenix egg","flower of life"]))-->
    [mage,phoenix,egg,and,flower,of,life];[mage,flower,of,life,and,phoenix,egg].
noun(give_char,("wise man",["egyptian treasure"]))-->[wise,man,egyptian,treasure].
noun(enter_place,_args)-->[_args].
noun(enter_place,"treasure room")-->[treasure,room].
noun(enter_place,"reaper room")-->[reaper,room].
noun(enter_place,"water hole")-->[water,hole].

noun(pick_object,"phoenix egg")-->[phoenix,egg].
noun(pick_object,"egyptian treasure")-->[egyptian,treasure].
noun(pick_object,"flower of life")-->[flower,of,life].
noun(pick_object,"egyptian sword")-->[egyptian,sword].
noun(pick_object,"sword of souls")-->[sword,of,souls].
noun(pick_object,warriors)-->[warriors].
noun(pick_object,armor)-->[armor].
noun(pick_object,"sun symbol")-->[sun,symbol].
noun(pick_object,"moon symbol")-->[moon,symbol].
noun(pick_object,"key of earth")-->[key,of,earth].
noun(pick_object,"key of fire")-->[key,of,fire].
noun(pick_object,"key of wind")-->[key,of,wind].
noun(pick_object,"key of water")-->[key,of,water].
noun(pick_object,"sword of ice and fire")-->[sword,of,ice,and,fire].
noun(pick_object,"flames of regret")-->[flames,of,regret].


noun(drop_object,"phoenix egg")-->[phoenix,egg].
noun(drop_object,"egyptian treasure")-->[egyptian,treasure].
noun(drop_object,"flower of life")-->[flower,of,life].
noun(drop_object,"egyptian sword")-->[egyptian,sword].
noun(drop_object,"sword of souls")-->[sword,of,souls].
noun(drop_object,warriors)-->[warriors].
noun(drop_object,armor)-->[armor].
noun(drop_object,"sun symbol")-->[sun,symbol].
noun(drop_object,"moon symbol")-->[moon,symbol].
noun(drop_object,"key of earth")-->[key,of,earth].
noun(drop_object,"key of fire")-->[key,of,fire].
noun(drop_object,"key of wind")-->[key,of,wind].
noun(drop_object,"key of water")-->[key,of,water].
noun(drop_object,"sword of ice and fire")-->[sword,of,ice,and,fire].
noun(drop_object,"flames of regret")-->[flames,of,regret].
noun(drop_object,something)-->[_|_].





pred(look)-->[look].
pred(look)-->[look,around].
pred(look)-->[observe].
pred(exit)-->[exit].
pred(exit)-->[go,out].
pred(inventory)-->[inventory].
pred(inventory)-->[check,inventory].
pred(north)-->[north].
pred(east)-->[east].
pred(south)-->[south].
pred(west)-->[west].
pred(pickAll)-->[pick,all].
pred(quit)-->[quit].
pred(himself)-->[himself].



