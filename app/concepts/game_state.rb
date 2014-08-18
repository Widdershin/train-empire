class GameState
  attr_reader :players, :train_deck

  def initialize(players, train_deck)
    @players = players_to_player_states players
    @train_deck = train_deck
  end

private

  def players_to_player_states(players)
    players.map { |player| PlayerState.new player }
  end
end
