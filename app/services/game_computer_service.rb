class GameComputerService
  def initialize(actions)
    @actions = actions
  end

  def compute
    game_state = new_game_state

    apply_actions game_state
  end

  def apply_actions(game_state)
    @actions.each do |action|
      game_state = action.apply game_state
    end
  end

  def new_game_state
    GameState.new
  end
end

class GameState
end


# #compute
# Create a game state object
# For each action
#   call the action's modifier on the game
# Return the game
# 
# 
# 
