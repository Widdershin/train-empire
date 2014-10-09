require 'rails_helper'

describe Pile do
  let(:pile) { Pile.new }

  it 'is enumerable' do
    expect {pile.each { |card| card }}.to_not raise_error
  end

  it 'has a bunch of cards' do
    expect(pile.cards).to eq []
  end

  describe '#refill_from' do
    it 'can be refilled with a deck' do
      card = double :card
      deck = double :deck, draw: card, empty?: false

      pile.refill_from deck

      expect(pile.cards.size).to eq Pile::CARD_LIMIT
    end

    it "doesn't draw from an empty deck" do
      deck = double :deck, empty?: true

      pile.refill_from deck

      expect(pile.cards.size).to eq 0
    end
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

  describe "#take_all" do
    it 'gives you all the cards' do
      cards = [:red, :blue, :green]
      small_pile = Pile.new(cards.dup)

      expect(small_pile.take_all).to eq cards
      expect(small_pile.cards).to be_empty
    end
  end
end
