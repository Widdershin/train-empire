require 'rails_helper'
require_relative 'shared_action_spec'

describe Actions::DrawRouteCards do
  it_should_behave_like 'an action'

  let(:action) { Actions::DrawRouteCards.new }

  it 'draws three route cards' do
    game = double(:game, players: [], seed: 1)
    game_state = GameStateCreationService.new(game).make
    current_player = double(:player_state)
    allow(game_state).to receive(:current_player).and_return(current_player)

    expect(current_player)
      .to receive(:set_potential_route_cards)

    action.process current_player, game_state
  end


end
