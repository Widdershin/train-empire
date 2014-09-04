class Actions::ClaimRoute
  def initialize(route_id)
    @route_id = route_id
  end

  def process(game_state, player)
    game_state.claim_route @route_id, player

    game_state
  end

  def end_of_turn?
    true
  end
end
