require 'rails_helper'

describe Actions::ClaimRoute do
  let(:route_id) { 2 }

  describe 'process' do
    it 'claims the route with the given id' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make

      player = double(:player_state)

      action = Actions::ClaimRoute.new(route_id)

      expect(player)
        .to receive(:claim)
        .with(kind_of(Route))

      action.process(player, game_state)
    end
  end
end
