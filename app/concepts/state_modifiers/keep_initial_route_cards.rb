class StateModifiers::KeepInitialRouteCards < StateModifiers::KeepRouteCards
  MINIMUM_KEEP_COUNT = 2

  def valid?(player, game_state)
    @errors = []

    unless cards_to_keep.size >= MINIMUM_KEEP_COUNT
      errors << 'You must keep at least two route cards'
    end

    errors.empty?
  end
end
