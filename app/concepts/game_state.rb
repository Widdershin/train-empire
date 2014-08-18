class GameState
  attr_reader :players, :train_deck, :seed

  def initialize(players, seed)
    @players = players_to_player_states players
    @train_deck = create_train_deck
    @seed = seed
  end

private

  def players_to_player_states(players)
    players.map { |player| PlayerState.new player }
  end

  def create_train_deck
    DeckFactory.new.make :train
  end
end
