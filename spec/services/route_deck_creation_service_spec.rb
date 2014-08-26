require 'rails_helper'

describe RouteDeckCreationService do
  it 'makes route decks' do
    expect(RouteDeckCreationService.new.make).to be_a CardDeck
  end
end
