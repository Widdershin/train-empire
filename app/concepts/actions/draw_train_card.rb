class Actions::DrawTrainCard
  def initialize(card_index)
    @card_index = card_index
  end

  def process(game_state, current_player)
    card = game_state.take_available_train_card(@card_index)

    current_player.add_to_hand card

    game_state
  end

  def end_of_turn?
    true
  end
end
