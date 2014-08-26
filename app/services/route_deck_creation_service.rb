class RouteDeckCreationService
  def make(seed)
    CardDeck.new(RouteCardLoaderService.new.load, random: Random.new(seed))
  end
end
