require 'rails_helper'

RSpec.describe GameState do
  describe 'creation' do
    let (:player) { double(:player, name: 'baz') }
    let (:players) { [player] }
    let (:game_state) { GameState.new players }

    it 'takes players and turns them into player state' do
      expect(PlayerState).to receive(:new).with(players.first)

      game_state
    end

    it 'has a deck full of train cards' do
      expect(game_state.train_deck.top).to be_a TrainCard
    end
  end
end