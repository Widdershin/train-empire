class Actions::KeepRouteCards
  attr_reader :cards_to_keep, :errors

  def initialize(cards_to_keep)
    @cards_to_keep = cards_to_keep
    @errors = []
  end

  def process(current_player, game_state)
    route_deck = game_state.route_deck
    cards_not_kept = current_player.keep_route_cards cards_to_keep
    cards_not_kept.each { |card| route_deck.add_to_bottom(card) }
  end

  def end_of_turn?(player)
    true
  end

  def valid?(current_player, route_deck)
    current_player.potential_routes.any?
  end
end
