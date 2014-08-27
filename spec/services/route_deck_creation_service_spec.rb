require 'rails_helper'

describe RouteDeckCreationService do
  let(:creation_service) { RouteDeckCreationService.new }
  let (:cards) { double :cards }
  let(:seed) { 1 }
  # TODO - isolate these tests

  describe 'the created deck' do
    let (:deck) { double :deck }

    before do
      allow(creation_service)
        .to receive(:load_cards)
        .and_return(cards)

      allow(CardDeck)
        .to receive(:new)
        .and_return(deck)

      allow(deck)
        .to receive(:shuffle)
        .and_return(deck)
    end

    it 'shuffles the deck' do
      expect(deck)
        .to receive(:shuffle)
    end

    it 'passes the loaded cards into the new deck' do
      expect(CardDeck)
        .to receive(:new)
        .with(cards, anything)
    end

    it 'returns the created deck' do
      expect(creation_service.make seed).to eq deck
    end

    after { creation_service.make seed }
  end

  describe 'load_cards' do
    it 'loads the cards from RouteCardLoaderService and returns it' do
      loader_service = double :loader_service

      allow(RouteCardLoaderService)
        .to receive(:new)
        .and_return(loader_service)

      expect(loader_service)
        .to receive(:load)
        .and_return(cards)

      expect(creation_service.load_cards)
        .to eq cards
    end
  end
end
