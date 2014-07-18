require 'own_terminal_board'

describe OwnView do
	let(:player) {Player.new}
	before(:each) {player.board= Board.new}
	let(:terminal_board) {TerminalBoard.new(player.board)}
	before(:each) {player.ships= [Ship.canoe,Ship.longboat]}
	before(:each) {player.board.place(player.ships[0], at: {x:0,y:0}, facing: :h)}
	before(:each) {player.board.place(player.ships[1], at: {x:2,y:0}, facing: :v)}

	let(:own_terminal_board) {OwnView.new(terminal_board)}
	

	context 'When a hit has been made'do
		before(:each) {player.board.grid[2][2].hit!}
		before(:each) {player.board.grid[0][0].hit!}

		it 'Assigns an X for a ship which has been hit' do
			own_terminal_board.read
			expect(own_terminal_board.display_grid[0][0]).to eq "X"
		end

		it 'Assigns a O for water which has been hit' do
			own_terminal_board.read
			expect(own_terminal_board.display_grid[2][2]).to eq "O"
		end

		it 'assigns a + for ships which have been placed' do
			own_terminal_board.read
			expect(own_terminal_board.display_grid[0][1]).to eq "+"
		end

	end

end