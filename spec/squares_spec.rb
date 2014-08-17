require 'squares'

describe Square do


	let(:water) {double :water, add_hit: nil}
	let(:square) {Square.new}
	let(:ship) {double :ship }
	before(:each) { allow(STDOUT).to receive(:puts) }
	before(:each) { square.contents = water }

	it 'contains water when created' do
		expect(Square.new.contents).to be_a(Water)
	end

	it 'can contain a ship' do
		square.add_marker_for(:ship)
		expect(square.contents).to eq :ship
	end

	it 'has not been hit when created' do
		expect(square).not_to have_been_hit
	end

	it 'can be hit' do
		square.hit!	
		expect(square).to have_been_hit
	end

	it 'lets a ship know when it has been hit' do
		square.add_marker_for(ship)
		expect(ship).to receive(:add_hit) 
		square.hit!
	end

	it 'reports if it has already been hit' do
		square.hit!
		expect(STDOUT).to receive(:puts).with("You have already targeted this location")
		square.hit!
	end

	it 'does not add a hit to ship if square has already been hit' do
		square.add_marker_for(ship)

		expect(ship).to receive(:add_hit).exactly(1).times
		2.times { square.hit! }
	end


end