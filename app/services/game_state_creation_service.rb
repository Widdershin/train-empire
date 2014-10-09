class GameStateCreationService
  LINKS_CSV_FILE = "#{Rails.root}/data/links.csv"
  CITIES_CSV_FILE = "#{Rails.root}/data/cities.csv"

  def initialize(game)
    @game = game
    @cities = nil
  end

  def make
    GameState.new(
      player_states,
      train_deck,
      route_deck,
      links.map {|link| link.take_cities(cities)},
      cities.map {|city| city.take_links(links)},
    ).prepare
  end

  private

  def train_deck
    DeckCreationService.new.make :train, @game.seed
  end

  def route_deck
    RouteDeckCreationService.new.make(@game.seed).take_cities!(cities)
  end

  def player_states
    PlayerStateCreationService.from_players(@game.players)
  end

  def links
    @links ||= CsvMapper.new(LINKS_CSV_FILE, Link).load
  end

  def cities
    @cities ||= CsvMapper.new(CITIES_CSV_FILE, City).load
  end
end
