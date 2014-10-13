require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { Game.create }
  let(:test_seed) { 5 }

  it { should have_many :users }
  it { should have_many :players }
  it { should have_many :actions }

  it 'has a seed' do
    expect(game.seed).to be_a Integer
  end

  it 'has a state' do
    expect(game.state).to be_a GameState
  end

  # this is really an integration test, and should live in another file
  describe 'integration' do
    before do
      game.users << create(:user)
      game.seed = test_seed
      game.save!
    end

    let(:player) { game.players.first }
    let(:current_player) { game.state.current_player }

    it 'can process a draw_train_card action' do
      player.actions.create(name: 'draw_train_card', card_index: 1)

      expect(current_player.hand.first).to be_a TrainCard
    end

    it 'can process a draw_route_cards action' do
      player.actions.create(name: 'draw_route_cards')

      expect(current_player.potential_routes.size).to_not eq []
    end

    it 'can process a keep_route_cards action' do
      player.actions.create(name: 'draw_route_cards')
      player.actions.create(name: 'keep_route_cards', route_cards_to_keep: [1, 2])
      expect(game.state.current_player.routes.size).to eq 2
    end
  end

  describe '#turns' do
    it 'breaks the games actions up into turns' do
      game = Game.create

      2.times { game.users << create(:user) }

      player1 = game.players.first
      player2 = game.players.last

      player1.actions.create(
        name: 'draw_train_card',
        card_index: 0,
      )

      player1.actions.create(
        name: 'draw_train_card',
        card_index: 2,
      )

      player2.actions.create(
        name: 'draw_route_cards',
      )

      player2.actions.create(
        name: 'keep_route_cards',
      )

      player1.actions.create(
        name: 'draw_route_cards',
      )

      turns = game.turns

      expect(turns.first).to be_a Turn
      expect(turns.size).to eq 3

      expect(turns.last.modifiers.size).to eq 1
    end
  end
end
