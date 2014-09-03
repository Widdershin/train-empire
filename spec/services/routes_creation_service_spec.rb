require 'rails_helper'

describe RoutesCreationService do
  describe 'make' do
    it 'loads routes from the routes.csv' do
      route = RoutesCreationService.new.make.first
      expect(route).to be_a Route
    end
  end
end
