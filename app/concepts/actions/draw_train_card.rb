class Actions::DrawTrainCard
  def initialize(player, card_index)
    @player = player
    @card_index = card_index
  end

  def process(game_state)
    card = game_state.take_available_train_card @card_index
    @player.add_to_hand card

    game_state
  end
end
