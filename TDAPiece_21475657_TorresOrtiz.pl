
:- module(piece,[piece/2, color_permitido/1]).

%Descripcion: Predicado que crea una ficha de Conecta4.
%Dominio: color (string)
%Meta primaria: piece/2
%Meta secundaria: color_permitido/1.
%Constructor 

color_permitido("red").			%solo se permiten estos colores
color_permitido("yellow").

piece(Color, [Color]):-
	string(Color),
	color_permitido(Color).