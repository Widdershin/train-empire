require 'rails_helper'

describe GameStateCreationService do
  let (:players) { double(:players) }
  let (:game) { double(:game, seed: 10, players: players) }
  let (:creation_service) { GameStateCreationService.new game }

  describe 'make' do
    let(:route_deck_creation_service) { double(:route_deck_creation_service) }
    let(:deck_creation_service) { double :deck_creation_service }
    let(:routes_creation_service) { double :route_creation_service }
    let(:fake_train_deck) { double :train_deck }
    let(:fake_route_deck) { double :route_deck }
    let(:fake_player_states) { double :fake_player_states }
    let(:fake_routes) { double :fake_routes }

    it 'creates a gamestate' do
      expect(PlayerStateCreationService)
        .to receive(:from_players)
        .with(game.players)
        .and_return(fake_player_states)


      allow(RouteDeckCreationService)
        .to receive(:new)
        .and_return(route_deck_creation_service)

      expect(route_deck_creation_service)
        .to receive(:make)
        .with(game.seed)
        .and_return(fake_route_deck)


      allow(DeckCreationService)
        .to receive(:new)
        .and_return(deck_creation_service)

      expect(deck_creation_service)
        .to receive(:make)
        .with(:train, game.seed)
        .and_return(fake_train_deck)


      allow(RoutesCreationService)
        .to receive(:new)
        .and_return(routes_creation_service)

      expect(routes_creation_service)
        .to receive(:make)
        .and_return(fake_routes)


      expect(GameState)
        .to receive(:new)
        .with(fake_player_states, fake_train_deck, fake_route_deck, fake_routes)

      creation_service.make
    end
  end
end
