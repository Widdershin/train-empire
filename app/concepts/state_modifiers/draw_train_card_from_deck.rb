class StateModifiers::DrawTrainCardFromDeck
  attr_reader :errors, :player_id

  def self.from_action(action)
    new(action.player_id)
  end

  def initialize(player_id)
    @player_id = player_id
  end

  def process(current_player, game_state)
    current_player.add_to_hand(game_state.train_deck.draw_random)
  end

  def valid?(player, state)
    true
  end
end
