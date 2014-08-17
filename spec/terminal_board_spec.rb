require 'terminal_board'

describe TerminalBoard do
	
	before(:each) 	{ allow(STDOUT).to receive(:puts) 	}
	let(:player) {Player.new}
	before(:each) {player.board= Board.new}
	let(:terminal_board) {TerminalBoard.new(player.board)}
	before(:each) {player.ships= [Ship.canoe,Ship.longboat]}
	before(:each) {player.board.place(player.ships[0], at: {x:0,y:0}, facing: :h)}
	before(:each) {player.board.place(player.ships[1], at: {x:2,y:0}, facing: :v)}

	it 'Has a board' do
		expect(terminal_board.display_grid).to eq Array.new(10,Array.new(10, " "))
	end

	# it 'Can print a header' do
	# 	expect(terminal_board).to receive(:puts).with (" | 1 2 3 4 5 6 7 8 9 10")
	# 	terminal_board.print_header
	# end

	context 'When a hit has been made'do
		before(:each) {player.board.grid[2][2].hit!}
		before(:each) {player.board.grid[0][0].hit!}

		it 'Assigns an X for a ship which has been hit' do
			terminal_board.read
			expect(terminal_board.display_grid[0][0]).to eq "X"
		end

		it 'Assigns a O for water which has been hit' do
			terminal_board.read
			expect(terminal_board.display_grid[2][2]).to eq "O"
		end
	
	# it 'can print a board' do
	# 	terminal_board.read
	# 	terminal_board.print
	# end

	end

	context 'when a hit has not been made' do

		it 'does not assign an X' do
			terminal_board.read
			expect(terminal_board.display_grid[0][0]).to eq " "
		end

		it 'does not assign an O' do
			terminal_board.read
			expect(terminal_board.display_grid[2][2]).to eq " "
		end

	end

	context 'When a ship has been sunk'do

		before(:each) {player.board.grid[0][0].hit!}
		before(:each) {player.board.grid[0][1].hit!}
		before(:each) {player.board.grid[0][2].hit!}

		it 'Assigns an # for a ship which has been hit' do
			terminal_board.read
			expect(terminal_board.display_grid[0][0]).to eq "#"
		end	
	end

		
end