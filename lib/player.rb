require_relative 'board'
require_relative 'ship'

class Player

	def initialize(name: "")
		@name = name
		@ships = []
	end

	attr_accessor :name, :board, :ships, :terminal_board, :own_terminal_board

	def has_lost?
			ships.all? {|ship| ship.sunk?}
	end

	def place_ships
		puts "Please place your ships, #{player.name}:"
		ships.each do |ship| 
			interface.print(own_terminal_board.read)
			begin
				row, column, direction = interface.get_input_to_place(ship)
				coordinate = {x: row.to_i, y: column.to_i}
			end while !board.check_valid?(ship, at: coordinate, facing: direction.to_sym)
			
			coordinate = {x: row.to_i, y: column.to_i}
			board.place(ship, at: coordinate, facing: direction.to_sym)
		end
	end

end



