class Score
  LONGEST_ROUTE_SCORE = 10

  attr_reader :player
  delegate :name, to: :player

  def initialize(game_state, player)
    @game_state = game_state
    @player = player
    @longest_route = false
  end

  def score
    ScoreCalculationService.new(@game_state, player).score + longest_route_score
  end

  def longest_route?
    @longest_route
  end

  def mark_longest_route!
    @longest_route = true
  end

  private

  def longest_route_score
    @longest_route ? LONGEST_ROUTE_SCORE : 0
  end
end
