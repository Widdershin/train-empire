class Actions::DrawTrainCard
  def initialize(card_index)
    @card_index = card_index
  end

  def process(current_player, train_deck)
    current_player.add_to_hand(train_deck.take @card_index)
  end

  def end_of_turn?
    true
  end

  def args_for(state)
    [state.current_player, state.available_train_cards]
  end
end
