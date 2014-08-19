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

  describe 'make' do
    let (:game) { double :game, seed: 10 }

    it 'creates a train deck and passes it in' do
      fake_deck = double :deck
      fake_creation_service = double :creation_service, make: fake_deck

      allow(DeckCreationService).to receive(:new).and_return(fake_creation_service)

      expect(fake_creation_service).to receive(:make).with(:train, game.seed)
      GameState.make game
    end
  end
end
