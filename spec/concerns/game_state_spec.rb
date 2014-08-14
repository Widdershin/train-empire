require 'rails_helper'

RSpec.describe GameState, :type => :model do
  describe 'creation' do
    it 'takes players and turns them into player state' do
      players = [double(:player)]

      expect(PlayerState).to receive(:new).with(players.first)

      game_state = GameState.new players
    end
  end
end