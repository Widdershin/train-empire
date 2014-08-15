class DeckFactory
  def make(deck_type)
    deck = create_train_deck

    deck.shuffle

    deck
  end

  def create_train_deck
    cards = make_train_cards

    CardDeck.new cards
  end

  def train_cards_needed
    {
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
  end

  private

  def make_train_cards
    train_cards_needed.map do |color, count|
      make_train_cards_for_color color, count
    end.flatten
  end

  def make_train_cards_for_color(color, count)
    (1..count).map { TrainCard.new color }
  end
end