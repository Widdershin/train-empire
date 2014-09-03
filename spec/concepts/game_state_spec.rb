require 'rails_helper'

RSpec.describe GameState do
  let (:player_state) { double :player_state }
  let (:player_state2) { double :player_state2 }

  let (:player_states) { [player_state, player_state2] }
  let (:train_deck) { double :train_deck, count: 105 }
  let (:route_deck) { double :route_deck, draw: :route_card }
  let (:route) { double :route, id: 1, owner: nil }
  let (:route2) { double :route2, id: 2, owner: nil }
  let (:routes) { [route, route2] }

  let (:game_state) do
    GameState.new player_states, train_deck, route_deck, routes
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

  describe 'routes' do
    describe 'claim_route' do
      it 'claims the route for the player' do
        player = double :player_state

        expect(route)
          .to receive(:set_owner)
          .with(player)

        game_state.claim_route(route.id, player)
      end
    end
  end
end
