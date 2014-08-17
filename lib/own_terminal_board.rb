class OwnView

	GRID_RANGE = (0..9)	

	attr_reader :display_grid, :terminal_board

	def initialize terminal_board
		@terminal_board = terminal_board
		@display_grid = terminal_board.display_grid
	end

	def read
		@terminal_board.read
		add_ships_location
	end

	def add_ships_location
		GRID_RANGE.each do |x|
			GRID_RANGE.each do |y|
				if @display_grid[x][y] == " " && terminal_board.board.grid[x][y].contents.is_a?(Ship)
					@display_grid[x][y] = "+"
				end
			end
		end	
		self
	end


end