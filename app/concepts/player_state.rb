INITIAL_TRAIN_COUNT = 45

class PlayerState
  attr_reader :name, :hand, :trains, :routes, :id, :potential_routes, :color

  def self.from_player(player)
    new player.name, player.id, color: player.color
  end

  def initialize(name, id, color: '#000000')
    @name = name
    @id = id
    @hand = []
    @trains = INITIAL_TRAIN_COUNT
    @routes = []
    @potential_routes = []
    @color = color
    @played_final_turn = false
  end

  def add_to_hand(card)
    @hand << card
    @hand.sort_by!(&:color)
  end

  # TODO - attr_writer
  def set_potential_route_cards(cards)
    @potential_routes = cards
  end

  # TODO - route card manager maybe
  def keep_route_cards(card_indices)
    kept_cards = card_indices.map { |index| @potential_routes.at index }
    returned_cards = @potential_routes - kept_cards
    @routes += kept_cards
    @potential_routes.clear
    returned_cards
  end

  def claim(link, cards_to_spend)
    link.set_owner self
    @trains -= link.cost
    spend_cards(cards_to_spend)
  end

  def spend_cards(indices)
    @hand.select!.with_index { |card, index| indices.exclude? index }
  end

  def can_claim?(link, indices)
    cards = @hand.values_at(*indices)

    colors_without_wild = cards.map(&:color).uniq - [:wild]

    return false if cards.count != link.cost
    return false if colors_without_wild.count > 1
    return false unless cards.all? { |card| card.can_buy? link.color }

    cards.all?
  end

  def played_final_turn?
    @played_final_turn
  end

  def mark_played_final_turn!
    @played_final_turn = true
  end

  def to_s
    "#{name}. #{hand.size} cards in hand, " +
    "#{trains} trains. Holding #{routes.size} routes"
  end
end
