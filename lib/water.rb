require_relative 'user_input'

class Water
	def initialize
		@interface = UserInput.new
	end

	attr_reader :interface

	def add_hit
		interface.message(:water_hit)
	end
end