require 'rails_helper'

RSpec.describe DeckCreationService do
  let (:factory) { DeckCreationService.new }

  describe "creating a Train Deck" do
    let (:seed) { 2934235 }

    it 'takes a seed' do
      deck = factory.make :train, seed

      expect(deck.random.seed).to eq seed
    end

    it 'creates a train deck populated with cards' do
      deck = factory.make :train, seed

      expect(deck.top).to be_a TrainCard
    end

    it 'shuffles the deck' do
      deck = double :deck
      allow(CardDeck).to receive(:new).and_return deck

      expect(deck).to receive(:shuffle)

      factory.make :train, seed
    end

    it 'has a map of cards needed' do
      expect(DeckCreationService::TRAIN_CARDS[:red]).to eq 12
    end

    it 'creates a deck with the number of cards from TRAIN_CARDS' do
      DeckCreationService::TRAIN_CARDS.each do |color, quantity|
        expect(TrainCard).to receive(:new).exactly(quantity).times.with(color)
      end

      factory.make :train, seed
    end
  end
end
