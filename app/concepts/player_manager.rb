class PlayerManager
  attr_reader :current_player

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

  def potential_next_index
    current_index + 1
  end

  def next_index
    if next_index_out_of_bounds
      0
    else
      potential_next_index
    end
  end

  def next_index_out_of_bounds
    potential_next_index == players.size
  end

  def players
    @players
  end

  def current_player=(player)
    @current_player = player
  end
end
