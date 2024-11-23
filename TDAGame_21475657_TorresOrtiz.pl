
:- use_module("TDAPlayer_21475657_TorresOrtiz.pl").
:- use_module("TDABoard_21475657_TorresOrtiz.pl").
:- use_module("TDAPiece_21475657_TorresOrtiz.pl").

%Descripcion: Predicado que permite crear una nueva partida.
%Dominio: player1 (player) X player2 (player) X board (board) X currentTurn (int).
%Constructor 

game(Player1, Player2, Board, CurrentTurn, [Player1, Player2, Board, CurrentTurn]):-
	integer(CurrentTurn),
	CurrentTurn > 0.


%Descripcion: Predicado que entrega por pantalla el estado actual del tablero en el juego.
%Dominio: Game X Board
%selector

game_get_board(Game, Board):-
	game(_, _, Board, _, Game).
