INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains, :routes, :id, :potential_routes
  attr_accessor :remaining_draws

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
    @remaining_draws = 2
  end

  def add_to_hand(card)
    @hand << card
  end

  def set_potential_route_cards(cards)
    @potential_routes = cards
  end

  def keep_route_cards(card_indices)
    kept_cards = card_indices.map { |index| @potential_routes.at index }
    returned_cards = @potential_routes - kept_cards
    @routes += kept_cards
    @potential_routes.clear
    returned_cards
  end

  def claim(link)
    link.set_owner self
    @trains -= link.cost
    spend_cards(link.cost, link.color)
  end

  def spend_cards(count, color)
    count.times do
      hand.delete_at(hand.find_index { |card| card.color == color })
    end
  end

  def to_s
    "#{name}. #{hand.size} cards in hand, " +
    "#{trains} trains. Holding #{routes.size} routes"
  end
end
