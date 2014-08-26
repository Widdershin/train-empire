require 'rails_helper'

describe RouteDeckCreationService do
  it 'makes route decks' do
    seed = 1
    expect(RouteDeckCreationService.new.make seed).to be_a CardDeck
  end
end
