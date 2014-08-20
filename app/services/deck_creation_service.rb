class DeckCreationService
  TRAIN_CARDS = {
    black: 12,
    white: 12,
    red: 12,
    green: 12,
    blue: 12,
    yellow: 12,
    purple: 12,
    orange: 12,
    wild: 14,
  }

  def make(deck_type, seed)
    @seed = seed
    create_train_deck.shuffle
  end

  def create_train_deck
    cards = make_train_cards

    CardDeck.new cards, random: Random.new(@seed)
  end

  private

  def make_train_cards
    TRAIN_CARDS.flat_map do |color, count|
      count.times.map { TrainCard.new color }
    end
  end
end
