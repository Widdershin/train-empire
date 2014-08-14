class PlayerState
  attr_reader :player, :name
  def initialize(player)
    @name = player.name
  end
end