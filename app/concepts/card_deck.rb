class CardDeck
  attr_reader :random

  def initialize(cards, random:)
    @cards = cards
    @random = random
  end

  def draw(count = nil)
    count ? cards.pop(count) : cards.pop
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

  private def cards
    @cards
  end
end
