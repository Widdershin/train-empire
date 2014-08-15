require 'rails_helper'

RSpec.describe DeckFactory do
  let (:factory) { DeckFactory.new }

  describe "creating a Train Deck" do
    it 'creates a train deck populated with cards' do
      deck = factory.make :train

      expect(deck.top).to be_a TrainCard
    end

    it 'shuffles the deck' do
      deck = double :deck
      allow(CardDeck).to receive(:new).and_return deck

      expect(deck).to receive(:shuffle)

      factory.make :train
    end

    it 'has a map of cards needed' do
      expect(factory.train_cards_needed[:red]).to eq 12
    end

    it 'creates a deck with the number of cards from train_cards_needed' do
      deck = factory.make :train
      red_cards = deck.cards.count { |card| card.color == :red }

      expect(red_cards).to eq factory.train_cards_needed[:red]
    end
  end
end