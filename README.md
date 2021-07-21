# TEXT BASED ADVENTURE GAMES WITH PROLOG

<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
        <li><a href="#purpose">Purpose</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li>
      <a href="#instructions">The Game Instructions</a>
      <ul>
        <li><a href="#starting-the-game">Starting The Game</a></li>
        <li><a href="#checking-the-inventory">Checking The Inventory</a></li>
        <li><a href="#exploring-the-surroundings">Exploring The Surroundings</a></li>
        <li><a href="#entering-close-places">Entering Close Places</a></li>
        <li><a href="#exiting-close-places">Exiting Close Places</a></li>
        <li><a href="#moving-around-places">Moving Aroud Places</a></li>
        <li><a href="#picking-objects">Picking Objects</a></li>
        <li><a href="#droping-objects">Droping Objects</a></li>
        <li><a href="#talking-to-characters">Talking to Characters</a></li>
        <li><a href="#giving-objects">Giving Objects</a></li>
      </ul>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#links">Links</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://github.com/bennaaym/adventure-game-prolog.git)
This project is a basic text-based adventure game. The idea of the game was inspired by [Colossal Cave Adventure](https://en.wikipedia.org/wiki/Colossal_Cave_Adventure).

- The player will go through an adventurous quest in search of 4 keys (key to wind, fire, earth, water). In order to find these keys, the player has to visit different places and collect different items.
- A simple natural language parser (NLP) has been implemented using Prolog to allow the player to utilize a simple subset of English.
- The player can use the map at the top to help him understand and visualize the game 




### Built With

* [Prolog](https://www.swi-prolog.org/)

### Purpose
This project was mainly built  to achieve the following objectives
* Have a top-down understanding of the logic programming paradigm
* Become familiar with Prolog
* Have a basic understanding of how prolog is used in Computational Linguistics

<!-- GETTING STARTED -->
## Getting Started

### Prerequisites
* [SWI-Prolog](https://www.swi-prolog.org/)

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/bennaaym/adventure-game-prolog.git
   ```
2. Open and compile KnowledgeBase.pl using [SWI-Prolog](https://www.swi-prolog.org/)

3. Check the game [instructions](#instructions) below


<!--INSTRUCTIONS-->

## Instructions

   #### Starting The Game
   ```sh
      start 
   ```
   #### Checking The Inventory
   - ```sh
      check inventory  
     ```
   - ```sh
      inventory  
     ```
   #### Exploring The Surroundings
   - ```sh
      look around  
     ```
   - ```sh
      look  
     ```
   - ```sh
      observe  
     ```
   #### Entering Close Places
   - ```
      enter [name of the place] for example enter water hole
     ```
   - ```
      go into [name of the place] for example go into water hole  
     ```
     
   #### Exiting Close Places
   - ```
      exit
     ```
   - ```
      go out 
     ```
   #### Moving Around Places
   - ```
      move [direction] for example move north
     ```
   - ```
      go [direction] for example go north 
     ```
   - ```
      [direction] for example north
     ```
     
  #### Picking Objects 
   - ```
      pick all
     ```
   - ```
      pick [name of the object] for example pick egyptian sword
     ```
     
  #### Droping Objects 
   - ```
      drop [name of the object]
     ```
   - ```
      pick [name of the object] for example drop egyptian sword
     ```
  #### Talking to Characters 
   - ```
      talk to [character's name] for example talk to wise man
     ```
   - ```
      ask [character's name] for example ask mage
     ```
     
  #### Giving Objects 
   - ```
      give [character's name] [object_1] and [object_2] and ... and [object_n] for example give mage flower of life and phoenix egg
     ```
  
   
<!-- LICENSE -->
## License
[![MIT License][license-shield]][license-url]<br>
Distributed under the MIT License. See `LICENSE` for more information.



<!-- CONTACT -->
## Links

* Project repo: [https://github.com/bennaaym/adventure-game-prolog.git](https://github.com/bennaaym/adventure-game-prolog.git)





<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/bennaaym/adventure-game-prolog/blob/main/LICENSE
[product-screenshot]: https://i.ibb.co/nk46qtk/screely-1626455090888.png
