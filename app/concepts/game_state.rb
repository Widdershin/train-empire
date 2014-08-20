class GameState
  attr_reader :players, :train_deck, :available_train_cards

  def self.make(game)
    train_deck = DeckCreationService.new.make :train, game.seed
    new(PlayerStateCreationService.from_players(game.players), train_deck)
  end

  def initialize(player_states, train_deck)
    @players = player_states
    @train_deck = train_deck
    @available_train_cards = []
  end
end
