class Actions::DrawRouteCards
  def process(game_state, current_player)
    cards = game_state.draw_route_cards
    current_player.set_potential_route_cards cards
  end
end
