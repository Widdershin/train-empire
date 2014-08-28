require 'rails_helper'

describe GameStateCreationService do
  let (:players) { double(:players) }
  let (:game) { double(:game, seed: 10, players: players) }
  let (:creation_service) { GameStateCreationService.new game }

  describe 'make' do
    let(:fake_train_deck) { double :train_deck }
    let(:fake_route_deck) { double :route_deck }
    let(:fake_player_states) { double :fake_player_states }

    before do
      allow(creation_service)
        .to receive_messages(
          train_deck: fake_train_deck,
          route_deck: fake_route_deck,
          player_states: fake_player_states,
        )

      allow(GameState)
        .to receive(:new)
    end

    it 'gets a train deck' do
      expect(creation_service)
        .to receive(:train_deck)

      creation_service.make
    end

    it 'gets a route deck' do
      expect(creation_service)
        .to receive(:route_deck)

      creation_service.make
    end

    it 'gets the player states' do
      expect(creation_service)
        .to receive(:player_states)

      creation_service.make
    end

    it 'creates a gamestate' do
      expect(GameState)
        .to receive(:new)
        .with(fake_player_states, fake_train_deck, fake_route_deck)

      creation_service.make
    end

    it 'returns the created gamestate' do
      fake_game_state = double :game_state

      allow(GameState)
        .to receive(:new)
        .and_return(fake_game_state)

      expect(creation_service.make).to eq fake_game_state
    end
  end

  describe 'train_deck' do
    it 'asks DeckCreationService for a train deck' do
      deck_creation_service = double :deck_creation_service

      allow(DeckCreationService)
        .to receive(:new)
        .and_return(deck_creation_service)

      expect(deck_creation_service)
        .to receive(:make)
        .with(:train, game.seed)

      creation_service.train_deck
    end
  end

  describe 'route_deck' do
    it 'asks RouteDeckCreationService for a route deck' do
      route_deck_creation_service = double(:route_deck_creation_service)

      allow(RouteDeckCreationService)
        .to receive(:new)
        .and_return(route_deck_creation_service)

      expect(route_deck_creation_service)
        .to receive(:make)
        .with(game.seed)

      creation_service.route_deck
    end
  end

  describe 'player_states' do
    it "asks PlayerStateCreationService to make the states from the games players" do
      expect(PlayerStateCreationService)
        .to receive(:from_players)
        .with(game.players)

      creation_service.player_states
    end
  end
end
