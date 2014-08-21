class Actions::DrawRailcarCard
  def initialize(player, game_state, card_index)
    @player = player
    @game_state = game_state
    @card_index = card_index
  end

  def process
    @game_state.take_available_train_card(@card_index)
  end
end
