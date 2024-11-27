
:- module(game, [game/5, is_draw/1, get_current_player/2, game_get_board/2,get_player1/2, get_player2/2, get_current_turn/2, end_game/2,player_play/4, updated_player/5]).

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
	get_row(0, Board, Row),
	((Remaining_pieces_player1 = 0, Remaining_pieces_player2 = 0) ; \+ my_member(0,Row)).

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
	
%Descripcion: Predicado finaliza el juego actualizando las estadísticas de los jugadores según el resultado.
%Dominio: Game (game) X Game
%Modificador

end_game(Game, EndedGame):-
	get_player1(Game, Player1),
	get_player2(Game, Player2),
	game_get_board(Game, Board),
	get_current_turn(Game, CurrentTurn),
	update_stats(Game, Player1, NewStats1),
	update_stats(Game, Player2, NewStats2),
	game(NewStats1, NewStats2, Board, CurrentTurn, EndedGame).
	
%Descripcion: Predicado que realiza un movimiento.
%Dominio: game (game) X player (player) X column (int).
%Recorrido: game
%Modificador

player_play(Game, Player, Column, NewGame) :-
	Column < 7,
    get_current_player(Game, CurrentPlayer),
    game_get_board(Game, Board),
	((who_is_winner(Board, 1) ; who_is_winner(Board, 2) ; is_draw(Game)) ->
	fail ;
	get_id(Player, Id),
	get_id(CurrentPlayer, IdCurrent),
	Id == IdCurrent,
	( Id == 1 ->
	Piece = ["red"] ;
	Piece = ["yellow"]),
    play_piece(Board, Column, Piece, NewBoard),
    get_player1(Game, Player1),
    get_player2(Game, Player2),
    get_current_turn(Game, CurrentTurn),
    NewCurrentTurn is CurrentTurn + 1,
	updated_player(Player1, Player2, Player, NewPlayer1, NewPlayer2),
	game(NewPlayer1, NewPlayer2, NewBoard, NewCurrentTurn, CurrentNewGame),
    (is_draw(CurrentNewGame) ->
    end_game(CurrentNewGame, NewGame)
	; (who_is_winner(NewBoard, 1) ; who_is_winner(NewBoard, 2)) ->
    end_game(CurrentNewGame, NewGame)
	; NewGame = CurrentNewGame)).	
	

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

%Descripcion: Predicado que permite quitar una ficha al jugador que haya puesto una ficha.
%Dominio:  Player1 X Player2 X Player X NewPlayer1 X NewPlayer2
%auxiliar
	
updated_player(Player1, Player2, Player, NewPlayer1, NewPlayer2):-
    get_id(Player1, Id1),
    get_name(Player1, Name1),
    get_color(Player1, Color1),
    get_wins(Player1, Wins1),
    get_losses(Player1, Losses1),
    get_draws(Player1, Draws1),
    get_remaining_pieces(Player1, Remaining_pieces1),
    get_id(Player2, Id2),
    get_name(Player2, Name2),
    get_color(Player2, Color2),
    get_wins(Player2, Wins2),
    get_losses(Player2, Losses2),
    get_draws(Player2, Draws2),
    get_remaining_pieces(Player2, Remaining_pieces2),
    get_id(Player, Id),
    (Id == Id1 ->  
	(NewRemaining_pieces1 is Remaining_pieces1 - 1, 
    player(Id1, Name1, Color1, Wins1, Losses1, Draws1, NewRemaining_pieces1, NewPlayer1), 
    player(Id2, Name2, Color2, Wins2, Losses2, Draws2, Remaining_pieces2, NewPlayer2))
    ;(NewRemaining_pieces2 is Remaining_pieces2 - 1, 
    player(Id1, Name1, Color1, Wins1, Losses1, Draws1, Remaining_pieces1, NewPlayer1),
    player(Id2, Name2, Color2, Wins2, Losses2, Draws2, NewRemaining_pieces2, NewPlayer2))).