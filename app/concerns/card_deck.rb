class CardDeck
  attr_reader :cards
  def initialize(cards, random: Random.new)
    @cards = cards
    @random = random
  end
end