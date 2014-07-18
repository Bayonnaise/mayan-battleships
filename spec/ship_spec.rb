require 'ship'

describe Ship do

	let(:ship) { Ship.new }

	context 'when launched on maiden voyage' do

		it 'has a length' do
			expect(ship.length).to eq Ship::DEFAULT_LENGTH
		end

		it 'has a name' do
			ship = Ship.new(name: "Sarah")
			expect(ship.name).to eq "Sarah"
		end

		it 'can be created with a length of 5' do
			ship = Ship.new(length: 5)
			expect(ship.length).to eq 5
		end

	end

	context 'when under fire' do

		it "knows how many times it's been hit" do
			expect(ship.hit_count).to eq 0
		end

		it 'can be hit' do
			ship.add_hit
			expect(ship.hit_count).to eq 1
		end

		it 'can be sunk' do
			allow(STDOUT).to receive(:puts)
			expect(ship.sunk?).to be false
			3.times {ship.add_hit}
			expect(ship.sunk?).to be true
		end

		it 'reports if it has been sunk' do
			canoe = Ship.canoe
			allow(STDOUT).to receive(:puts).with("Direct hit, el capitan!")
			expect(STDOUT).to receive(:puts).with("You sunk your opponent's ship!")
			3.times {canoe.add_hit}
		end

	end

	context 'list of active ships in Mayan fleet' do
	
		it 'can be a raft' do
			raft = Ship.raft
			expect(raft.length).to eq 2
		end

		it 'can be a canoe' do
			canoe = Ship.canoe
			expect(canoe.length).to eq 3
		end
		
		it 'can be a shortboat' do
			shortboat = Ship.shortboat
			expect(shortboat.length).to eq 4
		end

		it 'can be a longboat' do
			longboat = Ship.longboat
			expect(longboat.length).to eq 6
		end


	end


end