class Pile
  include Enumerable

  CARD_LIMIT = 5

  attr_reader :cards

  def initialize(cards = [])
    @cards = cards
  end

  def each(&block)
    cards.each &block
  end

  def refill_from(deck)
    until full? || deck.empty?
      cards << deck.draw
    end
  end

  def full?
    count == CARD_LIMIT
  end

  def count
    cards.count
  end

  def take(index)
    cards.delete_at index
  end

  def take_all
    cards.pop(cards.count)
  end
end
