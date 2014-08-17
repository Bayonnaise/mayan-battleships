require_relative 'board'
require_relative 'ship'

class Player

	def initialize(name: "")
		@name = name
		@ships = []
		@interface = UserInput.new
	end

	attr_accessor :name, :board, :ships, :terminal_board, :own_terminal_board, :interface

	def has_lost?
			ships.all? {|ship| ship.sunk?}
	end

# When placing ships

	def place_all_ships
		puts "#{name} - please place your ships:"
		ships.each do |ship| 
			interface.print(own_terminal_board.read)
			coordinate, direction = get_desired_location_of ship
			board.place(ship, at: coordinate, facing: direction)
		end
		interface.all_ships_placed(own_terminal_board.read)
	end


	def get_desired_location_of ship
		loop do
			coordinate, direction = interface.get_input_to_place(ship)
			return coordinate, direction if board.check_valid?(ship, at: coordinate, facing: direction)
		end
	end

# When shooting at ships

	def shoot_at (player, x, y)
		player.board.grid[x][y].hit!
	end


end



