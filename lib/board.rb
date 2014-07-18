
require_relative 'squares'
require_relative 'water'
require_relative 'user_input'

class Board

	attr_reader :grid, :interface

	def initialize
		@grid = Array.new(10) { Array.new(10) { Square.new } }
		@interface = UserInput.new
	end

	def place ship, at: coordinate, facing: direction
			ship.length.times do
				@grid[at[:x]][at[:y]].add_marker_for(ship)
				facing == :h ? at[:y] += 1 : at[:x] += 1
			end
	end

	def check_valid?(ship, at: coordinate, facing: direction)
		ship.length.times do
			if at[:x] > 9 || at[:y] > 9 || !@grid[at[:x]][at[:y]].contents.is_a?(Water)
				interface.message(:duplicate_ship)
				return false
			else
				facing == :h ? at[:y] += 1 : at[:x] += 1
			end
		end
		true
	end
end


