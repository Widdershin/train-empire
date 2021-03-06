class StateModifiers::KeepRouteCards
  attr_reader :cards_to_keep, :errors, :player_id

  def self.from_action(action)
    new(action.player_id, action.route_cards_to_keep)
  end

  def initialize(player_id, cards_to_keep)
    @player_id = player_id
    @cards_to_keep = cards_to_keep.map(&:to_i)
    @errors = []
  end

  def process(current_player, game_state)
    route_deck = game_state.route_deck
    cards_not_kept = current_player.keep_route_cards cards_to_keep
    cards_not_kept.each { |card| route_deck.add_to_bottom(card) }
  end

  def valid?(current_player, route_deck)
    @errors = []

    unless cards_to_keep.all? { |index| current_player.potential_routes.at(index) }
      errors << 'Invalid index'
    end

    unless cards_to_keep.size >= 1
      errors << 'You must draw at least one card'
    end

    errors.empty?
  end
end
