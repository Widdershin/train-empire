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

    it 'asks DeckFactory for a train deck' do
      deck = double :train_deck
      factory = double :factory, make: deck
      expect(DeckFactory).to receive(:new).and_return(factory)

      game_state
    end
  end
end