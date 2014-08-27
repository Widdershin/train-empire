class RouteDeckCreationService
  def make(seed)
    CardDeck.new(load_cards, random: Random.new(seed)).shuffle
  end

  def load_cards
    RouteCardLoaderService.new.load
  end
end
