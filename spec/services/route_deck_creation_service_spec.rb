require 'rails_helper'

describe RouteDeckCreationService do
  let(:seed) { 1 }
  # TODO - isolate these tests
  it 'makes route decks' do
    expect(RouteDeckCreationService.new.make seed).to be_a CardDeck
  end

  describe 'the created deck' do
    let (:deck) { RouteDeckCreationService.new.make seed }

    it 'contains route cards' do
      expect(deck.draw).to be_a RouteCard
    end
  end
end
