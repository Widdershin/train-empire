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

  it 'can calculate a GameState' do
    game.users << create(:user)
    player = game.players.first

    player.actions.create(action: 'draw_train_card', card_index: 0)

    expect(game.state.players.current_player.hand.size).to eq 1

  end
end
