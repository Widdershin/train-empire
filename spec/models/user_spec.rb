require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :games }

  let (:user) { User.create }
  let (:game) { Game.create }

  it 'hosts a new game' do
    user.host_game

    expect(user.games).to_not be_empty
  end

  it 'joins a game' do
    user.join_game game

    expect(user.games).to include game
  end
end
