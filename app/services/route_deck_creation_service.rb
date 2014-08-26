class RouteDeckCreationService
  def make(seed)
    CardDeck.new([], random: Random.new(seed))
  end
end
