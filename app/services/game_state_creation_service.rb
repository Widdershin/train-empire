class GameStateCreationService
  ROUTES_CSV_FILE = "#{Rails.root}/data/links.csv"
  CITIES_CSV_FILE = "#{Rails.root}/data/cities.csv"

  def initialize(game)
    @game = game
  end

  def make
    GameState.new(
      player_states,
      train_deck,
      route_deck,
      routes,
      cities,
    ).replenish_available_cards
  end

  private

  def train_deck
    DeckCreationService.new.make :train, @game.seed
  end

  def route_deck
    RouteDeckCreationService.new.make @game.seed
  end

  def player_states
    PlayerStateCreationService.from_players(@game.players)
  end

  def routes
    CsvMapper.new(ROUTES_CSV_FILE, Link).load.map { |route| route.take_cities(cities) }
  end

  def cities
    CsvMapper.new(CITIES_CSV_FILE, City).load
  end
end
