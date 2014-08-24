require 'rails_helper'

RSpec.describe Game, :type => :model do
  it { should have_many :users }

  it 'has a seed' do
    game = Game.create

    expect(game.seed).to be_a Integer
  end
end
