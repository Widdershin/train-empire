class GameState
  AVAILABLE_TRAIN_CARDS = 5
  attr_reader :players, :train_deck, :available_train_cards, :route_deck

  def initialize(player_states, train_deck, route_deck, routes)
    @players = PlayerManager.new player_states
    @train_deck = train_deck
    @available_train_cards = Pile.new
    @route_deck = route_deck
    @routes = routes
  end

  def replenish_available_cards
    available_train_cards.refill_from train_deck

    self
  end

  def take_available_train_card index
    available_train_cards.take index
  end

  def current_player
    players.current_player
  end

  def end_turn
    players.advance_current_player

    players.players.each do |player|
      player.remaining_draws = 2
    end

    self
  end

  def claim_route(route_id, player)
    route(route_id).set_owner player
  end

  def route(id)
    @routes.find { |route| route.id == id }
  end

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck, #{available_train_cards.count} cards available"
  end
end
