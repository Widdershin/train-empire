require 'rails_helper'

describe RouteDeckCreationService do
  let(:seed) { 1 }
  let(:creation_service) { RouteDeckCreationService.new }

  it 'makes route decks from a seed' do
    deck = creation_service.make seed

    expect(deck.draw).to be_a RouteCard

    other_deck = creation_service.make (seed + 1)

    cards_to_draw = 10

    expect(deck.top(cards_to_draw)).to_not eq other_deck.top(cards_to_draw)

    deck = creation_service.make seed
    deck_with_same_seed = creation_service.make seed

    expect(deck.random.seed).to eq deck_with_same_seed.random.seed
    expect(deck.top).to eq deck_with_same_seed.top


  end

end
