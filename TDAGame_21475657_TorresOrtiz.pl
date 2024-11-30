
:- module(game, [game/5, game_history/2, is_draw/1, get_current_player/2, game_get_board/2,get_player1/2, get_player2/2, get_current_turn/2, get_history/2, end_game/2,player_play/4, updated_player/5]).

%Descripcion: Predicado que permite crear una nueva partida.
%Dominio: player1 (player) X player2 (player) X board (board) X currentTurn (int).
%Meta primaria: game/5.
%Constructor 

game(Player1, Player2, Board, CurrentTurn, [Player1, Player2, Board, CurrentTurn,[]]):-   %se agrega una lista vacia para almacenar el historial
	is_list(Player1),
	is_list(Player2),
	integer(CurrentTurn),
	CurrentTurn > 0.
	

game(Player1,Player2,Board,CurrentTurn,History,[Player1,Player2,Board,CurrentTurn,History]).  %Se le asigna nombre a la lista vacia

%Descripcion: Predicado que genera un historial de movimientos de la partida.
%Dominio: game (game) X history (list)
%Meta primaria: game_history/2
%Meta secundaria: get_history/2
%Otros

game_history(Game, History) :-
    get_history(Game, CurrentHistory),
    reverse(CurrentHistory, HistoryInvert),
    History = HistoryInvert.

%Descripcion: Predicado que verifica si el estado actual del juego es empate.
%Dominio: game (game)
%Meta primaria: is_draw/1.
%Meta secundaria: get_player1/2, get_player2/2, get_remaining_pieces/2, game_get_board/2, get_row/3, who_is_winner/2, can_play/1
%Otros

is_draw(Game):-
	get_player1(Game, Player1),
	get_player2(Game, Player2),
	get_remaining_pieces(Player1, Remaining_pieces_player1),
	get_remaining_pieces(Player2, Remaining_pieces_player2),
	game_get_board(Game, Board),
	who_is_winner(Board, Winner),
	Winner == 0,                                                                      
	(\+ can_play(Board) ;(Remaining_pieces_player1 == 0, Remaining_pieces_player2 == 0)).  %Si no hay ganador y los jugadores se quedaron sin fichas o no se puede jugar en el tablero dara true
	

%Descripcion: Predicado que obtiene el jugador cuyo turno está en curso.
%Dominio: Game 
%Recorrido: Player
%Meta primaria: get_current_player/2
%Meta secundaria: get_current_turn/2, get_player1/2, get_player2/2
%selector

get_current_player(Game, CurrentPlayer):-
	get_current_turn(Game, CurrentTurn),
	PlayerTurn is CurrentTurn mod 2,  % Se divide el numero del turno en 2 y si el modulo es 0 partira el jugador 2 y si es 1 partira el jugador 1.
	(PlayerTurn = 1 -> 
	get_player1(Game, Player1), 
	CurrentPlayer = Player1;     %Se asume que siempre partira el player1 con el primer movimiento
	get_player2(Game, Player2),
	CurrentPlayer = Player2).

%Descripcion: Predicado que entrega por pantalla el estado actual del tablero en el juego.
%Dominio: Game X Board
%Meta primaria: game_get_board/2
%Meta secundaria: game/6
%selector

game_get_board(Game, Board):-
	game(_, _, Board, _,_, Game).
	
%Descripcion: Predicado finaliza el juego actualizando las estadísticas de los jugadores según el resultado.
%Dominio: Game (game) X Game
%Meta primaria: end_game/2
%Meta secundaria: get_player1/2, get_player2/2, game_get_board/2, get_current_player/2, update_stats/2, game/5.
%Modificador

end_game(Game, EndedGame):-
	get_player1(Game, Player1),
	get_player2(Game, Player2),
	game_get_board(Game, Board),
	get_current_turn(Game, CurrentTurn), 
	get_history(Game, History),
	update_stats(Game, Player1, NewStats1),
	update_stats(Game, Player2, NewStats2),
	game(NewStats1, NewStats2, Board, CurrentTurn, History, EndedGame).
	
%Descripcion: Predicado que realiza un movimiento.
%Dominio: game (game) X player (player) X column (int).
%Recorrido: game
%Meta primaria: player_play/4.
%Meta secundaria: get_current_player/2, game_get_board/2, who_is_winner/2, is_draw/1, get_id/2, play_piece/4, get_player1/2, get_player2/2, get_current_turn/2, updated_player/5,game/5, end_game/2.
%Declarativa
%Modificador

player_play(Game, Player, Column, NewGame) :-
	Column < 7,
    get_current_player(Game, CurrentPlayer),
    game_get_board(Game, Board),
	((who_is_winner(Board, 1) ; who_is_winner(Board, 2) ; is_draw(Game)) ->  %se verifica con el juego actual no haya un ganador o la partida haya terminado en empate
	fail ;
	get_id(Player, Id),
	get_id(CurrentPlayer, IdCurrent),
	Id == IdCurrent,
	get_history(Game, History),
	( Id == 1 ->						%Se le asigna un color a la ficha segun el Id y se actualiza el historial de movimientos.
	Piece = ["red"],								
	append([(Column, "red")], History, NewHistory) ;
	Piece = ["yellow"],
	append([(Column, "yellow")], History, NewHistory)),   
    play_piece(Board, Column, Piece, NewBoard),   %Se pone la ficha en la columna indicada
    get_player1(Game, Player1),
    get_player2(Game, Player2),
    get_current_turn(Game, CurrentTurn),
    NewCurrentTurn is CurrentTurn + 1,
	updated_player(Player1, Player2, Player, NewPlayer1, NewPlayer2),  %Se actualizan las fichas quitandole 1 al jugador del turno actual
	game(NewPlayer1, NewPlayer2, NewBoard, NewCurrentTurn, NewHistory, CurrentNewGame),
    (is_draw(CurrentNewGame) ->             %Se verifica que con la ficha puesta no haya un ganador, si lo hay finaliza la partida y si no continua.
    end_game(CurrentNewGame, NewGame)
	; (who_is_winner(NewBoard, 1) ; who_is_winner(NewBoard, 2)) ->
    end_game(CurrentNewGame, NewGame)
	; NewGame = CurrentNewGame)).	
	

%---------------------------------------------------------------------------------------------


%Descripcion: Predicado que obtiene el player1 de game
%Dominio: Game X Player1
%Meta primaria: get_player1/2
%Meta secundaria: game/6
%selector

get_player1(Game, Player1):-
	game(Player1, _, _, _,_, Game).

%Descripcion: Predicado que obtiene el player2 de game
%Dominio: Game X Player2
%Meta primaria: get_player2/2
%Meta secundaria: game/6
%selector

get_player2(Game, Player2):-
	game(_, Player2, _, _,_, Game).
	
%Descripcion: Predicado que obtiene el currentTurn del game
%Dominio: Game X CurrentTurn
%Meta primaria: get_current_turn/2
%Meta secundaria: game/6
%selector

get_current_turn(Game, CurrentTurn):-
	game(_, _, _, CurrentTurn,_, Game).

%Descripcion: Predicado que obtiene el historial del game
%Dominio: Game X CurrentTurn
%Meta primaria: get_history/2
%Meta secundaria: game/6
%selector	

get_history(Game, History):-
	game(_, _, _, _,History, Game).

%Descripcion: Predicado que permite quitar una ficha al jugador que haya puesto una ficha.
%Dominio:  Player1 X Player2 X Player X NewPlayer1 X NewPlayer2
%Meta primaria: updated_player/5
%Meta secundaria: get_id/2, get_color/2, get_name/2, get_wins/2, get_losses/2, get_draws/2, get_remaining_pieces/2, player/8.
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
    NewPlayer1 = [Id1, Name1, Color1, Wins1, Losses1, Draws1, NewRemaining_pieces1],
    NewPlayer2 = [Id2, Name2, Color2, Wins2, Losses2, Draws2, Remaining_pieces2])
    ;(NewRemaining_pieces2 is Remaining_pieces2 - 1, 
    NewPlayer1 = [Id1, Name1, Color1, Wins1, Losses1, Draws1, Remaining_pieces1],
    NewPlayer2 = [Id2, Name2, Color2, Wins2, Losses2, Draws2, NewRemaining_pieces2])).