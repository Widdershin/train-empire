require 'rails_helper'

describe Actions::ClaimRoute do
  it { should respond_to :process }

  describe 'process' do
    let(:route_id) { 5 }
    it 'claims the route with the given id' do
      action = Actions::ClaimRoute.new(route_id: route_id)
      game_state = double(:game_state)
      player = double(:player_state)

      expect(game_state)
        .to receive(:claim_route)
        .with(route_id)

      action.process(game_state, player)
    end
  end
end
