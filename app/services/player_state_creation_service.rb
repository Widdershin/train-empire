class PlayerStateCreationService
  def self.from_player(player)
    PlayerState.from_player player
  end

  def self.from_players(players)
    players.map &method(:from_player)
  end
end

