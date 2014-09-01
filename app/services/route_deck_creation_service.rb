require 'csv'

class RouteDeckCreationService
  def make(seed)
    CardDeck.new(load_cards, random: Random.new(seed)).shuffle
  end

  private

  def load_cards
    RouteCardLoaderService.new.load
  end


  class RouteCardLoaderService
    ROUTE_CSV_FILE = "#{Rails.root}/data/routes.csv"

    def load
      data_from_file.map { |csv_hash| RouteCard.new(**csv_hash) }
    end

    private

    def data_from_file
      CSV.read(ROUTE_CSV_FILE, headers: true).map do |csv_row|
        csv_row.to_hash.symbolize_keys
      end
    end
  end
end
