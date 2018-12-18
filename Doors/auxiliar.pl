
:- ensure_loaded(board).
:- use_module(library(lists)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                    Auxiliary functions                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


getPiece(Board, X, Y) :-
  member(cell(X, Y), Board).


getFrontier(X1, Y1, X2, Y2, [FrontCoords, FrontValues], Value) :-
  nth1(Index, FrontCoords, frontier(X1,Y1,X2,Y2)),
  element(Index, FrontValues, Value),!.

getFrontier(X1, Y1, X2, Y2, [FrontCoords, FrontValues], Value) :-
  nth1(Index, FrontCoords, frontier(X2,Y2,X1,Y1)),
  element(Index, FrontValues, Value), !.


getFrontierRightDown(X1, Y1, X2, Y2, [FrontCoords, FrontValues], Value) :-
  nth1(Index, FrontCoords, frontier(X1,Y1,X2,Y2)),
  element(Index, FrontValues, Value).

getFrontierLeftUp(X1, Y1, X2, Y2, [FrontCoords, FrontValues], Value) :-
  nth1(Index, FrontCoords, frontier(X2,Y2,X1,Y1)),
  element(Index, FrontValues, Value).

neighborDown(Board,X,Y,RX,RY) :-
  getPiece(Board,X,Y),
  RX is X+1,
  RY is Y,
  getPiece(Board,RX,RY).

neighborUp(Board,X,Y,RX,RY) :-
  getPiece(Board,X,Y),
  RX is X-1,
  RY is Y,
  getPiece(Board,RX,RY).

neighborRight(Board,X,Y,RX,RY) :-
  getPiece(Board,X,Y),
  RX is X,
  RY is Y+1,
  getPiece(Board,RX,RY).

neighborLeft(Board,X,Y,RX,RY) :-
  getPiece(Board,X,Y),
  RX is X,
  RY is Y-1,
  getPiece(Board,RX,RY).

getDownFrontiers(Board,X,Y,Frontiers,Values, AccDownFrontiers,DownFrontiers) :-
  neighborDown(Board,X,Y,FX,FY),
  getFrontierRightDown(X,Y,FX,FY,[Frontiers,Values], Frontier),
  append(AccDownFrontiers,[Frontier],NewAccDF),
  getDownFrontiers(Board,FX,FY,Frontiers,Values,NewAccDF,DownFrontiers),!.
getDownFrontiers(_,_,_,_,_, AccDownFrontiers,AccDownFrontiers) :- !.

getUpFrontiers(Board,X,Y,Frontiers,Values, AccUpFrontiers,UpFrontiers) :-
  neighborUp(Board,X,Y,FX,FY),
  getFrontierLeftUp(X,Y,FX,FY,[Frontiers,Values], Frontier),
  append(AccUpFrontiers,[Frontier],NewAccUF),
  getUpFrontiers(Board,FX,FY,Frontiers,Values,NewAccUF,UpFrontiers).
getUpFrontiers(_,_,_,_,_, AccUpFrontiers,AccUpFrontiers) .

getLeftFrontiers(Board,X,Y,Frontiers,Values, AccLeftFrontiers,LeftFrontiers) :-
  neighborLeft(Board,X,Y,FX,FY),
  getFrontierLeftUp(X,Y,FX,FY,[Frontiers,Values], Frontier),
  append(AccLeftFrontiers,[Frontier],NewAccLF),
  getLeftFrontiers(Board,FX,FY,Frontiers,Values,NewAccLF,LeftFrontiers),!.
getLeftFrontiers(_,_,_,_,_, AccLeftFrontiers,AccLeftFrontiers) :- !.

getRightFrontiers(Board,X,Y,Frontiers,Values, AccRightFrontiers,RightFrontiers) :-
  neighborRight(Board,X,Y,FX,FY),
  getFrontierRightDown(X,Y,FX,FY,[Frontiers,Values], Frontier),
  append(AccRightFrontiers,[Frontier],NewAccRF),
  getRightFrontiers(Board,FX,FY,Frontiers,Values,NewAccRF,RightFrontiers),!.
getRightFrontiers(_,_,_,_,_, AccRightFrontiers,AccRightFrontiers) :- !.


getCellValue(Board,X,Y,CellValues,Value) :-
  nth1(Index, Board, cell(X,Y)),
  element(Index, CellValues, Value).

print_long_list([]) .  
print_long_list([H|T]) :-
    write(H), write('  '),
    print_long_list(T).

% new_read(-Option)
% reads one character at the time 
% ends when a newline is found returning the whole word in Option
new_read(Option) :-
  new_read('', Option), !.

% new_read(+Acc, -Option)
% reads one character at the time 
% ends when a newline is found
new_read(Acc, Option) :-
  get_char(Char),
  processChar(Char, Acc, Option).

% processChar(+Char, -Acc, -Option)
% reads one character at the time and adds it to Acc
% ends when a newline is found
processChar('\n', Acc, Acc).
processChar(Char, Acc, Option) :-
  atom_concat(Acc, Char, Res),
  new_read(Res, Option).

% print_InvalidOption
% Prints error message when an invalid option has been chosen
print_InvalidOption :-
  write('Invalid option! Please try again...').



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         draw board                            %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


getLinesN([],_, _, _, FinalList, FinalList) :- !.

getLinesN([H|T],N, Count, TmpList, FinalList, Res) :-
  append(TmpList,[H],NewTmpList),
  NewCount is Count+1,
  NewCount = N,
  append(FinalList,[NewTmpList], NewFL),
  getLinesN(T,N,0,[],NewFL,Res),!.

getLinesN([H|T],N, Count, TmpList, FinalList, Res) :-
  append(TmpList,[H],NewTmpList),
  NewCount is Count+1,
  getLinesN(T,N,NewCount,NewTmpList,FinalList,Res),!.


draw_board([H|T],CellValues,Frontiers,N) :-
    nl,
    getLinesN([H|T],N,0,[],[],Lines),
    drawLines([H|T],Lines, CellValues, Frontiers), !.
 

drawLines(_,[],_, _).

drawLines(Board,[H|T], CellValues,Frontiers) :-
  draw_line(Board,H,CellValues,Frontiers),
  draw_horizontal_frontiers(H,Frontiers),
  drawLines(Board,T,CellValues,Frontiers).

draw_line(_,[],_,_) :-
      nl.

draw_line(Board,[cell(X1,Y1)|T],CellValues,Frontiers) :-
     getCellValue(Board,X1,Y1,CellValues,Value),
     draw_cell(Value),
     Y2 is Y1 +1,
     draw_vertical_frontier(Frontiers,X1,Y1,X1,Y2),
     draw_line(Board,T,CellValues,Frontiers).

draw_cell(Value) :-
  Value < 10,
  write(' ') ,write(Value), write(' ').


draw_cell(Value) :-
  write(' ') ,write(Value), write('').


draw_horizontal_frontiers([],_) :-
       nl.


draw_horizontal_frontiers([cell(X1,Y1)|T],Frontiers) :-
     X2 is X1 +1 ,
    draw_horizontal_frontier(Frontiers,X1,Y1,X2,Y1),
    draw_horizontal_frontiers(T,Frontiers).


draw_horizontal_frontier(Frontiers,X1,Y1,X2,Y2) :-
    getFrontier(X1,Y1,X2,Y2,Frontiers, 1),
    write('---- ').

draw_horizontal_frontier(_,_,_,_,_) :-
    write('     ').

draw_vertical_frontier(Frontiers,X1,Y1,X2,Y2) :-
    getFrontier(X1,Y1,X2,Y2,Frontiers, 1),
    write(' |').

draw_vertical_frontier(_,_,_,_,_) :-
  write('  ').
