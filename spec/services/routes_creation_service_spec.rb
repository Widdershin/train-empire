require 'rails_helper'

describe RoutesCreationService do
  describe 'make' do
    it 'loads routes from the routes.csv' do
      route = RoutesCreationService.new.make.first
      expect(route).to be_a Route
    end
  end

  it 'sets the owner' do
    route = Route.new(id: 1, city_a_id: 1, city_b_id: 2, cost: 5)

    expect(route.owner).to eq nil

    player = double :player

    route.set_owner player

    expect(route.owner).to eq player
  end
end
