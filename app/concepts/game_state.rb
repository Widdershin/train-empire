class GameState
  AVAILABLE_TRAIN_CARDS = 5
  attr_reader :players, :train_deck, :available_train_cards, :route_deck
  attr_reader :current_player

  def initialize(player_states, train_deck, route_deck)
    @players = player_states
    @train_deck = train_deck
    @available_train_cards = Pile.new
    @route_deck = route_deck
    @current_player = player_states.first
  end

  def replenish_available_cards
    available_train_cards.refill_from train_deck

    self
  end

  def take_available_train_card index
    available_train_cards.take index
  end

  def player(id)
    players.find { |player| player.id == id }
  end

  def end_turn
    current_player_index = players.find_index(current_player)
    new_index = current_player_index + 1

    if new_index > players.length - 1
      new_index = 0
    end
    @current_player = players[new_index]
  end

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck, #{available_train_cards.count} cards available"
  end
end
