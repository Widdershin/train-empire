INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains, :routes

  def self.from_player(player)
    new player.name
  end

  def initialize(name)
    @name = name
    @hand = []
    @trains = INITIAL_TRAIN_COUNT
    @routes = []
  end
end
