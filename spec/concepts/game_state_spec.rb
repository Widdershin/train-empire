require 'rails_helper'

RSpec.describe GameState do
  describe 'creation' do
    let (:player) { double(:player, name: 'baz') }
    let (:players) { [player] }
    let (:train_deck) { double :train_deck }
    let (:game_state) { GameState.new players, train_deck }

    it 'takes a train_deck' do
      expect(game_state.train_deck).to eq train_deck
    end

    it 'takes players and turns them into player state' do
      expect(PlayerState).to receive(:new).with(players.first)

      game_state
    end
  end
end
