require 'rails_helper'

RSpec.describe CardDeck do
  it 'takes an array of cards' do
    card = double :card

    cards = [card]

    deck = CardDeck.new cards

    expect(deck.cards).to eq cards
  end

  it ''

  it 'optionally takes an instance of random' do
    card = double :card

    cards = [card]

    expect { CardDeck.new(cards, random: Random.new) }.to_not raise_error
  end
end