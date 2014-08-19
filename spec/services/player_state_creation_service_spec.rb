require 'rails_helper'

RSpec.describe PlayerStateCreationService do
  let(:player) { double :player }

  describe 'from_player' do
    let(:state) { double :state }

    it 'creates a PlayerState from the player' do

      expect(PlayerState).to receive(:from_player).with(player)
      PlayerStateCreationService.from_player player
    end

    it 'returns the created PlayerState' do
      allow(PlayerState).to receive(:from_player).and_return(state)

      expect(PlayerStateCreationService.from_player player).to eq state
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
