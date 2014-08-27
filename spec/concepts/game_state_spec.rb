require 'rails_helper'

RSpec.describe GameState do
  let (:player_states) { double :player_states, size: 2 }
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
      .to be_a Pile
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
end
