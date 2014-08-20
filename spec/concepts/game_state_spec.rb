require 'rails_helper'

RSpec.describe GameState do
  describe 'make' do
    let (:players) { double :players, map: self }
    let (:game) { double :game, seed: 10, players: players }
    let (:fake_deck) { double :deck }
    let (:creation_service) { double :creation_service, make: fake_deck }
    let(:player_states) { double :player_states }

    before do
      allow(DeckCreationService)
        .to receive(:new)
        .and_return(creation_service)

      allow(PlayerStateCreationService)
        .to receive(:from_players)
        .and_return(player_states)
    end

    describe "collaboration" do
      it "creates a train deck with the game's seed" do
        expect(creation_service)
          .to receive(:make)
          .with(:train, game.seed)
      end

      it "passes the game's players to PlayerStateCreationService" do
        expect(PlayerStateCreationService)
          .to receive(:from_players)
          .with(game.players)
      end

      it "creates an instance on GameState with a deck and players" do
        expect(GameState)
          .to receive(:new)
          .with(player_states, fake_deck)
      end

      after { GameState.make game }
    end

  end
end
