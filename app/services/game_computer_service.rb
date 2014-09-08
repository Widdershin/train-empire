class GameComputerService
  def initialize(game_state, actions)
    @game_state = game_state
    @actions = actions
  end


  def process
    actions.reduce(game_state) do |game_state, action|
      apply_action game_state, action
      game_state.end_turn if action.end_of_turn?
      game_state.replenish_available_cards
      game_state
    end
  end

  private

  def apply_action(state, action)
    args = *action.args_for(state)
    raise "Invalid Action: #{action.errors.join ', '}" unless action.valid? *args
    action.process *args
  end

  private def actions
    @actions
  end

  private def game_state
    @game_state
  end
end
