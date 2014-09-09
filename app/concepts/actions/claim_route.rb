class Actions::ClaimRoute
  attr_reader :errors

  def initialize(route_id)
    @route_id = route_id
    @errors = []
  end

  def process(player, route)
    player.claim route
  end

  def end_of_turn?
    true
  end

  def args_for(state)
    [state.current_player, state.route(@route_id)]
  end

  def valid?(player, route)
    @errors = []

    player_card_count = player.hand.count { |card| card.color == route.color }

    if player_card_count < route.cost
      @errors << "#{player.name} needs more #{route.color} cards. " +
                 "Has #{player_card_count}, needs #{route.cost}."
    end

    if player.trains < route.cost
      @errors << "#{player} doesn't have enough trains."
    end

    errors.empty?
  end
end
