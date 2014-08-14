INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains
  def initialize(player)
    @name = player.name
    @hand = []
    @trains = INITIAL_TRAIN_COUNT
  end
end