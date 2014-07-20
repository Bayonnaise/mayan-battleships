class UserInput

	GRID_RANGE = (0..9)

	def initialize
			@valid_directions = [:h,:v]
			@numbers = %w[1 2 3 4 5 6 7 8 9 10]
			@letters = %w[A B C D E F G H I J]
			@messages = {
				welcome_message: "Welcome to Battleships!\nPress enter to start the game",
				ship_hit: "Direct hit, el capitan!",
				water_hit: "Splash! Better luck next time...",
				duplicate_ship: "You can't put it there, try again...",
				ship_sunk: "You sunk your opponent's ship!",
				ship_placed: "Roger that. Ship sucessfully manouvered into position",
				start_playing: "Let's play Battleships!"
			}
	end

	attr_reader :valid_directions, :numbers, :messages, :letters

	def message(action)
		puts messages[action]
	end

	### GETTING INPUT ###

	def get_name_of_player
		puts "Please enter player's name"
		gets.chomp
	end

	def announce_final winner: winner, loser: loser
		puts "#{loser.name}'s entire fleet is sunk"
		puts "Congratulations #{winner.name}. You rule the waves!"
		puts "End of game"
	end

	# Getting inputs for placing ships

	def get_input_to_place(ship)
		puts ""
		puts "Place your #{ship.name} (length: #{ship.length})..."
		x, y = get_coordinate
		direction = get_direction
		return [{x: x, y: y}, direction]
	end

	def get_coordinate
		x = "X"
		y = "Y"
		msg = "Please enter a coordinate (eg A1-J10)"
		x, y = validate_coordinate(x, y, msg)
		convert(x, y)
	end

	def get_direction
		puts "Please enter a direction (h/v)"
		direction = gets.chomp.downcase.to_sym
		check_direction(direction)
	end
	
	# Getting input for attack

	def get_input_for_attack (player, opponent, opponent_board)
		puts ""
		puts "#{player.name}: Ready to attack #{opponent.name}'s board?"
		print(opponent_board.read)
		x, y = get_coordinate
		return x, y
	end

	### VALIDATING AND CONVERTING INPUT ###
	
	def validate_coordinate(x, y, msg)
		while !numbers.include?(y) || !letters.include?(x.upcase)
			puts msg
			input = gets.chomp.chars
			if input.count == 2
				x, y = input[0], input[1]
			elsif input.count == 3 && input[1] == '1' && input[2] == '0'
				x, y = input[0], '10'
			else
				x, y = "X", "X"
			end
			msg = "That's not a valid coordinate, try again... (eg A1-J10)"
		end
		return x, y
	end

	def check_direction(direction)
		until valid_directions.include?(direction)
			puts "That direction is not valid, please try again"
			direction = gets.chomp.to_sym
		end
		direction
	end

	def convert(x, y)
		row = letters.index(x.upcase)
		column = numbers.index(y)
		return row, column
	end

	def all_ships_placed terminal_board
		puts "You have placed all your ships. Your final board is: "
		print(terminal_board)
		puts "Please press enter to clear the terminal and continue the game"
		gets.chomp
		system "clear"
	end

	### PRINTING THE GRID ###

	def print_header
		puts " | 1 2 3 4 5 6 7 8 9 10"
	end
	
	def print terminal_board
		print_header
		row_name = ["A","B","C","D","E","F","G","H","I","J"]
		GRID_RANGE.each do |x|
			puts "#{row_name[x]}| #{terminal_board.display_grid[x].join(" ")}"
		end
	end


end






