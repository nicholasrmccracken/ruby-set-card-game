# Set Project

This is the CANS submission for the Set game project.

## Table of Contents

- [Getting Started](#getting-started)
- [Set Overview](#set-overview)
- [Contributing](#contributing)
- [Individual Contributions](#individual-contributions)

## Getting Started

### Prerequisites

Install ruby v3.3.3 to ensure game is run as expected. You can check your version with:

```bash
ruby -v
```

### Running the Program

#### Full Game

Begins with a main menu, allowing the user to choose a game mode, read the rules, or quit.

```bash
ruby cli.rb
```

#### Debug Mode

Skips the main menu. Uses 'easy' difficulty to easily identify sets via hints.

```bash
ruby game.rb
```

## Set Overview

Set is a visual card game where the player's identifies matches between sets of three cards. At the start of the game, the player is shown a set of 12 cards to identify sets amongst. When the player identifies a set, the three cards are removed from the board and three more are added. The player continues this process until all the cards in the deck have been shown. If a set cannot be identified by the player, the player can deal three more cards.

There are 81 distinct cards in the deck, which each have 4 properties with 3 possible values. The properties that define the card are: number, color, shape, shade. The possible values for each property are listed below.

- Number: 1, 2, 3
- Color: red, green, blue
- Shape: diamond, squiggle, oval
- Shade: none, partial, full

### Game Rules

A set is a group of three cards, where each property of the cards is all the same or all different. The player's goal is to identify as many sets as possible. In multiplayer mode, players go head to head against each other to reach a certain number of found sets. Whoever reaches this value first is declared the winner. In addition to identifying sets, the player may also deal three more cards, or request a hint. The hint receieved is dependent on the difficulty selected by the player.

## Contributing

The set game was programmed using ruby v3.3.3. It was built with OOP principles. Each class has it's own file, and is included within a module shared by the entire program. The following is a cursory overview of each class, with its corresponding methods and functionality listed.

Board: this class handles display of the 12 cards the user has to choose from to make a set. It requires the card and deck classes to operate.

- initialize: creates the deck, shuffles it, then deals the cards
- add_cards: adds new cards to the list of ones visible to the plater. adds them 3 at a time only.
- remove_cards: removes any trio of cards given
- final_set_count: counts the number of sets on the board
- find_single_set: finds a set on the board for when the user asks for a hint
- print_board: prints the board to the screen along with the coordinate system
- print_col_nums: prints the columns of the coordinate system

Card: represents a single card in the game of set. Each card has a specific set of characterisitcs that must be compared against eachother regularly. By instantiating the functionality into a class, comparisons and siplay is made much easier throughout the program.

- initialize: creates a new card with params, color, symbol, number, and shading
- self.set?: checks if a given trio of cards is a set
- format_card: returns the string representation of the card for display to the user
- color_code: colors the string to better display color property to the user

CLI: command line interface handles user input and output outside the normal gameplay inputs. This program handles the starting and rules menues

- start: this program outputs the opening message to the user, as well as giving them a choice of playing in one or two player mode, reading the rules, seing programmer notes, or quitting the game. every time a user finishes the game, they are brought back to the menu and given the options again
- rules: the rules method gives the user an option to explore certain aspects of the game in a bit more depth. they have the option to view an explaination of the display, how to read features, how to make a set, and leave to the menu

Deck: this class uses methods in the card class to create a deck of all ~80 possible cards. While the user only sees 12-15 at a time the computer keeps a list of all the cards

- initialize: creates a deck of new cards one of each permutation
- shuffle: scrambles the deck into a random order
- deal_cards: puts 12 of the cards into an empty array

SetGame: this class contains the methods for the actual set gameplay.

- initialize: this is the main gameplay code for set. it takes in several parameters of which the variable ones are players, difficulty, and winning_score. Winning score and difficulty are set to 5 and medium respectively. Players is an array of strings containing all players names who wish to participaye.
- play_game: pays the game until the board is empty or a player wins
- play_round: plays a single round of the game depending on who the player is
- print_scoreboard: prints the score of each player
- player_coice: gets the users choice for the current round
- process_coice: processes the players choice and executes the apropriate action
- process_set_identification: process the players attempt to identify set
- process_valid_set: process a valid set identified by the player
- process_hint: process players request for a hint, hint is provided based on difficulty of the game
- parse_trio: gets a trio of cards from the user
- validate_trio: validates the row and column entered by yhe user
- valid_coordinates?: checks if the row and column are within the range of the board

Player: represents the user of the game

- initialize: creates a new player class with a score of zero
- increment_score: adds one to players current score

### Developer Style Guidlines

#### Code Style

Use Rubocop and a markdown linter for uniform style checking. Ruby LSP is a recommended VSCode extension.
Use YARD documentation for all methods and classes.
Write idomatic ruby. Choose blocks instead of loops when possible. Employ OOP design principles.

#### Git Style

Create a branch for features that will not be completed within a single push.
Prefix branch names with descriptors of work being done and use dashes as separators (i.e. ‘feature/deck-card-classes’, ‘bugfix/’).
Commit messages must have subject line (50 char max) and optional body copy (wrapped at 72 columns) separated by a blank line.
Subject lines should be capitalized and not end in a period.
Subject lines should be written in an imperative mood (i.e. 'Add', 'Implement', 'Fix').
Body copy must only contain what and why explanations, never how. How should be in documentation.

## Individual Contributions

Aysha:

- Imeplement play function.
- Keep track/score of sets found.
- Replace found set with new cards.
- Final debugging help and comment documentation.

Christopher:

- Implemented menu UI allowing user to navigate program.
- Wrote and structured README file.
- Created the rules page and options for reading.
- Developed initial board and card format, writing initial skeleton for use of the board durring development.
- Wrote game messages for initial boot up and rules messages.

Nicholas:

- Created Card, Deck, and SetGame classes.
- Implemented Card, Deck, Board, and SetGame along with core game logic.
- Added validation for user inputs in-game and inputs of class constructors.
- Created additional features like selectable difficulty, hints, and multiplayer.
- Added markdown features to README file.

Sanju:

- Created preliminary module files (board, card, deck, game, player, rules).
- Created preliminary board functionality - initialized deck, display, replace cards, compute number of sets.
- Loaded in appropriate files to be used in main (previous functionality, but has been moved).
- Updated deck and rules modules, created initial functionality of each to be used in main.
- Called appropriate functions for testing.
