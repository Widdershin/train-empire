class Actions::KeepRouteCards
  attr_reader :cards_to_keep

  def initialize(cards_to_keep)
    @cards_to_keep = cards_to_keep
  end
end
