require './lib/squares'
require './lib/board'
require './lib/ship'
require './lib/water'
require './lib/player'
require './lib/user_input'
require './lib/terminal_board'
require './lib/own_terminal_board'

puts "hello"
ui = UserInput.new
player1 = Player.new(name: ui.get_name_of_player)
player2 = Player.new(name: ui.get_name_of_player)
player1.board = Board.new
player2.board = Board.new

player1.ships= [Ship.canoe,Ship.longboat]
player2.ships= [Ship.canoe,Ship.longboat]
terminal_board1 = TerminalBoard.new(player1.board)
terminal_board2 = TerminalBoard.new(player2.board)
own_terminal_board1 = OwnView.new(terminal_board1)
own_terminal_board2 = OwnView.new(terminal_board2)


player1.board.place(player1.ships[0], at: {x:0,y:0}, facing: :horizontal)
player1.board.place(player1.ships[1], at: {x:2,y:0}, facing: :vertical)

player2.board.place(player1.ships[0], at: {x:5,y:5}, facing: :horizontal)
player2.board.place(player1.ships[1], at: {x:3,y:0}, facing: :vertical)

terminal_board1.read
terminal_board1.print

terminal_board2.read
terminal_board2.print

own_terminal_board1.read
own_terminal_board1.print

own_terminal_board2.read
own_terminal_board2.print

player1.board.grid[3][4].hit!
player2.board.grid[4][3].hit!
player1.board.grid[0][0].hit!
player2.board.grid[6][7].hit!
player1.board.grid[3][1].hit!
player2.board.grid[2][3].hit!
player1.board.grid[0][2].hit!
player2.board.grid[1][7].hit!
player1.board.grid[0][1].hit!
player2.board.grid[1][7].hit!

puts "end"