class Actions::DrawRouteCards
  ROUTE_DECK_DRAW_COUNT = 3

  def process(player, route_deck)
    player.set_potential_route_cards(route_deck.draw ROUTE_DECK_DRAW_COUNT)
  end

  def end_of_turn?
    false
  end
end
