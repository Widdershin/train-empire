class GameState
  attr_reader :players, :train_deck
  def initialize(players)
    @players = players_to_player_states players
    @train_deck = create_train_deck
  end

private

  def players_to_player_states(players)
    players.map { |player| PlayerState.new player }
  end

  def create_train_deck
    cards = (1..10).map { TrainCard.new :red }
    deck = CardDeck.new cards
  end
end
