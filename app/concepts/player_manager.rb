class PlayerManager
  attr_reader :current_player, :players

  def initialize(player_states)
    @players = player_states
    @current_player = players.first
  end

  def advance_current_player
    self.current_player = next_player
  end

  def next_player
    players.at next_index
  end

  def size
    @players.size
  end

  private

  def current_index
    players.find_index current_player
  end

  def next_index
    (current_index + 1) % players.size
  end

  def current_player=(player)
    @current_player = player
  end
end
