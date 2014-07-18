require_relative 'player'
require_relative 'board'
require_relative 'ship'
require_relative 'squares'
require_relative 'user_input'
require_relative 'water'
require_relative 'game'
require_relative 'terminal_board'
require_relative 'own_terminal_board'

NUMBER_OF_PLAYERS = 2
NUMBER_OF_RAFTS = 1
NUMBER_OF_CANOES = 1
NUMBER_OF_SHORTBOATS = 0
NUMBER_OF_LONGBOATS = 0

class Game
	
	def initialize
		@players = []
		@interface = UserInput.new
		# play_game
	end

	attr_reader :players, :interface

# Phase	 0

	def play_game
		create_game_elements
		set_up_game
		play_battleships
	end

# Phase 1 - create game elements

	def create_game_elements
		create_players
		create_board
		create_ships
		create_terminal_boards
	end

	def create_players
		NUMBER_OF_PLAYERS.times do
			name = interface.get_name_of_player
			@players << Player.new(name: name)
		end
	end

	def create_board
		players.each do |player|
			player.board=Board.new
		end
	end

	def create_terminal_boards
			players.each do |player|
			player.terminal_board =TerminalBoard.new(player.board)
			player.own_terminal_board = OwnView.new(player.terminal_board)
		end
	end

 	def create_ships
 		players.each do |player|
 			create_fleet_for(player)
 		end
	end
	
	def create_fleet_for(player)
		NUMBER_OF_RAFTS.times 		{player.ships << Ship.raft} 
		NUMBER_OF_CANOES.times 		{player.ships << Ship.canoe}
		NUMBER_OF_SHORTBOATS.times 	{player.ships << Ship.shortboat}
		NUMBER_OF_LONGBOATS.times 	{player.ships << Ship.longboat}	
	end


	### Placing the ships ready for play ###

	def set_up_game
			players.each do |player|
			player.place_all_ships
		end
		puts "Let's play Battleships!"
	end

	###PLaying the game####

	def play_battleships
		turn = 0
		until players[0].has_lost? || players[1].has_lost?
			puts "Turn #{turn}"
			interface.print(players[1].terminal_board.read)
			row, column = players[0].get_target
			target = players[1]
			players[0].fire_shot(target, row, column)
			interface.print(players[0].terminal_board.read)
			row, column = players[1].get_target
			target = players[0]
			players[1].fire_shot(target, row, column)
			turn += 1
		end
		puts "Game over"
	end




end

