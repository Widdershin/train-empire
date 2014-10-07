class StateModifiers::DrawWildCard
  attr_accessor :player_id, :errors

  def self.from_action(action)
    new(action.player_id, action.card_index)
  end

  def initialize(player_id, card_index)
    @player_id = player_id
    @card_index = card_index
    @errors = []
  end

  def process(player, game_state)
    player.add_to_hand game_state.available_train_cards.take(@card_index)
  end

  def valid?(player, game_state)
    unless game_state.available_train_cards.cards.at(@card_index).color == :wild
      errors << 'You must draw a wild card with this action'
    end

    errors.none?
  end
end
