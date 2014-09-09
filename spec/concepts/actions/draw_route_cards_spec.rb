require 'rails_helper'

describe Actions::DrawRouteCards do
  it 'draws three route cards' do
    game = double(:game, players: [], seed: 1)
    game_state = GameStateCreationService.new(game).make
    current_player = double(:player_state)
    allow(game_state).to receive(:current_player).and_return(current_player)

    action = Actions::DrawRouteCards.new

    expect(current_player)
      .to receive(:set_potential_route_cards)

    action.process current_player, game_state
  end


end
