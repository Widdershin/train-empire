class PlayerState
  attr_reader :name, :hand
  def initialize(player)
    @name = player.name
    @hand = []
  end
end