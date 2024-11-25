
:- module(game, [game/5, is_draw/1, get_current_player/2, game_get_board/2,get_player1/2, get_player2/2, get_current_turn/2, end_game/2,player_play/4, newplayer/8,updated_player/5]).

%Descripcion: Predicado que permite crear una nueva partida.
%Dominio: player1 (player) X player2 (player) X board (board) X currentTurn (int).
%Constructor 

game(Player1, Player2, Board, CurrentTurn, [Player1, Player2, Board, CurrentTurn]):-
	integer(CurrentTurn),
	CurrentTurn > 0.

%Descripcion: Predicado que verifica si el estado actual del juego es empate.
%Dominio: game (game)
%Otros

is_draw(Game):-
	get_player1(Game, Player1),
	get_player2(Game, Player2),
	get_remaining_pieces(Player1, Remaining_pieces_player1),
	get_remaining_pieces(Player2, Remaining_pieces_player2),
	game_get_board(Game, Board),
	who_is_winner(Board, Winner),
	Winner = 0,
	((Remaining_pieces_player1 = 0, Remaining_pieces_player2 = 0) ; \+ can_play(Board)).

%Descripcion: Predicado que obtiene el jugador cuyo turno está en curso.
%Dominio: Game 
%Recorrido: Player
%selector

get_current_player(Game, CurrentPlayer):-
	get_current_turn(Game, CurrentTurn),
	PlayerTurn is CurrentTurn mod 2,
	(PlayerTurn = 1 -> 
	get_player1(Game, Player1), 
	CurrentPlayer = Player1;     %Se asume que siempre partira el player1
	get_player2(Game, Player2),
	CurrentPlayer = Player2).

%Descripcion: Predicado que entrega por pantalla el estado actual del tablero en el juego.
%Dominio: Game X Board
%selector

game_get_board(Game, Board):-
	game(_, _, Board, _, Game).

%Descripcion: Predicado que obtiene el player1 de game
%Dominio: Game X Player1
%selector

get_player1(Game, Player1):-
	game(Player1, _, _, _, Game).

%Descripcion: Predicado que obtiene el player2 de game
%Dominio: Game X Player2
%selector

get_player2(Game, Player2):-
	game(_, Player2, _, _, Game).
	
%Descripcion: Predicado que obtiene el currentTurn del game
%Dominio: Game X CurrentTurn
%selector

get_current_turn(Game, CurrentTurn):-
	game(_, _, _, CurrentTurn, Game).