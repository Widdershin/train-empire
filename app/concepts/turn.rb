class Turn
  attr_writer :current
  attr_reader :modifiers

  def initialize(state_modifiers, current: false)
    @modifiers = state_modifiers
    @current = current
  end

  def process(game_state)
    modifiers.reduce(game_state) do |game_state, modifier|
      apply_modifier(game_state, modifier)
      game_state.end_turn if modifier.end_of_turn? game_state.current_player
      game_state.replenish_available_cards
      game_state
    end
  end

  def valid?
    valid_modifier_pattern? or current?
  end

  def current?
    @current
  end

  private

  def apply_modifier(game_state, modifier)
    raise error_message(modifier) unless modifier.valid? game_state.current_player, game_state
    modifier.process(game_state.current_player, game_state)
  end

  def error_message(modifier)
    "Invalid Modifier: #{modifier}, #{modifier.errors.join (', ')}"
  end

  def valid_modifier_pattern?
    [
      [StateModifiers::ClaimLink],
      [StateModifiers::DrawTrainCard, StateModifiers::DrawTrainCard],
      [StateModifiers::DrawRouteCards, StateModifiers::KeepRouteCards],
    ].include?(modifiers.map(&:class))
  end
end
