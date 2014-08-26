require 'rails_helper'

describe RouteCardLoaderService do
  it 'loads route cards' do
    expect(RouteCardLoaderService.new.load.first).to be_a RouteCard
  end

  describe '#load' do
    let(:loader) { RouteCardLoaderService.new }

    before do
      fake_route_data = {
        origin: :origin_city,
        destination: :destination_city,
        points: 10
      }

      fake_data = [
        fake_route_data
      ]

      allow(loader)
        .to receive(:data_from_file)
        .and_return(fake_data)
    end

    it 'loads the data from the routes file' do
      expect(loader)
        .to receive(:data_from_file)

      loader.load
    end
  end
end
