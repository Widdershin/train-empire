require 'rails_helper'

describe Actions::DrawRouteCards do
  it 'draws three route cards' do
    route_deck = double(:route_deck)
    current_player = double(:player_state)

    action = Actions::DrawRouteCards.new

    allow(route_deck)
      .to receive(:draw)
      .and_return(:cards)

    expect(current_player)
      .to receive(:set_potential_route_cards)
      .with(:cards)

    action.process current_player, route_deck
  end


end
