require 'rails_helper'

RSpec.describe TrainCard, :type => :model do
  it 'has a color' do
    card = TrainCard.new :red
    expect(card.color).to eq :red
  end
end