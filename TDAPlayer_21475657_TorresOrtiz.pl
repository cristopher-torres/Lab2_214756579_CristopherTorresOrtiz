
:- module(player,[player/8]).

%Descripcion: Predicado que permite crear un jugador.
%Dominio: id (int) X name (string) X color (string) X wins (int) X losses (int) X draws (int) X remaining_pieces (int) X Player
%Constructor 
player(Id, Name, Color, Wins, Losses, Draws, Remaining_pieces, [Id,Name,Color,Wins,Losses,Draws,Remaining_pieces]):- 
    integer(Id),
    string(Name), 
    string(Color),
    integer(Wins),
	integer(Losses),
	integer(Draws),
	integer(Remaining_pieces),
	Remaining_pieces > 4,
	Remaining_pieces < 22.