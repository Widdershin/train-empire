require 'rails_helper'

RSpec.describe PlayerStateCreationService do
  let(:player) { double :player }
  let(:state) { double :state }

  describe 'from_player' do
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
    let(:players) { [player, player, player] }

    it 'maps the players to PlayerStates' do
      players.each { expect(PlayerStateCreationService).to receive(:from_player).with(player) }

      PlayerStateCreationService.from_players players
    end

    it 'returns the mapped states' do
      allow(PlayerStateCreationService).to receive(:from_player).and_return(state)

      expect(PlayerStateCreationService.from_players players).to eq [state, state, state]
    end
  end
end
