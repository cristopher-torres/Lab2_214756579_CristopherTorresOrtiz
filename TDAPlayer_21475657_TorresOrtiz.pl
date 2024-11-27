
:- module(player,[player/8, get_remaining_pieces/2, update_stats/3, get_id/2, get_name/2, get_color/2, get_wins/2, get_losses/2, get_draws/2]).

%Descripcion: Predicado que permite crear un jugador.
%Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining_pieces (int) X Player
%Meta primaria: player/8.
%Constructor 
player(Id, Name, Color, Wins, Losses, Draws, Remaining_pieces, [Id,Name,Color,Wins,Losses,Draws,Remaining_pieces]):- 
    integer(Id),
    string(Name), 
    string(Color),
    integer(Wins),
	integer(Losses),
	integer(Draws),
	integer(Remaining_pieces),
	Remaining_pieces < 22,
	( Id == 1 ->
	Color = "red"
	; Color = "yellow").
	

%Descripcion: Predicado que actualiza las estadísticas del jugador, ya sea victoria, derrotas o empates.
%Dominio: Game X EstadisticasPrevias X NuevasEstadisticas. (se asume que EstadisticasPrevias es un player, NuevasEstadisticas es las estadisticas actualizadas del player)
%Meta Primaria: update_stats/3.
%Meta secundaria: get_id/2, get_color/2, get_name/2, get_wins/2, get_losses/2, get_draws/2, get_remaining_pieces/2, game_get_board/2, is_draw/1, player/8, who_is_winner/2
%Otros

update_stats(Game, Player, NewStats):-
	game_get_board(Game, BoardGame),
	get_id(Player, Id),
	get_name(Player, Name),
	get_color(Player, Color),
	get_wins(Player, Wins),
	get_losses(Player, Losses),
	get_draws(Player, Draws),
	get_remaining_pieces(Player, Remaining_pieces),
	(is_draw(Game) ->
	Newdraws is Draws + 1,
	player(Id, Name, Color, Wins, Losses, Newdraws, Remaining_pieces, NewStats) ;
	(who_is_winner(BoardGame, Winner), Id == Winner ->
	NewWins is Wins + 1,
	player(Id, Name, Color, NewWins, Losses, Draws, Remaining_pieces, NewStats) ;
	(who_is_winner(BoardGame, Winner), Id =\= Winner, Winner =\= 0 ->
	NewLosses is Losses + 1,
	player(Id, Name, Color, Wins, NewLosses, Draws, Remaining_pieces, NewStats) ;
	player(Id, Name, Color, Wins, Losses, Draws, Remaining_pieces, NewStats)))).
	
	
%---------------------------------------------------------------------------------------------------------------------------	
	
%Descripcion: Predicado que obtiene el Id del jugador
%Dominio: Player X Id
%Meta Primaria: get_id/2.
%Meta secundaria: player(Id,_,_,_,_,_, _, Player).
%selector

get_id(Player, Id):-
	player(Id,_,_,_,_,_, _, Player).
	
%Descripcion: Predicado que obtiene el Name del jugador
%Dominio: Player X Name
%Meta Primaria: get_name/2.
%Meta secundaria: player(_,Name,_,_,_,_, _, Player).
%selector

get_name(Player, Name):-
	player(_,Name,_,_,_,_, _, Player).
	
%Descripcion: Predicado que obtiene el Color del jugador
%Dominio: Player X Color
%Meta Primaria: get_color/2.
%Meta secundaria: player(_,_,Color,_,_,_, _, Player).
%selector

get_color(Player, Color):-
	player(_,_,Color,_,_,_, _, Player).
	
%Descripcion: Predicado que obtiene las Wins del jugador
%Dominio: Player X Wins
%Meta Primaria: get_wins/2.
%Meta secundaria: player(_,_,_,Wins,_,_, _, Player).
%selector

get_wins(Player, Wins):-
	player(_,_,_,Wins,_,_, _, Player).
	
%Descripcion: Predicado que obtiene los Losses del jugador
%Dominio: Player X Losses
%Meta Primaria: get_losses/2.
%Meta secundaria: player(_,_,_,_,Losses,_, _, Player).
%selector

get_losses(Player, Losses):-
	player(_,_,_,_,Losses,_, _, Player).
	
%Descripcion: Predicado que obtiene Los Draws del jugador
%Dominio: Player X Draws
%Meta Primaria: get_draws/2.
%Meta secundaria: player(_,_,_,_,_,Draws, _, Player).
%selector

get_draws(Player, Draws):-
	player(_,_,_,_,_,Draws, _, Player).		

%Descripcion: Predicado que obtiene las fichas del jugador
%Dominio: Player X Remaining_pieces
%Meta Primaria: get_remaining_pieces/2.
%Meta secundaria: player(_,_,_,_,_,_, Remaining_pieces, Player).
%selector

get_remaining_pieces(Player, Remaining_pieces):-
	player(_,_,_,_,_,_, Remaining_pieces, Player).