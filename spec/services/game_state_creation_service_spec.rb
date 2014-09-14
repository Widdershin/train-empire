require 'rails_helper'

describe GameStateCreationService do
  let (:players) { double(:players) }
  let (:game) { double(:game, seed: 10, players: players) }
  let (:creation_service) { GameStateCreationService.new game }

  describe 'make' do
    let (:player) { double :player, name: 'test', id: 1 }
    let (:game) { double :game, players: [player], seed: 3 }
    let (:game_state) { GameStateCreationService.new(game).make }

    it 'creates a gamestate' do
      expect(game_state.available_train_cards.count).to eq GameState::AVAILABLE_TRAIN_CARDS
      expect(game_state.train_deck.draw).to be_a TrainCard

      expect(game_state.route_deck.draw).to be_a RouteCard

      expect(game_state.players.size).to eq game.players.count

      expect(game_state.link(1)).to_not be_nil
    end
  end
end
