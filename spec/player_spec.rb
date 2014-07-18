require 'player'

describe Player do
	
	let(:board)	{double :board}
	let(:ships) {double :ships}	
	let(:player) { Player.new(name: "Charlotte")}

	it 'has a name' do
		expect(player.name).to eq "Charlotte"
	end

	it 'knows when it is has not lost' do
		ship = double :ship, sunk?: false
		player.ships = [ship]
		expect(player).not_to have_lost
	end
	
	it 'knows when it is has lost' do
		ship = double :ship, sunk?: true
		player.ships = [ship]
		expect(player).to have_lost
	end

	context 'when placing ships' do

			let(:ship) 				{ double :ship 					}
			before(:each) 			{ player.ships =[ship, ship] 	}
			before(:each) 			{ player.board = double :board, check_valid?: true 	}

		it 'returns coordinates and direction if valid' do
			allow(player.interface).to receive(:get_input_to_place).and_return([{x: 0, y: 0}, :v])
			expect(player.get_desired_location_of ship).to eq([{x: 0, y: 0}, :v])
		end

		it 'only returns a valid coordinates and direction' do
			allow(player.board).to receive(:check_valid?).and_return(false,true)
			allow(player.interface).to receive(:get_input_to_place).and_return([{x: 0, y: 0}, :v], [{x: 5, y: 6}, :h])
			expect(player.get_desired_location_of ship).to eq([{x: 5, y: 6}, :h])
		end

		it 'places all ships of all players' do
			allow(player).to receive(:get_desired_location_of).and_return([{x: 5, y: 6}, :h])
			
			player.ships.each do |ship|
				expect(player.board).to receive(:place).with(ship, at: {x: 5, y:6}, facing: :h)
			end
			player.place_all_ships
		end

	end

	context 'when firing at ships' do


		it 'allows a player to shoot at the other player' do
			player1 = Player.new
			player2 = Player.new
			player2.board = Board.new

			player1.shoot_at(player2, 3,3)
			expect(player2.board.grid[3][3]).to have_been_hit
		end


	end



end
	
