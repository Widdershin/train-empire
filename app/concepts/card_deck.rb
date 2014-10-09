class CardDeck
  attr_reader :random

  def initialize(cards, random:)
    @cards = cards
    @random = random
  end

  def draw(count = nil)
    raise 'no cards' if empty?
    count ? cards.pop(count) : cards.pop
  end

  def draw_random
    cards.delete cards.sample(random: random)
  end

  def shuffle
    cards.shuffle!(random: random)

    self
  end

  def top(count = nil)
    count ? cards.last(count) : cards.last
  end

  def count
    cards.count
  end

  def add_to_bottom(card)
    cards.unshift card
  end

  def take_cities!(cities)
    cards.each { |card| card.take_cities!(cities) }
    self
  end

  def empty?
    cards.empty?
  end

  private def cards
    @cards
  end
end
