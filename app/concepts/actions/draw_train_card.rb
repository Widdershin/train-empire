class Actions::DrawTrainCard
  def initialize(card_index)
    @card_index = card_index
  end

  def process(current_player, game_state)
    available_train_cards = game_state.available_train_cards
    current_player.add_to_hand(available_train_cards.take(@card_index))
  end

  def end_of_turn?
    true
  end

  def valid?(current_player, game_state)
    @card_index < game_state.available_train_cards.count
  end
end
