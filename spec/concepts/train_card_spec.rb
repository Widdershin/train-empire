require 'rails_helper'

RSpec.describe TrainCard, :type => :model do
  it 'has a color' do
    card = TrainCard.new :red
    expect(card.color).to eq :red
  end

  it 'has a string representation' do
    card = TrainCard.new :blue

    expect(card.to_s).to eq 'Blue Train Card'
  end

  it 'has a cost' do
    card = TrainCard.new :blue

    expect(card.cost).to eq TrainCard::COST

    wildcard = TrainCard.new :wild

    expect(wildcard.cost).to eq TrainCard::WILD_COST
  end
end
