require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :games }
  it { should validate_presence_of :username }
  it { should validate_uniqueness_of :username }

  let (:user) { create :user }
  let (:game) { Game.create }

  it 'hosts a new game' do
    user.host_game

    expect(user.games).to_not be_empty
  end

  describe "joining games" do
    it 'joins a game' do
      user.join_game game

      expect(user.games).to include game
    end

    it "doesn't join the same game twice" do
      user.join_game game

      user.join_game game

      expect(user.games.count game.id).to eq 1
     end
  end
end
