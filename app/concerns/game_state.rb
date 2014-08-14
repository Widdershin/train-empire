class GameState
  attr_reader :players
  def initialize(players)
    @players = players_to_player_states players
  end

private

  def players_to_player_states(players)
    players.map { |player| PlayerState.new player }
  end
end
