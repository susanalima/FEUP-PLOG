:- ensure_loaded(solver).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                         Start Function                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%start function
start :-
  firstMenu.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                             Menus                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% firstMenu
% Prints the initial menu and reads the user input
firstMenu :-
  print_FirstMenu,
  new_read(Option),
  firstMenu(Option).

firstMenu('1') :-
  nl,
  generatorAndSolver(8),
  firstMenu.

firstMenu('2') :-
  nl,
  generatorAndSolver(16),
  firstMenu.

firstMenu('3') :-
  nl,
  generatorAndSolver(24),
  firstMenu.

firstMenu('4') :-
  nl, 
  cutomizeSizeMenu.

firstMenu('5').

firstMenu(_) :-
  print_InvalidOption,
  firstMenu.

% print_FirstMenu
print_FirstMenu :-
  nl,
  write('******************************'),nl,
  write('**          DOORS           **'),nl,
  write('******************************'),nl,
  write('**                          **'),nl,
  write('** Board Size:              **'),nl,
  write('** 1- 8x8                   **'),nl,
  write('** 2- 16x16                 **'),nl,
  write('** 3- 24x24                 **'),nl,
  write('** 4- Make your own!!!      **'),nl,
  write('** 5- quit                  **'),nl,
  write('**                          **'),nl,
  write('******************************'),nl,
  write('Choose : '), nl.


% cutomizeSizeMenu
% Prints the customize board size menu and reads the user input
cutomizeSizeMenu :-
  print_CutomizeSizeMenu,
  new_read(Option),
  atom_chars(Option,Chars),
  getInteger(Chars,0,Size),
  generatorAndSolver(Size),
  firstMenu.

cutomizeSizeMenu :-
  print_InvalidOption,
  firstMenu.

% print_CutomizeSizeMenu
print_CutomizeSizeMenu :-
  nl,
  write('******************************'),nl,
  write('**   CUSTOMIZE BOARD SIZE   **'),nl,
  write('******************************'),nl, nl,
  write('Board Size: '), nl.




  

  