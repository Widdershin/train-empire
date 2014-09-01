require 'rails_helper'

describe Actions::DrawRouteCards do
  it 'draws three route cards' do
    game_state = double(:game_state)
    current_player = double(:player_state)

    action = Actions::DrawRouteCards.new

    expect(game_state)
      .to receive(:draw_route_cards)
      .and_return(:cards)

    expect(current_player)
      .to receive(:set_potential_route_cards)
      .with(:cards)

    action.process(game_state, current_player)
  end

end
