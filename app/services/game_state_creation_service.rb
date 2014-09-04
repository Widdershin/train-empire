class GameStateCreationService
  def initialize(game)
    @game = game
  end

  def make
    GameState.new(
      player_states,
      train_deck,
      route_deck,
      routes,
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
    RoutesCreationService.new.make
  end
end
