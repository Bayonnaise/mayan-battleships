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
		place_ships(players[0])
		place_ships(players[1])
		puts "Let's play Battleships!"
	end

	def place_ships(player)
		puts "Please place your ships, #{player.name}:"
		player.ships.each do |ship| 
			interface.print(player.own_terminal_board.read)
			begin
				row, column, direction = interface.get_input_to_place(ship)
				coordinate = {x: row.to_i, y: column.to_i}
			end while !player.board.check_valid?(ship, at: coordinate, facing: direction.to_sym)
			
			coordinate = {x: row.to_i, y: column.to_i}
			player.board.place(ship, at: coordinate, facing: direction.to_sym)
		end
	end

	def play_battleships
		turn = 0
		until players[0].has_lost? || players[1].has_lost?
			puts "Turn #{turn}"
			interface.print(players[1].terminal_board.read)
			row, column = get_target(players[0])
			target = players[1]
			fire_shot(target, row, column)
			interface.print(players[0].terminal_board.read)
			row, column = get_target(players[1])
			target = players[0]
			fire_shot(target, row, column)
			turn += 1
		end
		puts "Game over"
	end

	def get_target(player)
		puts "It's your turn, #{player.name}"
		row, column = interface.get_input_for_attack
		return row, column
	end

	def fire_shot(target, row, column)
		target.board.grid[row.to_i][column.to_i].hit!
	end


end

