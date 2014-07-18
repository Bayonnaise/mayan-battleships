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

end



