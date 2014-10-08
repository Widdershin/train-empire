class PlayerScore
  attr_reader :player
  delegate :name, to: :player

  def initialize(game_state, player)
    @game_state = game_state
    @player = player
  end

  def score
    ScoreCalculationService.new(@game_state, player).score
  end
end
