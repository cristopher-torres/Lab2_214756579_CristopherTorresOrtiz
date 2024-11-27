
:- module(board, [board/1,can_play/1,play_piece/4,check_vertical_win/2,check_horizontal_win/2, check_diagonal_win/2, who_is_winner/2, my_member/2,get_row/3, get_column/3,get_elemento/3, insertar_piece/3, actualizar_tablero/4, actualizar_fila/4, winners/3, check_column/3, obtener_elemento_fila/4, get_diagonal_asc/4, get_diagonal_desc/4, check_diagonal/4]).


%Descripcion: Crear un tablero de Conecta4.
%Dominio: no aplica
%Meta primaria: board/1
%Constructor 

board([[0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0]]).

%Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
%Dominio: board (board).
%Meta primaria: can_play/1
%Meta secundaria: get_row/3, my_member/2, who_is_winner/2.
%otros

%hechos
can_play([]) :- fail.

can_play(Board) :-
    get_row(0, Board, Row), % solo verificare la primera fila, ya que las fichas se colocan en la posicion mas baja, entonces de la unica manera que no se pueda jugar es que en la primera fila no hayan 0.
    my_member(0, Row),
	who_is_winner(Board, Winner),
	Winner == 0.
	
%Descripcion: Jugar una ficha en el tablero
%Dominio: Board (board) X Column (int) X Piece (piece) X NewBoard (board)
%Meta primaria: play_piece/4
%Meta secundaria: get_column/3, insertar_piece/3, actualizar_tablero/4.
%Modificador

play_piece(Board, Column, Piece, NewBoard):-
	Column < 7,
	get_column(Board, Column, PieceColumn),
	reverse(PieceColumn, ColumnInvert),
	insertar_piece(Piece, ColumnInvert, NewColumn),
	reverse(NewColumn, NewColumn2),
	actualizar_tablero(Board,Column,NewColumn2, NewBoard).
	
%Descripcion: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma vertical. 
%Dominio: Board (board) 
%Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador vertical).
%Meta primaria: check_vertical_win/2.
%Meta secundaria: check_column/3
%Recursion
%Otros


check_vertical_win(Board, Winner):- 
	check_column(Board, 0, Winner).



%Descripcion: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma horizontal. 
%Dominio: Board (board)
%Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador horizontal).
%Meta primaria: check_horizontal_win/2.
%Meta secundaria: get_row/3, winners/3.
%Recursion
%Otros

check_horizontal_win([], 0).

check_horizontal_win(Board, Winner):-
	get_row(0, Board, Row),
	(winners(Row, 0, "red")-> 
	Winner = 1 ;
	winners(Row,0, "yellow")->
	Winner = 2;
	Board = [ _ | Cola],
	check_horizontal_win(Cola, Winner)).

%Descripcion: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de forma diagonal. 
%Dominio: Board (board)
%Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal).
%Meta primaria: check_diagonal_win/2.
%Meta secundaria: check_diagonal/4.
%Recursion
%Otros	
	
check_diagonal_win(Board, Winner):-
	check_diagonal(Board, 0, 0, Winner).
	

%Descripcion: Predicado que permite verificar el estado actual del tablero y entregar el posible ganador que cumple con la regla de conectar 4 fichas de cualquier forma. 
%Dominio: Board (board)
%Recorrido: int (1 si gana jugador 1, 2 si gana jugador 2, 0 si no hay ganador diagonal).
%Meta primaria: who_is_winner/2.
%Meta secundaria: check_diagonal_win/2, check_horizontal_win/2, check_vertical_win/2.
%Declarativa
%Otros

who_is_winner(Board, Winner):-
	((check_vertical_win(Board, 1) ; check_horizontal_win(Board, 1); check_diagonal_win(Board, 1)) ->
	Winner = 1;
	((check_vertical_win(Board, 2) ; check_horizontal_win(Board, 2); check_diagonal_win(Board, 2)) ->
	Winner = 2;
	Winner= 0)).


%---------------------------------------------------------------------------------------------------------------------------

%Descripcion: Predicado que permite verificar si hay un elemento en la fila
%Dominio: row (list) x X(int)
%Meta primaria: my_member/2.
%Recursion 
%pertenencia

%Hechos
my_member( X, [X | _ ] ):- !.

my_member(X, [ _  | Cola] ):-
    my_member(X, Cola).
	

%Descripcion: predicado que obtiene una fila de la board
%Dominio: row (list) x n (int)
%Meta primaria: get_row/3
%Recursion
%predicado auxiliar

get_row(0, [Row | _ ], Row).  

get_row(N, [ _ | Tail ], Row) :-
    N >= 0,
    NewN is N - 1,             
    get_row(NewN, Tail, Row).

%Descripcion: predicado que obtiene un elemento de una lista
%Dominio: row (list) x I (int) x X (int)
%Meta primaria: get_elemento/3
%Recursion
%predicado auxiliar

get_elemento([X|_], 0, X).

get_elemento([_|Cola], I, X):-
    I >= 0, 
    I1 is I - 1, 
    get_elemento(Cola, I1, X). 
	
%Descripcion: pedricado que obtiene una columna
%Dominio: Board (board) x N (int) x Column (list)
%Meta Primaria: get_column/3.
%Meta secundaria: get_elemento/3
%Recursion
%predicado auxiliar

get_column([], _, []). 

get_column([Fila|Cola], N, [Dato|Column]):-
    get_elemento(Fila, N, Dato), 
    get_column(Cola, N, Column).	
	
%Descripcion: predicado que pone una ficha en una lista
%Dominio: piece (String) x column (list) x newcolumn (list)
%Meta primaria: insertar_piece/3.
%Recursion
%predicado auxiliar

insertar_piece(Piece, [0|Cola], [Piece|Cola]):-!.

insertar_piece( Piece, [Inicio|Cola], [Inicio|Lista] ):-
    insertar_piece( Piece, Cola, Lista).
	

%Descripcion: Predicado que actualiza la fila en la que se pone la ficha
%Dominio: Row (list) X Column (int) X Piece (string) X NewBoard (board)
%Meta primaria: actualizar_fila/4.
%Recursion
%predicado auxiliar

actualizar_fila([_|Cola], 0, Piece, [Piece|Cola]).
actualizar_fila([X|Cola], Column, Piece, [X|NuevaCola]) :-
    Column >= 0,
    NewColumn is Column - 1,
    actualizar_fila(Cola, NewColumn, Piece, NuevaCola).
	
	
%Descripcion: Predicado que actualiza la board al poner una ficha
%Dominio: Board (board) X Column (int) X Columna (list) X NewBoard (board)
%Meta primaria: actualizar_tablero/4
%Meta secundaria: actualizar_fila/4.
%Recursion
%predicado auxiliar
	
actualizar_tablero([], _, [], []).

actualizar_tablero([Fila|ColaBoard], Column, [Piece|ColaColumna], [NuevaFilaBoard|NuevaColaBoard]) :-
    actualizar_fila(Fila, Column, Piece, NuevaFilaBoard),
    actualizar_tablero(ColaBoard, Column, ColaColumna, NuevaColaBoard).
	

%Descripcion: Predicado que cuenta cuantas veces esta un elementos en una lista
%Dominio: lista (list) X Acc (int) X Elemento (string)
%Meta primaria: winners/3.
%Recusion
%predicado auxiliar

winners([], _, _):- fail. %caso  si la lista es vacia
winners(_, 4, _) :- !.  %caso si el acumulador llega a 4
winners([_|Cola], _, Elemento) :-   %caso si el elemento no es igual a la ficha que se esta evaluando en la lista
    winners(Cola, 0, Elemento).

winners([[Elemento] | Cola ], Acc, Elemento) :-
    Acc1 is Acc + 1 ,
    winners(Cola, Acc1, Elemento).

%Descripcion: Predicado que verifica todas las columnas para ver si hay un ganador.
%Dominio: Board (board) X Column (int) X Winner (int)
%Meta primaria : check_column/3.
%Meta secundaria: get_column/3, winners/3
%Recursion 
%predicado auxiliar

check_column(_, 7, 0).

check_column(Board, Column, Winner):-
	Column < 7,
	get_column(Board, Column, ColumnActual),
	(winners(ColumnActual, 0, "red") ->
	Winner = 1 ;
	(winners(ColumnActual, 0, "yellow") ->
	Winner = 2 ;
	NewColumn is Column + 1,
	check_column(Board, NewColumn, Winner))).
	
%Descripcion: Predicado que obtiene un elemento en una fila indicada
%Dominio: Board (board) X Fila (int) X Column (int) X Elemento (int)
%Meta primaria: obtener_elemento_fila/4.
%Meta secundaria: get_row/3, get_elemento/3.
%predicado auxiliar


obtener_elemento_fila(Board, Fila, Column, Elemento) :-
   get_row(Fila, Board, NewFila),
   get_elemento(NewFila, Column, Elemento).
   
  
%Descripcion: Predicado que obtiene la diagonal descendente
%Dominio: Board (board) X Fila (int) X Column (int) X DiagonalDesc (list)
%Meta primaria: get_diagonal_desc/4
%Meta secundaria: obtener_elemento_fila/4.
%Recursion 
%predicado auxiliar

get_diagonal_desc(_, Fila, Column, []) :-   %caso cuando se sale de los limites de la board
	(Fila > 5 ; 
	Column > 6).

get_diagonal_desc(Board, Fila, Column, [X|Cola]):-
	Fila < 6,
	Column < 7,
	obtener_elemento_fila(Board, Fila, Column, X),
	NewFila is Fila + 1,
	NewColumn is Column + 1,
	get_diagonal_desc(Board, NewFila, NewColumn, Cola).


%Descripcion: Predicado que obtiene la diagonal ascendente
%Dominio: Board (board) X Fila (int) X Column (int) X DiagonalAsc (list)
%Meta primaria: get_diagonal_asc/4
%Meta secundaria: obtener_elemento_fila/4.
%Recursion 
%predicado auxiliar

get_diagonal_asc(_, Fila, Column, []) :-   %caso cuando se sale de los limites de la board
	(Fila < 0 ; 
	Column > 6).

get_diagonal_asc(Board, Fila, Column, [X|Cola]):-
	Fila >= 0,
	Column < 7,
	obtener_elemento_fila(Board, Fila, Column, X),
	NewFila is Fila - 1,
	NewColumn is Column + 1,
	get_diagonal_asc(Board, NewFila, NewColumn, Cola).

%Descripcion: Predicado que verifica todas las diagonales de todas la posiciones de la board
%Dominio: Board (board) X Fila (int) X Column (int) X winner (1 gana jugador 1, 2 gana jugador 2, 0 no hay ganador)
%Meta primaria: check_diagonal/4
%Meta secundaria: get_diagonal_asc/4, get_diagonal_desc/4, winners/3.
%Recursion
%predicado auxiliar

check_diagonal(_, 6, 0, 0).

check_diagonal(Board, Fila, Column, Winner):-
	get_diagonal_asc(Board, Fila, Column, DiagonalAsc),
	get_diagonal_desc(Board, Fila, Column, DiagonalDesc),
	((winners(DiagonalAsc, 0, "red") ; winners(DiagonalDesc, 0,"red")) ->
	Winner = 1 ;
	(winners(DiagonalAsc, 0, "yellow") ; winners(DiagonalDesc, 0, "yellow")) ->
	Winner = 2 ;
	( Column > 6 ->
	NewFila is Fila + 1,
	NewColumn = 0 ,
	check_diagonal(Board, NewFila, NewColumn, Winner);
	NewColumn is Column + 1,
	NewFila = Fila,
	check_diagonal(Board, NewFila, NewColumn, Winner))).


