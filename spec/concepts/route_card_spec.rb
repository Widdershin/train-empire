require 'rails_helper'

describe RouteCard do
  let (:origin) { double :origin_city }
  let (:destination) { double :destination_city }
  let (:points) { 10 }
  let (:card) { RouteCard.new origin: origin, destination: destination, points: points }

  it 'has points' do
    expect(card.points).to eq points
  end
end
