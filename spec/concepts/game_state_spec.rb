require 'rails_helper'

RSpec.describe GameState do
  let (:player_state) { double :player_state }
  let (:player_state2) { double :player_state2 }

  let (:player_states) { [player_state, player_state2] }
  let (:train_deck) { double :train_deck, count: 105 }
  let (:route_deck) { double :route_deck, draw: :route_card }

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

  it 'draws from the route card deck' do
    expect(route_deck)
      .to receive(:draw)
      .with(GameState::ROUTE_DECK_DRAW_COUNT)
      .and_return(:potential_routes)

    expect(game_state.draw_route_cards)
      .to eq :potential_routes
  end
end
