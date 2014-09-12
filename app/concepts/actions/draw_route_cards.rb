class Actions::DrawRouteCards
  ROUTE_DECK_DRAW_COUNT = 3

  attr_reader :errors

  def self.from_action(action)
    new
  end

  def process(player, game_state)
    route_deck = game_state.route_deck
    player.set_potential_route_cards(route_deck.draw ROUTE_DECK_DRAW_COUNT)
  end

  def end_of_turn?(player)
    false
  end

  def valid?(player, state)
    true
  end

end
