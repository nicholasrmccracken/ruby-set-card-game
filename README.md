# Set Project

This is the CANS submission for the Set game project.

------------------------------------------------------------------------------------------------------------------------------------------------
Running program:

Debug Mode - takes you straight to the game program and runs only it (no main menu)
command line = 'ruby game.rb'

Full Game - begins by running menu UI allowing the user to choose a game mode, rules, or quitting the program
command line = 'ruby cli.rb'

------------------------------------------------------------------------------------------------------------------------------------------------
Overview:
Set is a visual card game in which the player is trying to create matches between sets of tree cards. The player is shown a set of 12 cards and is required to make the set between them. When one is found, the cards are removed from the board and three more are added. The player continues this process until all the cards in the deck have been shown. If a set cannot be found, three more cards are dealt onto the board and the user continues playing like normal until they are back to 12 cards.

There can be around 80 distinct cards in the deck, each has 4 characteristics with 3 possible values. The characteristics that define the card are: number, color, shape, shade. There are 3 possible values for each characteristic,

Number:
    1, 2, 3

Color:
    red, green, blue

Shape:
    diamond, squiggle, oval

Shade:
    none, partial, full

A set is acomplished by choosing a group of three cards each with all characteristics the same or different. In two player mode users go head to head against eachother to find a set first. Whoever finds the most sets of the two is declared the winner.

------------------------------------------------------------------------------------------------------------------------------------------------

Programmer comments:
This game was programmed in ruby. It consists of 5 classes each with its own corresponding .rb file. The following is a cursory overview of each class, with its corresponding methods and functionality listed.

board: this class handles display of the 12 cards the user has to choose from to make a set. It requires the card and deck classes to operate.

- initialize: creates the deck, shuffles it, then deals the cards
- add_cards: adds new cards to the list of ones visible to the plater. adds them 3 at a time only.
- remove_cards: removes any trio of cards given
- final_set_count: counts the number of sets on the board
- find_single_set: finds a set on the board for when the user asks for a hint
- print_board: prints the board to the screen along with the coordinate system
- print_col_nums: prints the columns of the coordinate system

card: represents a single card in the game of set. Each card has a specific set of characterisitcs that must be compared against eachother regularly. By instantiating the functionality into a class, comparisons and siplay is made much easier throughout the program.

- initialize: creates a new card with params, color, symbol, number, and shading
- self.set?: checks if a given trio of cards is a set
- format_card: returns the string representation of the card for display to the user
- color_code: colors the string to better display color characteristic to the user

cli: command line interface handles user input and output outside the normal gameplay inputs. This program handles the starting and rules menues

- start: this program outputs the opening message to the user, as well as giving them a choice of playing in one or two player mode, reading the rules, seing programmer notes, or quitting the game. every time a user finishes the game, they are brought back to the menu and given the options again
- rules: the rules method gives the user an option to explore certain aspects of the game in a bit more depth. they have the option to view an explaination of the display, how to read features, how to make a set, and leave to the menu

deck: this class uses methods in the card class to create a deck of all ~80 possible cards. While the user only sees 12-15 at a time the computer keeps a list of all the cards

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

player: represents the user of the game

- initialize: creates a new player class with a score of zero
- increment_score: adds one to players current score

------------------------------------------------------------------------------------------------------------------------------------------------
Style guidelines:

Code:
Use Ruby LSP linter extension or gem install rubocop.
Use markdown linter.
Use YARD documentation (Copilot can easily generate).
Use blocks and OOP principles if possible.

Git Branches:
Create a branch for features that are not completed within a single push.
Prefix branch names with descriptors of work being done and use dashes as separators (i.e. ‘feature/deck-card-classes’, ‘bugfix/’).

Git Commits:
Commit messages must have subject line (50 char max) and optional body copy (wrapped at 72 columns) separated by a blank line. (instructions w/ how to add body copy)
Subject lines should be capitalized and not end in a period.
Subject lines should be written in an imperative mood (Add, not Added / Adds).
Body copy must be wrapped at 72 columns.
Body copy must only contain what and why explanations, never how. How should be in documentation.

Example commit:

Summarize changes in around 50 characters or less

More detailed explanatory text, if necessary. Wrap it to about 72
characters or so. In some contexts, the first line is treated as the
subject of the commit and the rest of the text as the body. The
blank line separating the summary from the body is critical (unless
you omit the body entirely); various tools like `log`, `shortlog`
and `rebase` can get confused if you run the two together.

Explain the problem that this commit is solving. Focus on why you
are making this change as opposed to how (the code explains that).
Are there side effects or other unintuitive consequences of this
change? Here's the place to explain them.

Further paragraphs come after blank lines.

- Bullet points are okay, too

- Typically a hyphen or asterisk is used for the bullet, preceded
   by a single space, with blank lines in between, but conventions
   vary here

------------------------------------------------------------------------------------------------------------------------------------------------
Individual contributions:

Aysha:

- Imeplement play function
- Keep track/score of sets found
- Replace found set with new cards
- Final debugging help and comment documentation

Christopher:

- Implemented menu UI allowing user to navigate program
- Wrote and structured README file
- Created the rules page and options for reading
- Developed initial board and card format, writing initial skeleton for use of the board durring development
- Wrote game messages for initial boot up and rules messages

Nicholas:

- Made methods in Card, Deck, Board, and SetGame classes.
- Created Card attributes, methods and Deck attributes, methods.
- Added validation for user inputs in-game and inputs of class constructors.
- Implement additional features like selectable difficulty, hints, and multiplayer.

Sanju:

- Created preliminary module files (board, card, deck, game, player, rules)
- Created preliminary board functionality - initialized deck, display, replace cards, compute number of sets
- Loaded in appropriate files to be used in main (previous functionality, but has been moved)
- Updated deck and rules modules, created initial functionality of each to be used in main
- Called appropriate functions for testing
