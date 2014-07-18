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

		it '' do
			
		end

	end


end

