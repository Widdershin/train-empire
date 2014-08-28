require 'rails_helper'

RSpec.describe GameState do
  let (:player_state) { double :player_state }
  let (:player_state2) { double :player_state2 }

  let (:player_states) { [player_state, player_state2] }
  let (:train_deck) { double :train_deck, count: 105 }
  let (:route_deck) { double :route_deck }

  let (:game_state) do
    GameState.new player_states, train_deck, route_deck
  end

  it 'has a nice string representation' do
    expect(game_state.to_s)
      .to eq 'GameState - 2 players, 105 cards in deck, 0 cards available'
  end

  it 'has a route_deck accessible' do
    expect(game_state.route_deck)
      .to eq route_deck
  end

  describe "#player" do
    it 'returns the player state for the player with the given id' do
      player = double :player, name: 'Tim', id: 5

      allow(game_state)
        .to receive(:players)
        .and_return([player])

      expect(game_state.player player.id).to eq player
    end
  end

  describe "who's turn is it?" do

    it 'has a current_player' do
      expect(game_state.current_player).to eq player_state
    end

    it 'can advance the current_player' do
      game_state.end_turn

      expect(game_state.current_player).to eq player_state2
    end

    it 'cycles back to the first player after everyone has had a go' do
      until game_state.current_player == player_states.last
        game_state.end_turn
      end

      game_state.end_turn

      expect(game_state.current_player).to eq player_states.first
    end
  end
end
