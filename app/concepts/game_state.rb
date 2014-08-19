class GameState
  attr_reader :players, :train_deck

  def self.make(game)
    train_deck = DeckCreationService.new.make :train, game.seed

    new(game.players, train_deck)
  end

  def initialize(player_states, train_deck)
    @players = player_states
    @train_deck = train_deck
  end
end
