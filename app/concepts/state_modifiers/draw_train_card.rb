class StateModifiers::DrawTrainCard
  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id, action.card_index)
  end

  def initialize(player_id, card_index)
    @player_id = player_id
    @card_index = card_index
    @errors = []
  end

  def process(current_player, game_state)
    available_train_cards = game_state.available_train_cards
    card = available_train_cards.take(@card_index)
    current_player.add_to_hand(card)

    current_player.remaining_draws -= card.cost
  end

  def end_of_turn?(current_player)
    result = (current_player.remaining_draws <= 0)
  end

  def valid?(current_player, game_state)
    @card_index < game_state.available_train_cards.count
  end
end
