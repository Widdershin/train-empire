class StateModifiers::DrawTrainCard
  attr_reader :errors, :player_id, :card_index

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
  end

  def valid?(current_player, game_state)
    @errors = []
    card = Maybe.wrap(game_state.available_train_cards.cards.at(@card_index))

    if card.nil?
      @errors << 'Invalid card index'
    end

    unless card.color != :wild
      @errors << "You can't draw wildcards with #{self.class}"
    end

    @errors.empty?
  end
end
