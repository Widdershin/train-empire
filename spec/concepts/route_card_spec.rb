require 'rails_helper'

describe RouteCard do
  let (:origin) { double :origin_city }
  let (:destination) { double :destination_city }
  let (:card) { RouteCard.new origin, destination }

  it 'has an origin city' do
    expect(card.origin).to be origin
  end

  it 'has a destination city' do
    expect(card.destination).to be destination
  end
end
