require 'rails_helper'

RSpec.describe CardDeck do
  let (:card) { double :card }
  let (:cards) { [card] }
  let (:deck) { CardDeck.new cards }

  it 'takes an array of cards' do
    expect(deck.cards).to eq cards
  end

  it 'can draw a card' do
    expect(deck.draw).to eq card
  end

  it 'optionally takes an instance of random' do
    expect { CardDeck.new(cards, random: Random.new) }.to_not raise_error
  end
end 