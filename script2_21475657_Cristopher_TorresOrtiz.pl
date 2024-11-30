player(1, "Carlos", "red", 0, 0, 0, 7, P1),
player(2, "Matias", "yellow", 0, 0, 0, 7, P2),

piece("red", RedPiece),
piece("yellow", YellowPiece),

board(B),

play_piece(B, 6, RedPiece, B1),
play_piece(B1, 0, YellowPiece, B2),
play_piece(B2, 3, RedPiece, B3),

game(P1, P2, B, 1, G0),

player_play(G0, P1, 1, G1),    
player_play(G1, P2, 6, G2),    
player_play(G2, P1, 1, G3),    
player_play(G3, P2, 6, G4),    
player_play(G4, P1, 6, G5),    
player_play(G5, P2, 1, G6),    
player_play(G6, P1, 4, G7),    
player_play(G7, P2, 3, G8),    
player_play(G8, P1, 2, G9),    
player_play(G9, P2, 0, G10),  
player_play(G10, P1, 0, G11),
player_play(G11, P2, 3, G12),    
player_play(G12, P1, 4, G13),    
player_play(G13, P2, 0, G14),    

game_get_board(G3, CurrentBoard),
game_get_board(G7, CurrentBoard1),
game_get_board(G10, CurrentBoard2),
game_get_board(G14, FinalBoardGame),
write('¿Se puede jugar después de 3 movimientos? '),
can_play(CurrentBoard),
nl,

write('¿Se puede jugar después de 7 movimientos? '),
can_play(CurrentBoard1),
nl,

write('¿Se puede jugar después de 10 movimientos? '),
can_play(CurrentBoard2),
nl,

write('Jugador actual después de 5 movimientos: '),
get_current_player(G5, CurrentPlayer),
write(CurrentPlayer),
nl,

write('Jugador actual después de 8 movimientos: '),
get_current_player(G8, CurrentPlayer1),
write(CurrentPlayer1),
nl,

write('Jugador actual después de 13 movimientos: '),
get_current_player(G13, CurrentPlayer2),
write(CurrentPlayer2),
nl,

write('¿Es empate? '),
is_draw(G14),            
nl,

write('Verificación de victoria vertical: '),
check_vertical_win(FinalBoardGame, VerticalWinner),
write(VerticalWinner),
nl,
   
write('Verificación de victoria horizontal: '),
check_horizontal_win(FinalBoardGame, HorizontalWinner),
write(HorizontalWinner),
nl,
   
write('Verificación de victoria diagonal: '),
check_diagonal_win(FinalBoardGame, DiagonalWinner),
write(DiagonalWinner),
nl,
   
write('Verificación de ganador: '),
who_is_winner(FinalBoardGame, Winner),
write(Winner),
nl,

write('Historial de movimientos despues de 8 movimientos: '),
game_history(G8, History8),
write(History8),
nl,

write('Historial de movimientos despues de 4 movimientos: '),
game_history(G4, History4),
write(History4),
nl,

end_game(G14, EndedGame),

write('Historial de movimientos de la partida finalizada: '),
game_history(EndedGame, History),
write(History),
nl,


write('Estado del tablero despues de 4 movimientos: '),
game_get_board(G4, Board),
write(Board),
nl,

write('Estado del tablero despues de 12 movimientos: '),
game_get_board(G12, Board1),
write(Board1),
nl,

write('Estado final del tablero: '),
game_get_board(EndedGame, FinalBoard),
write(FinalBoard),
nl,

write('actualizacion de las estadisticas de los jugadores '),
update_stats(G14, P1, NewStatsPlayer1),
update_stats(G14, P2, NewStatsPlayer2),

write(NewStatsPlayer1),
write(NewStatsPlayer2),
nl.