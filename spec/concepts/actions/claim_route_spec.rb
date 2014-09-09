require 'rails_helper'

describe Actions::ClaimRoute do
  let(:route_id) { 5 }

  describe 'process' do
    it 'claims the route with the given id' do
      action = Actions::ClaimRoute.new(route_id)
      route = double(:route)
      player = double(:player_state)

      expect(player)
        .to receive(:claim)
        .with(route)

      action.process(player, route)
    end
  end
end
