require 'rails_helper'

RSpec.describe GameState do
  describe 'make' do
    let (:players) { double :players, map: self }
    let (:game) { double :game, seed: 10, players: players }
    let (:fake_deck) { double :deck }
    let (:creation_service) { double :creation_service, make: fake_deck }

    before do
      allow(DeckCreationService).to receive(:new).and_return(creation_service)
    end

    it 'creates a train deck and passes it in' do
      expect(creation_service).to receive(:make).with(:train, game.seed)
    end

    it "passes in the game's players" do
      expect(GameState).to receive(:new).with(game.players, fake_deck)
    end

    after { GameState.make game }
  end
end
