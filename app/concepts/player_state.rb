INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains, :routes, :id, :potential_routes

  def self.from_player(player)
    new player.name, player.id
  end

  def initialize(name, id)
    @name = name
    @id = id
    @hand = []
    @trains = INITIAL_TRAIN_COUNT
    @routes = []
    @potential_routes = []
  end

  def add_to_hand(card)
    @hand << card
  end

  def set_potential_route_cards(cards)
    @potential_routes = cards
  end
end
