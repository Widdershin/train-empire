class ScoreCalculationService
  LINK_COST_TO_SCORE = {
    1 => 1,
    2 => 2,
    3 => 4,
    4 => 7,
    5 => 10,
    6 => 15,
  }

  def initialize(game_state, player)
    @game_state = game_state
    @player = player
  end

  def score
    route_score + link_score
  end

  def link_score
    @game_state.links.map do |link|
      if link.owner == @player
        LINK_COST_TO_SCORE[link.cost]
      else
        0
      end
    end.reduce(&:+)
  end

  def route_score
    @player.routes.map do |route|
      score_modifier =
        CityConnectionCheckerService.new(route.origin, route.destination)
        .connected_by?(@player) ? 1 : -1

      route.points * score_modifier
    end.reduce(&:+)
  end
end
