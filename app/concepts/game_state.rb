class GameState
  AVAILABLE_TRAIN_CARDS = 5
  START_HAND_SIZE = 4
  FINAL_TURN_TRAIN_COUNT = 2

  attr_reader :players, :train_deck, :available_train_cards, :route_deck, :links, :cities
  attr_accessor :discarded_train_cards

  def initialize(player_states, train_deck, route_deck, links, cities)
    @players = PlayerManager.new player_states
    @train_deck = train_deck
    @available_train_cards = Pile.new
    @route_deck = route_deck
    @links = links
    @cities = cities
    @final_turn = false
    @discarded_train_cards = []
  end

  def replenish_available_cards
    available_train_cards.refill_from(train_deck)

    self
  end

  def take_available_train_card index
    available_train_cards.take(index)
  end

  def current_player
    players.current_player
  end

  # TODO - name after what it actually does
  def after_action
    refill_train_deck_from_discards! if train_deck.empty?

    discard_available_train_cards! if three_available_train_cards_are_wild?

    replenish_available_cards
  end

  def end_turn
    current_player.mark_played_final_turn! if final_turn?

    @final_turn = any_player_train_count_below_threshold?

    players.advance_current_player
    self
  end

  def claim_link(link_id, player)
    link(link_id).set_owner player
  end

  # TODO - rename to find_link or links.find
  def link(link_id)
    @links.find { |link| link.id == link_id }
  end

  def prepare
    replenish_available_cards
    # TODO - stock is the wrong word
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
      player.potential_routes = route_deck.draw(card_count)
    end
  end

  def any_player_train_count_below_threshold?
    players.map(&:trains).min <= FINAL_TURN_TRAIN_COUNT
  end

  def refill_train_deck_from_discards!
    @train_deck = CardDeck.new(
      discarded_train_cards.pop(discarded_train_cards.count),
      random: train_deck.random,
    ).shuffle
  end

  def discard_available_train_cards!
    @discarded_train_cards += available_train_cards.take_all
  end

  def three_available_train_cards_are_wild?
    available_train_cards.cards.count { |card| card.color == :wild } >= 3
  end

  def final_turn?
    @final_turn
  end

  def game_over?
    players.any? && players.all?(&:played_final_turn?)
  end

  def scores
    scores = players.map { |player| Score.new(self, player) }
    scores.max_by { |score| LongestRouteService.new(self, score.player).longest_route }.mark_longest_route!
    scores.sort_by(&:score).reverse
  end

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck, #{available_train_cards.count} cards available"
  end
end
