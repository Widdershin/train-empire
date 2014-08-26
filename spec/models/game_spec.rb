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
end
