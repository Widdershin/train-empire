class Actions::ClaimRoute
  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id, action.route_id)
  end

  def initialize(player_id, route_id)
    @route_id = route_id
    @errors = []
  end

  def process(player, game_state)
    route = game_state.route(@route_id)
    player.claim route
  end

  def end_of_turn?(player)
    true
  end

  def valid?(player, game_state)
    route = game_state.route(@route_id)
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
