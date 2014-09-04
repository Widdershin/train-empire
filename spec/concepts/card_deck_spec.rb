require 'rails_helper'

RSpec.describe CardDeck do
  let (:card) { double :card }
  let (:cards) { [card] }
  let (:random) { double :random }
  let (:deck) { CardDeck.new cards, random: random }
  let(:bigger_deck) { CardDeck.new cards * 3, random: random }

  it 'can draw a card' do
    expect(deck.draw).to eq card
  end

  it 'can draw x cards' do
    expect(bigger_deck.draw(2)).to eq [card, card]
  end

  it 'shuffles the cards' do
    expect(cards).to receive(:shuffle!).with(random: random)

    deck.shuffle
  end

  it 'gives you the top card' do
    expect(deck.top).to eq card
  end

  it 'gives you the top x cards' do

    expect(bigger_deck.top(2)).to eq [card, card]
  end

  it 'gives you the count of cards in the deck' do
    expect(deck.count).to eq cards.size
  end

  it 'adds cards to the bottom' do
    expect{ deck.add_to_bottom(:card) }.to change {deck.count}.by(1)
  end
end
