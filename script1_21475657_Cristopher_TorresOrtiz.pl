player(1, "Vegetta", "red", 0, 0, 0,21 , P1),
player(2, "Goku", "yellow", 0, 0, 0, 21, P2),

piece("red", RedPiece),
piece("yellow", YellowPiece),

board(B0),

play_piece(B0, 4, RedPiece, B1),
play_piece(B1, 2, YellowPiece, B2),
play_piece(B2, 4, RedPiece, B3),

game(P1, P2, B0, 1, G0),

player_play(G0, P1, 0, G1),    
player_play(G1, P2, 1, G2),    
player_play(G2, P1, 2, G3),    
player_play(G3, P2, 6, G4),    
player_play(G4, P1, 5, G5),    
player_play(G5, P2, 5, G6),    
player_play(G6, P1, 6, G7),    
player_play(G7, P2, 3, G8),    
player_play(G8, P1, 4, G9),    
player_play(G9, P2, 4, G10),  
player_play(G10, P1, 0, G11),
player_play(G11, P2, 5, G12),    
player_play(G12, P1, 3, G13),    
player_play(G13, P2, 1, G14),    
player_play(G14, P1, 2, G15),    
player_play(G15, P2, 3, G16),    
player_play(G16, P1, 4, G17),    
player_play(G17, P2, 5, G18),    
player_play(G18, P1, 3, G19),    
player_play(G19, P2, 5, G20),

game_get_board(G9, CurrentBoard),
game_get_board(G15, CurrentBoard1),
game_get_board(G19, CurrentBoard2),
game_get_board(G20, FinalBoardGame),
write('¿Se puede jugar después de 9 movimientos? '),
can_play(CurrentBoard),
nl,

write('¿Se puede jugar después de 15 movimientos? '),
can_play(CurrentBoard1),
nl,

write('¿Se puede jugar después de 19 movimientos? '),
can_play(CurrentBoard2),
nl,

write('Jugador actual después de 9 movimientos: '),
get_current_player(G9, CurrentPlayer),
write(CurrentPlayer),
nl,

write('Jugador actual después de 16 movimientos: '),
get_current_player(G16, CurrentPlayer1),
write(CurrentPlayer1),
nl,

write('Jugador actual después de 19 movimientos: '),
get_current_player(G19, CurrentPlayer2),
write(CurrentPlayer2),
nl,

write('¿Es empate? '),
is_draw(G15),            %dara false
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



end_game(G20, EndedGame),

write('Historial de movimientos: '),
game_history(EndedGame, History),
write(History),
nl,

write('Estado del tablero despues de 9 movimientos: '),
game_get_board(G9, Board),
write(Board),
nl,

write('Estado del tablero despues de 17 movimientos: '),
game_get_board(G17, Board1),
write(Board1),
nl,

write('Estado final del tablero: '),
game_get_board(EndedGame, FinalBoard),
write(FinalBoard),
nl,

write('actualizacion de las estadisticas de los jugadores '),
update_stats(G20, P1, NewStatsPlayer1),
update_stats(G20, P2, NewStatsPlayer2),

write(NewStatsPlayer1),
write(NewStatsPlayer2).