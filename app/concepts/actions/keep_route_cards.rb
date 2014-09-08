class Actions::KeepRouteCards
  attr_reader :cards_to_keep

  def initialize(cards_to_keep)
    @cards_to_keep = cards_to_keep
  end

  def process(current_player, route_deck)
    # given the list of cards to keep
    # tell the player to keep the cards with those indexes
    # get the remaining cards back from the player and put the on the bottom of the route deck

    current_player.keep_route_cards cards_to_keep
    cards_not_kept = current_player.return_unkept_route_cards
    cards_not_kept.each { |card| route_deck.place_on_bottom(card) }
  end

  def end_of_turn?
    true
  end

  def args_for(state)
    [state.current_player, state.route_deck]
  end
end
