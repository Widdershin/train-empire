require 'csv'

class RouteDeckCreationService
  ROUTE_CSV_FILE = "#{Rails.root}/data/route_cards.csv"

  def make(seed)
    CardDeck.new(load_cards, random: Random.new(seed)).shuffle
  end

  private

  def load_cards
    CsvMapper.new(ROUTE_CSV_FILE, RouteCard).load
  end

end
