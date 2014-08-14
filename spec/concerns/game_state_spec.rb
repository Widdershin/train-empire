require 'rails_helper'

RSpec.describe GameState, :type => :model do
  describe 'creation' do
    it 'takes an array of players' do
      players = [double(:player)]
      game_state = GameState.new players

      expect(game_state.players).to eq players
    end

  end
end