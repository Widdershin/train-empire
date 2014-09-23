class GameState
  AVAILABLE_TRAIN_CARDS = 5
  START_HAND_SIZE = 4
  attr_reader :players, :train_deck, :available_train_cards, :route_deck, :links, :cities

  def initialize(player_states, train_deck, route_deck, links, cities)
    @players = PlayerManager.new player_states
    @train_deck = train_deck
    @available_train_cards = Pile.new
    @route_deck = route_deck
    @links = links
    @cities = cities
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
    self
  end

  def claim_link(link_id, player)
    link(link_id).set_owner player
  end

  def link(link_id)
    @links.find { |link| link.id == link_id }
  end

  def prepare
    replenish_available_cards
    stock_player_hands
    stock_player_routes

    self
  end

  def stock_player_hands
    players.each do |player|
      START_HAND_SIZE.times { player.add_to_hand(train_deck.draw) }
    end
  end

  def stock_player_routes
    card_count = StateModifiers::DrawRouteCards::ROUTE_DECK_DRAW_COUNT
    players.each do |player|
      player.set_potential_route_cards(route_deck.draw(card_count))
    end
  end

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck, #{available_train_cards.count} cards available"
  end
end
