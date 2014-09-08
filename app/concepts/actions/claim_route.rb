class Actions::ClaimRoute
  attr_reader :errors

  def initialize(route_id)
    @route_id = route_id
    @errors = []
  end

  def process(player, route)
    route.set_owner player
  end

  def end_of_turn?
    true
  end

  def args_for(state)
    [state.current_player, state.route(@route_id)]
  end

  def valid?(player, route)
    @errors = []

    if player.hand.count { |card| card.color == route.color } < route.cost
      @errors << "#{player} needs more #{route.color} cards."
    end

    if player.trains < route.cost
      @errors << "#{player} doesn't have enough trains."
    end

    errors.empty?
  end
end
