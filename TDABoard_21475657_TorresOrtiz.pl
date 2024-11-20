
:- use_module("TDAPiece_21475657_TorresOrtiz.pl").

%Descripcion: Crear un tablero de Conecta4.
%Dominio: no aplica
%Constructor 

board([[0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0]]).

%Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
%Dominio: board (board).
%otros

%hechos
can_play([]) :- false.

can_play(Board) :-
    get_row(0, Board, Row), % solo verificare la primera fila, ya que las fichas se colocan en la posicion mas baja, entonces de la unica manera que no se pueda jugar es que en la primera fila no hayan 0.
    my_member(0, Row).
	
%Descripcion: Jugar una ficha en el tablero
%Dominio: Board (board) X Column (int) X Piece (piece) X NewBoard (board)
%Modificador

play_piece(Board, Column, Piece, NewBoard):-
	get_column(Board, Column, PieceColumn),
	reverse(PieceColumn, ColumnInvert),
	insertar_piece(Piece, ColumnInvert, NewColumn),
	reverse(NewColumn, NewColumn2),
	actualizar_tablero(Board,Column,NewColumn2, NewBoard).
	
%Descripcion: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma vertical. 
%Dominio: Board (board) X int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical).
%Otros


check_vertical_win(Board, Winner):- 
	check_column(Board, 0, Winner).
	
	
%Descripcion: Predicado que permite verificar si hay un elemento en la fila
%Dominio: row (list) x X(int)
%pertenencia

%Hechos
my_member( X, [X | _ ] ):- !.

my_member(X, [ _  | Cola] ):-
    my_member(X, Cola).
	

%Descripcion: predicado que obtiene una fila de la board
%Dominio: row (list) x n (int)
%predicado auxiliar

get_row(0, [Row | _ ], Row).  

get_row(N, [ _ | Tail ], Row) :-
    N >= 1,
    NewN is N - 1,             
    get_row(NewN, Tail, Row).
	
%Descripcion: pedricado que obtiene una columna
%Dominio: Board (board) x N (int) x Column (list)
%predicado auxiliar

get_column([], _, []). 

get_column([Fila|Cola], N, [Dato|Column]):-
    get_elemento(Fila, N, Dato), 
    get_column(Cola, N, Column).

%Descripcion: predicado que obtiene un elemento de una lista
%Dominio: row (list) x I (int) x X (int)
%predicado auxiliar

get_elemento([X|_], 0, X).

get_elemento([_|Cola], I, X):-
    I >= 1, 
    I1 is I - 1, 
    get_elemento(Cola, I1, X). 
	
	
%Descripcion: predicado que pone una ficha en una lista
%Dominio: piece (String) x column (list) x newcolumn (list)
%predicado auxiliar

insertar_piece(Piece, [0|Cola], [Piece|Cola]):-!.

insertar_piece( Piece, [Inicio|Cola], [Inicio|Lista] ):-
    insertar_piece( Piece, Cola, Lista).


%Descripcion: Predicado que actualiza la board al poner una ficha
%Dominio: Board (board) X Column (int) X Columna (list) X NewBoard (board)
%predicado auxiliar
	
actualizar_tablero([], _, [], []).

actualizar_tablero([Fila|ColaBoard], Column, [Piece|ColaColumna], [NuevaFilaBoard|NuevaColaBoard]) :-
    actualizar_fila(Fila, Column, Piece, NuevaFilaBoard),
    actualizar_tablero(ColaBoard, Column, ColaColumna, NuevaColaBoard).
	

%Descripcion: Predicado que actualiza la fila en la que se pone la ficha
%Dominio: Row (list) X Column (int) X Piece (string) X NewBoard (board)
%predicado auxiliar

actualizar_fila([_|Cola], 0, Piece, [Piece|Cola]).
actualizar_fila([X|Cola], Column, Piece, [X|NuevaCola]) :-
    Column >= 1,
    NewColumn is Column - 1,
    actualizar_fila(Cola, NewColumn, Piece, NuevaCola).

%Descripcion: Predicado que cuenta cuantas veces esta un elementos en una lista
%Dominio: lista (list) X Acc (int) X Elemento (string)
%predicado auxiliar

winners([], _, _):- fail. %caso base si la lista es vacia
winners(_, 4, _) :- !.  %caso base si el acumulador llega a 4
winners([_|Cola], _, Elemento) :-   %caso recursivo si el elemento no es igual al primer elemento de la lista
    winners(Cola, 0, Elemento).

winners([[Elemento] | Cola ], Acc, Elemento) :-
    Acc1 is Acc + 1 ,
    winners(Cola, Acc1, Elemento).

%Descripcion: Predicado que verifica todas las columnas para ver si hay un ganador.
%Dominio: Board (board) X Column (int) X Winner (int)
%predicado auxiliar

check_column(_, 7, 0).

check_column(Board, Column, Winner):-
	Column < 7,
	get_column(Board, Column, ColumnActual),
	(winners(ColumnActual, 0, "red") ->
	Winner = 1 ;
	winners(ColumnActual, 0, "yellow") ->
	Winner = 2 ;
	NewColumn is Column + 1,
	check_column(Board, NewColumn, Winner)).