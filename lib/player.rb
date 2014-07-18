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

	def place_all_ships
		puts "Please place your ships, #{name}:"
		ships.each do |ship| 
			coordinate, direction = get_desired_location_of ship
			# interface.print(own_terminal_board.read)
			board.place(ship, at: coordinate, facing: direction)
		end
	end


	def get_desired_location_of ship
		begin
			coordinate, direction = interface.get_input_to_place(ship)
			# coordinate = {x: row.to_i, y: column.to_i}
		end while !board.check_valid?(ship, at: coordinate, facing: direction)
			
		return coordinate, direction
	end

	def get_target
		puts "It's your turn, #{name}"
		row, column = interface.get_input_for_attack
		return row, column
	end

	def fire_shot(target, row, column)
		target.board.grid[row.to_i][column.to_i].hit!
	end

end



