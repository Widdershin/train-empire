class StateModifiers::DrawRouteCards
  ROUTE_DECK_DRAW_COUNT = 3

  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id)
  end

  def initialize(player_id)
    @player_id = player_id
  end

  def process(player, game_state)
    route_deck = game_state.route_deck
    player.set_potential_route_cards(route_deck.draw ROUTE_DECK_DRAW_COUNT)
  end

  def valid?(player, state)
    true
  end

end
