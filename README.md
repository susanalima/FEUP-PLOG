# FEUP-PLOG

Projects developed for Logic Programming class.

Made in colaboration with [Gonçalo Santos](https://github.com/gregueiras).

## First Project - Manalath

### Specification 

Implementation of a PROLOG board game, with different game modes: 
  * Player against Player
  * Player against Computer
  * Computer against Computer

The game chosen, among a variety of options presented in the statement, was Manalath.

### Manalath

Manalath is played on a hexagonal board with 61 spaces. Each player has 30 pieces of an assigned color (usually black and white).

It starts with an empty board and, in each turn, the current player chooses a piece of any color (his or the opponent's) and places it in an empty space on the board. However, you can never place a piece in such a way that a group of more than 5 pieces is created. A group is formed by neighboring pieces, which have a common side.

If at the end of a player's turn there is a group of 5 pieces of his color, he wins. On the other hand, if there is a group of 4, the player loses. If both situations occur at the end of the round, the player loses. If there are no more possible moves, the game ends in a draw.

To see a 3D environment developed in WebGL to represent this game, go to [FEUP-LAIG repository](https://github.com/susanalima/FEUP-LAIG).

### Execution

Consult the file `main.pl` with  **SICStus Prolog** and start the game by typing `play.`. Then a menu with the available options will be presented.

## Second Project - Doors

### Specification

The main goal of this project was to consolidate and apply knowledge about Logic Programming with Restrictions (PLR). As such, the 2D  puzzle Doors was choosen, a decision problem.

### Doors

Doors is a 2D puzzle, based on a square board, of variable size, divided into square houses. Each house represents a room and the number inside it the number of houses visible (in the four directions and through open doors) from there and including the house itself. All cells are connected by doors, and are visible from the neighboring house if the door is open. The challenge is to strategically close the doors, so that the number inside each house represents the number of houses visible by it.

### Execution

Consult the file `menus.pl` with  **SICStus Prolog** and start the game by typing `start.`. Then a menu with the available options will be presented.
