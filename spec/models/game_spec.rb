require 'rails_helper'

RSpec.describe Game, :type => :model do
  let(:game) { Game.create }

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
    end

    let(:player) { game.players.first }
    let(:current_player) { game.state.current_player }

    it 'can process a draw_train_card action' do
      player.actions.create(action: 'draw_train_card', card_index: 1)

      expect(current_player.hand.first).to be_a TrainCard
    end

    it 'can process a draw_route_cards action' do
      player.actions.create(action: 'draw_route_cards')

      expect(current_player.potential_routes.size).to_not eq []
    end

    it 'can process a keep_route_cards action' do
      player.actions.create(action: 'draw_route_cards')
      player.actions.create(action: 'keep_route_cards', route_cards_to_keep: [1, 2])
      expect(game.state.current_player.routes.size).to eq 2
    end

    it 'can process a claim_route action' do
      player.actions.create(action: 'claim_route', route_id: 0)

      expect(game.state.routes(route_id).owner).to eq current_player

    end
  end

end
