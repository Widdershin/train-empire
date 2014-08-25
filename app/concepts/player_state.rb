INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains, :routes, :id

  def self.from_player(player)
    new player.name, player.id
  end

  def initialize(name, id)
    @name = name
    @id = id
    @hand = []
    @trains = INITIAL_TRAIN_COUNT
    @routes = []
  end

  def add_to_hand(card)
    @hand << card
  end
end
