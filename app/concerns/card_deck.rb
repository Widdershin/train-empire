class CardDeck
  attr_reader :cards, :random
  def initialize(cards, random: Random.new)
    @cards = cards
    @random = random
  end

  def draw
    cards.pop
  end

  def shuffle
    cards.shuffle(random: random)
  end

  def top(*args)
    cards.last *args
  end
end