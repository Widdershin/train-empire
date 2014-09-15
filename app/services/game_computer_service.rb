class GameComputerService
  def initialize(game_state, turns)
    @game_state = game_state
    @turns = turns
  end


  def process
    turns.reduce(game_state) do |game_state, turn|
      raise "Invalid turn: #{error_message(turn)}" unless turn.valid?
      turn.process game_state
    end
  end

  private

  def error_message(turn)
    turn.modifiers.map(&:class).join(', ')
  end

  def turns
    @turns
  end

  def game_state
    @game_state
  end
end
