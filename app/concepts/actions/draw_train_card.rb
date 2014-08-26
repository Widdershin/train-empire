class Actions::DrawTrainCard
  def initialize(player_id, card_index)
    @player_id = player_id
    @card_index = card_index
  end

  def process(game_state)
    card = game_state.take_available_train_card(@card_index)

    game_state.player(@player_id).add_to_hand card

    game_state
  end
end
