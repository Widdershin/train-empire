require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { should have_many :users }

  it 'has a seed' do
    game = Game.create

    expect(game.seed).to be_a Integer
  end

  it 'has a state' do
    expect(Game.create.state).to be_a GameState
  end
end
