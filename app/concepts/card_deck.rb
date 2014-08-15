class CardDeck
  attr_reader :random

  def initialize(cards, random:)
    @cards = cards
    @random = random
  end

  def draw
    cards.pop
  end

  def shuffle
    cards.shuffle!(random: random)

    self
  end

  def top(count = nil)
    count ? cards.last(count) : cards.last
  end

  private def cards
    @cards
  end
end