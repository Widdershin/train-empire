class Actions::ClaimRoute
  def initialize(route_id:)
    @route_id = route_id
  end

  def process(game_state, player)
    game_state.claim_route @route_id, player
  end
end
