class Actions::ClaimRoute
  def initialize(route_id)
    @route_id = route_id
  end

  def process(player, game_state)
    game_state.claim_route @route_id, player
  end

  def end_of_turn?
    true
  end

  def args_for(state)
    [state.current_player, state]
  end
end
