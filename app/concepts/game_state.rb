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
    @available_train_cards = Pile.new
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

  def to_s
    "#{self.class.name} - #{players.size} players, #{train_deck.count} cards in deck, #{available_train_cards.count} cards available"
  end
end
