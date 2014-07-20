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
NUMBER_OF_SHORTBOATS = 1
NUMBER_OF_LONGBOATS = 1

class Game
	
	def initialize
		@players = []
		@interface = UserInput.new
	end

	attr_reader :players, :interface

# Phase	 0

	def start_game
		interface.message(:welcome_message)
		gets.chomp
		play_game

	end

	def play_game
		create_game_elements
		set_up_game
		loser = take_turns
		end_game(loser)
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


### Phase 2: Placing the ships ready for play ###

	def set_up_game
			players.each do |player|
			player.place_all_ships
		end
		interface.message(:start_playing)
	end

 #Phase 3: PLaying the game####

	def opponent_of player
		players.select {|element| element !=player}[0]
	end


	def take_a_turn player
		x, y = interface.get_input_for_attack(player, opponent_of(player), opponent_of(player).terminal_board)
		player.shoot_at(opponent_of(player),x,y)
		opponent_of(player).has_lost?
		interface.print(opponent_of(player).terminal_board.read)
	end

	def take_turns
		loop do
			players.each do |player|
				return player if player.has_lost? 
				take_a_turn player
			end
		end
	end

	def end_game loser
		interface.announce_final(winner: opponent_of(loser), loser: loser)
	end

end

	# def play_battleships
	# 	turn = 0
	# 	until players[0].has_lost? || players[1].has_lost?
	# 		puts "Turn #{turn}"
	# 		# interface.print(players[1].terminal_board.read)
	# 		row, column = players[0].get_target
	# 		target = players[1]
	# 		players[0].fire_shot(target, row, column)
	# 		# interface.print(players[0].terminal_board.read)
	# 		row, column = players[1].get_target
	# 		target = players[0]
	# 		players[1].fire_shot(target, row, column)
	# 		turn += 1
	# 	end
	# 	puts "Game over"
	# end

# when shooting at ships

	# def get_target
	# 	puts "It's your turn, #{name}"
	# 	row, column = interface.get_input_for_attack
	# 	return row, column
	# end

	# def fire_shot(target, row, column)
	# 	target.board.grid[row.to_i][column.to_i].hit!
	# end
