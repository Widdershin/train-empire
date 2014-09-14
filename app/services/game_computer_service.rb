class GameComputerService
  def initialize(game_state, state_modifiers)
    @game_state = game_state
    @state_modifiers = state_modifiers
  end


  def process
    state_modifiers.reduce(game_state) do |game_state, state_modifier|
      apply_state_modifier game_state, state_modifier
      game_state.end_turn if state_modifier.end_of_turn? game_state.current_player
      game_state.replenish_available_cards
      game_state
    end
  end

  private

  def apply_state_modifier(state, state_modifier)
    raise "Invalid state_modifier: #{state_modifier.errors.join ', '}" unless state_modifier.valid? state.current_player, state
    state_modifier.process state.current_player, state
  end

  private def state_modifiers
    @state_modifiers
  end

  private def game_state
    @game_state
  end
end
