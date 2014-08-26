require 'rails_helper'

describe Pile do
  let(:pile) { Pile.new }

  it 'has a bunch of cards' do
    expect(pile.cards).to eq []
  end

  it 'can be refilled with a deck' do
    card = double :card
    deck = double :deck, draw: card

    pile.refill_from deck

    expect(pile.cards.size).to eq Pile::CARD_LIMIT
  end

  it 'has a size limit' do
    expect(Pile::CARD_LIMIT).to be_a Fixnum
  end

  describe '#full?' do
    it 'returns true if there are the same number of cards as the limit' do
      allow(pile)
        .to receive(:count)
        .and_return(Pile::CARD_LIMIT)

      expect(pile.full?).to be true
    end

    it 'returns false if there are less cards than the limit' do
      allow(pile)
        .to receive(:count)
        .and_return(Pile::CARD_LIMIT - 1)

      expect(pile.full?).to be false
    end
  end

  it 'has a count' do
    expect(pile.count).to eq pile.cards.count
  end

  it 'lets you take a card' do
    allow(pile)
      .to receive(:cards)
      .and_return [1, 2, 3, 4, 5]

    expect(pile.take 2).to eq 3
  end
end
