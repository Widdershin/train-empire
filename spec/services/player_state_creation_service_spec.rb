require 'rails_helper'

RSpec.describe PlayerStateCreationService do
  let(:player) { double :player }
  describe 'from_player' do

    it 'creates a PlayerState from the player' do
      state = double :state

      expect(PlayerState).to receive(:from_player).with(player).and_return(state)
      PlayerStateCreationService.from_player player
    end
  end

  describe 'from_players' do
    it 'maps the players to PlayerStates' do
      players = [player, player, player]

      players.each { expect(PlayerStateCreationService).to receive(:from_player).with(player) }

      PlayerStateCreationService.from_players players
    end
  end
end
