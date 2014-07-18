require 'game'

describe Game do

	let (:game) 	{ Game.new							}	
	before(:each) 	{ allow(STDOUT).to receive(:puts) 	}
	before(:each)   { allow(game.interface).to receive(:gets).and_return("Thomas", "Charlotte")}
	before(:each) 	{ allow(STDOUT).to receive(:puts) 	}
	
	it 'creates two players' do
		game.create_players
		expect(game.players.count).to eq Game::NUMBER_OF_PLAYERS
	end

	it 'requires a name for each player' do
		game.create_players
		expect(game.players[0].name).to eq "Thomas"
	end

	it 'has only players' do
		game.players.each do |player|
			player.is_a?(Player)
		end
	end

	context 'when creating a fleet' do
		before(:each) {game.create_players		}
		before(:each) {game.create_ships		}
		let(:player)  {game.players[0]			}



		it 'gives each player the correct number of rafts' do
			ships = player.ships.select do |ship|
				ship.length == 2
			end

			expect(ships.count).to eq Game::NUMBER_OF_RAFTS
		end

		it 'gives each player the correct number of canoes' do
			ships = player.ships.select do |ship|
				ship.length == 3
			end

			expect(ships.count).to eq Game::NUMBER_OF_CANOES
		end

		it 'gives each player the correct number of shortboats' do
			ships = player.ships.select do |ship|
				ship.length == 4
			end

			expect(ships.count).to eq Game::NUMBER_OF_SHORTBOATS
		end

		it 'gives each player the correct number of longboats' do
			ships = player.ships.select do |ship|
				ship.length == 6
			end

			expect(ships.count).to eq Game::NUMBER_OF_LONGBOATS
		end

		it 'contains only ships' do
			not_ships = player.ships.reject do |ship|
				ship.is_a?(Ship)
			end
			expect(not_ships).to eq []
		end

	end

	context 'when in set-up phase' do

		it 'asks each player in turn to place their ships' do
			# Do we need to test this?
		end

	end

context 'when playing the game' do


	end
end