class GameComputerService
  def initialize(game_state, turns)
    @game_state = game_state
    @turns = turns
  end


  def process
    turns.reduce(game_state) do |game_state, turn|
      apply_turn game_state, turn
      game_state.end_turn if turn.end_of_turn? game_state.current_player
      game_state.replenish_available_cards
      game_state
    end
  end

  private

  def apply_turn(state, turn)
    raise "Invalid turn: #{turn.modifiers.map(&:class).join(', ')}" unless turn.valid?
    turn.process state.current_player, state
  end

  private def turns
    @turns
  end

  private def game_state
    @game_state
  end
end
