
:- use_module("TDAPlayer_21475657_TorresOrtiz.pl").
:- use_module("TDAboard_21475657_TorresOrtiz.pl").

%Descripcion: Predicado que permite crear una nueva partida.
%Dominio: player1 (player) X player2 (player) X board (board) X current-turn (int).
%Constructor 

game(Player1, Player2, Board, Current-turn, [Player1, Player2, Board, Current-turn]):-
	current-turn > 0.


