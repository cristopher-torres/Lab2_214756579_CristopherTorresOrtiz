

%Descripcion: Crear un tablero de Conecta4.
%Dominio: no aplica
%Constructor 

board([[0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0],
	   [0, 0, 0, 0, 0, 0, 0]]).


%Descripcion: obtiene una fila de la board
%Dominio: row (list) x n (int)
%selector

%Hechos
get_row(0, [Row | _ ], Row).  

get_row(N, [ _ | Tail ], Row) :-
    N >= 1,
    NewN is N - 1,             
    get_row(NewN, Tail, Row).

%Descripcion: Predicado que permite verificar si se puede realizar más jugadas en el tablero.
%Dominio: board (board).
%otros

%hechos
can_play([]) :- false.

can_play(Board) :-
    get_row(0, Board, Row), % solo verificare la primera fila, ya que las fichas se colocan en la posicion mas baja, entonces de la unica manera que no se pueda jugar es que en la primera fila no hayan 0.
    hay_cero(0, Row).

	
%Descripcion: Predicado que permite verificar si hay un dato en la fila
%Dominio: row (list) x X(int)
%pertenencia

%Hechos
hay_cero( X, [X | _ ] ):- !.

hay_cero(X, [ _  | Cola] ):-
    hay_cero(X, Cola).
	