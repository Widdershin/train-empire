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

  describe '#can_buy?' do
    let(:card) { TrainCard.new(:red) }

    it 'is true if the link has the same color' do
      expect(card.can_buy?(:red)).to eq true
    end

    it 'is false if the link is a different color' do
      expect(card.can_buy?(:green)).to eq false
    end

    it 'is true if the link is gray' do
      expect(card.can_buy?(:gray)).to eq true
    end
  end
end
