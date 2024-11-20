
:- module(piece,[piece/2]).

%Descripcion: Predicado que crea una ficha de Conecta4.
%Dominio: color (string) 
%Constructor 

color_permitido("red").
color_permitido("yellow").

piece(Color, [Color]):-
	string(Color),
	color_permitido(Color).