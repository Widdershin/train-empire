require 'rails_helper'
require_relative 'shared_action_spec'

describe Actions::ClaimRoute do
  it_should_behave_like 'an action'

  let(:action) { Actions::ClaimRoute.new(player_id, route_id) }
  let(:player_id) { 1 }
  let(:route_id) { 2 }

  describe 'process' do
    it 'claims the route with the given id' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make

      player = double(:player_state)

      expect(player)
        .to receive(:claim)
        .with(kind_of(Route))

      action.process(player, game_state)
    end
  end
end
