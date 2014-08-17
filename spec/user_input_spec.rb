require 'user_input'

describe UserInput do
	let(:interface){UserInput.new}
	before(:each) 	{ allow(STDOUT).to receive(:puts) 	}

	it 'returns valid coordinates for A1' do
		allow(interface).to receive(:gets).and_return("A1")
		expect(interface.get_coordinate).to eq([0,0])
	end

	it 'returns valid coordinates for D3' do
		allow(interface).to receive(:gets).and_return("d3")
		expect(interface.get_coordinate).to eq([3,2])
	end

	it 'returns valid coordinates for f10' do
		allow(interface).to receive(:gets).and_return("F10")
		expect(interface.get_coordinate).to eq([5,9])
	end


	it 'does not accept coordinates F45 or banana or 07' do
		allow(interface).to receive(:gets).and_return("F45","banana","07","A4","D1")
		expect(interface.get_coordinate).to eq([0,3])
	end

	it 'only accepts valid directions' do
		allow(interface).to receive(:gets).and_return("banana","A1","h")
		expect(interface.get_direction).to eq(:h)
	end

	it 'returns ship location in correct format' do
		ship = double :ship, name: "ship", length: 3
		allow(interface).to receive(:gets).and_return("A1","h")
		expect(interface.get_input_to_place(ship)).to eq([{x: 0, y: 0}, :h])
	end

	it 'returns a valid target location' do
		player1 = double :player, name: "Sarah"
		player2 = double :player, name: "Anna"
		board = double :board, read: nil
		allow(interface).to receive(:gets).and_return("banana","D4")
		allow(interface).to receive(:print)
		expect(interface.get_input_for_attack(player1,player2,board)).to eq [3,3]

	end 

end
	