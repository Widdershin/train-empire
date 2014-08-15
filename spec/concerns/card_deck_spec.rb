require 'rails_helper'

RSpec.describe CardDeck do
  let (:card) { double :card }
  let (:cards) { [card] }
  let (:random) { double :random }
  let (:deck) { CardDeck.new cards, random: random }

  it 'takes an array of cards' do
    expect(deck.cards).to eq cards
  end

  it 'can draw a card' do
    expect(deck.draw).to eq card
  end

  it 'shuffles the cards' do
    expect(cards).to receive(:shuffle).with(random: random)

    deck.shuffle
  end
end