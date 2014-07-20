require 'game'

describe Game do

	let (:game) 	{ Game.new							}	
	before(:each) 	{ allow(STDOUT).to receive(:puts) 	}
	before(:each)   { allow(game.interface).to receive(:gets).and_return("Thomas", "Charlotte")}
	
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

	it 'creates a board for each player' do
		game.create_game_elements
		game.players.each do |player|
			expect(player.board).to be_instance_of(Board)
		end

	end

	context 'when creating a fleet' do
		before(:each) { game.create_game_elements		}
		let(:player)  { game.players[0]					}



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



	# context 'when firing at ships' do

	# 	it 'allows a player to shoot at the other player' do
	# 		game.create_game_elements
	# 		player1, player2 = game.players[0], game.players[1]
	# 		game.take_a_shot(player1, target: [0,0])
	# 		expect(player2.board.grid[0][0]).to receive(:hit!)
	# 	end

	# end

context 'when playing the game' do

		it 'can identify the opposite player' do
			game.create_players
			puts game.players
			expect(game.opponent_of(game.players[0])).to eq game.players[1]
		end

		it 'can identify the other opposite player' do
			game.create_players
			expect(game.opponent_of(game.players[1])).to eq game.players[0]
		end


		it 'allows a player to take a turn to shoot opponent' do
			game.create_game_elements
			allow(game.interface).to receive(:get_input_for_attack).and_return([3,4])
			game.take_a_turn(game.players[0])
			expect(game.players[1].board.grid[3][4]).to have_been_hit
		end

		it 'keeps taking turns until a player has lost' do
			game.create_players
			allow(game).to receive(:take_a_turn)
			allow(game.players[0]).to receive(:has_lost?).and_return(false,false,true)
			allow(game.players[1]).to receive(:has_lost?).and_return(false,false,false)
			game.take_turns
			expect(game.take_turns).to eq game.players[0]	
		end

		it 'keeps taking turns until a player has lost' do
			game.create_players
			allow(game).to receive(:take_a_turn)
			allow(game.players[0]).to receive(:has_lost?).and_return(false,false,false,false,false)
			allow(game.players[1]).to receive(:has_lost?).and_return(false,false,false,false,true)
			game.take_turns
			expect(game.take_turns).to eq game.players[1]	
		end

		it 'announces the winner and ends the game' do
			game.create_game_elements
			expect(game.interface).to receive(:announce_final).with(winner: game.players[1],loser: game.players[0])
			game.end_game game.players[0]
		end

	end


end