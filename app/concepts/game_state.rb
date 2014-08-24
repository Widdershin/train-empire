class GameState
  AVAILABLE_TRAIN_CARDS = 5
  attr_reader :players, :train_deck, :available_train_cards

  def self.make(game)
    train_deck = DeckCreationService.new.make :train, game.seed
    game_state = new(
      PlayerStateCreationService.from_players(game.players),
      train_deck
    )
    game_state.replenish_available_cards
  end

  def initialize(player_states, train_deck)
    @players = player_states
    @train_deck = train_deck
    @available_train_cards = []
  end

  def replenish_available_cards
    until available_train_cards_full? do
      available_train_cards << train_deck.draw
    end

    self
  end

  def available_train_cards_full?
    available_train_cards.size == AVAILABLE_TRAIN_CARDS
  end

  def take_available_train_card index
    available_train_cards.delete_at index
  end

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck"
  end
end
