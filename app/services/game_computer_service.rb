class GameComputerService
  def initialize(game_state, actions)
    @game_state = game_state
    @actions = actions
  end

  def process
    actions.reduce(game_state) do |game_state, action|
      game_state.replenish_available_cards
      action.process game_state, game_state.current_player
    end
  end

  private def actions
    @actions
  end

  private def game_state
    @game_state
  end
end
