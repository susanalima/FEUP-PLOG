:- ensure_loaded(includes).

display_game(Board, Player) :-
  print_player(Player),
  print_board(Board).

tp :-
  initial_board(_B), print_board(_B).



%mudar de lugar, para ja meti aqui por causa do includes (nao me odeies dps tiro)

printInvalidPlay :-
  write('Invalid Play!!!'),nl.

printWinnerPlay :-
  write('Winner Play!!!'),nl.

printLoserPlay :-
  write('Loser Play!!!'),nl.

playPiece(Board, X, Y, Color, NewBoard) :-
  getPiece(Board,X,Y,_S),
  _S = emptyCell,
  setPiece(Board, X, Y, Color, NewBoard). 

checkPlay(Board,Player,Color,Count, ValidPlay,OldBoard,NewBoard) :-
  Count >= 6,
  ValidPlay = -1, %jogada invalida, arranjar uma cena mais bonitinha maybe
  NewBoard = OldBoard, %if the play is not a valid one then the board is not updated
  printInvalidPlay.

checkPlay(Board,Player,Color,Count, ValidPlay,OldBoard,NewBoard) :-
  checkColorPlayer(Player,Color),
  Count == 5,
  ValidPlay = 0, %ganhou, arranjar uma cena mais bonitinha maybe
  NewBoard = Board, %updates the board
  printWinnerPlay.

checkPlay(Board,Player,Color,Count, ValidPlay,OldBoard,NewBoard) :-
  checkColorPlayer(Player,Color),
  Count == 4,
  ValidPlay = 1, %perdeu, arranjar uma cena mais bonitinha maybe
  NewBoard = Board, %updates the board
  printLoserPlay.

checkPlay(Board,Player,Color,Count, ValidPlay,OldBoard,NewBoard) :-
  %Count < 4,
  ValidPlay = 2, %jogada valida, arranjar uma cena mais bonitinha maybe
  NewBoard = Board.  %updates the board

checkValidPlay(ValidPlay,End):-
  ValidPlay = 0;
  ValidPlay = 1,
  End = 1.

checkValidPlay(ValidPlay,End):-
  End = 0.


setPlay(Board, Player, X, Y, Color, NewBoard, NewPlayer,End) :-
  playPiece(Board, X, Y, Color, TmpBoard),
  countCellNeighbors(TmpBoard,X,Y,Color,NrNeighbors), 
  checkPlay(TmpBoard,Player,Color,NrNeighbors,ValidPlay,Board,NewBoard),
  switchCurrentPlayer(Player,NewPlayer,ValidPlay),
  checkValidPlay(ValidPlay,End).

setPlay(Board, Player, X, Y, Color, NewBoard, NewPlayer,End) :-
  \+ playPiece(Board, X, Y, Color, TmpBoard),
  NewBoard = Board,
  NewPlayer = Player,
  End = 0,
  printInvalidPlay.

play(Board, Player, X, Y, Color, NewBoard, NewPlayer,End) :-
  setPlay(Board, Player, X,Y,Color, NewBoard, NewPlayer, End).
  %display_game(NewBoard,NewPlayer), !. %prints the new board

%to be improved
read_info(X,Y, Color) :-
  write('x-coordinate: '),
  read(X),
  write('y-coordinate: '),
  read(Y),
  write('color: '),
  read(Color).

%some trouble using this functions to validate the input from read_info
validate_info_Color(Color, Valid) :-
  Color = blackPiece,
  Valid = 1. %is valid

validate_info_Color(Color, Valid) :-
  Color = whitePiece,
  Valid = 1. %is valid

validate_info_Color(Color, Valid) :-
  Valid = 0. %is not valid

validate_info_coords(Board,X,Y, Valid) :-
  getPiece(Board,X,Y,_C),
  Valid = 1. %is valid

validate_info_coords(Board,X,Y, Valid) :-
  Valid = 0. %is not valid

play_game_loop(Board,Player,End) :-
   End = 1,
   display_game(Board,Player), !.

play_game_loop(Board, Player, End) :-
  display_game(Board,Player), !,
  read_info(X,Y, Color), %does not validate the input, the coordinates are validated after but if the color is wrong it explodes
  play(Board,Player,X,Y,Color,NewBoard,NewPlayer, New_End),
  play_game_loop(NewBoard,NewPlayer,New_End).

play_game :-
  initial_board(Board),
  play_game_loop(Board,1,0).
