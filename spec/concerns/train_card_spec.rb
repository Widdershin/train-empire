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
end