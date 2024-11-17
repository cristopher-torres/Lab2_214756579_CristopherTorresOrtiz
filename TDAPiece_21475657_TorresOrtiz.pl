
:- module(piece,[piece/2]).

%Descripcion: Predicado que crea una ficha de Conecta4.
%Dominio: color (string) 
%Constructor 

piece(Color, [Color]):-
	string(Color).
