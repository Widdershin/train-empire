class GameComputerService
  def initialize(game_state, turns)
    @game_state = game_state
    @turns = turns
  end

  def process
    # TODO - should be an each
    turns.reduce(game_state) do |game_state, turn|
      turn.process game_state
      # TODO - use current? instead of complete?
      game_state.end_turn if turn.complete?
      game_state
    end
  end

  private

  def turns
    @turns
  end

  def game_state
    @game_state
  end
end
