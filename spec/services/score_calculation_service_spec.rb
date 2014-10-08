require 'rails_helper'

describe ScoreCalculationService do
  it 'figures out a players score' do
    player = PlayerState.new('Foo', 5)

    wellington = City.new(id: 1, name: 'Wellington', x: 0, y: 0)
    auckland = City.new(id: 2, name: 'Auckland', x: 0, y: 0)

    link = Link.new(
      id: 1,
      city_a_id: wellington.id,
      city_b_id: auckland.id,
      cost: 2,
      color: :gray,
    )

    route_card = RouteCard.new(
      origin: wellington.id,
      destination: auckland.id,
      points: 5,
    )

    route_card.take_cities!([wellington, auckland])
    link.take_cities([wellington, auckland])

    [wellington, auckland].each {|city| city.take_links([link])}
    player.set_potential_route_cards([route_card])
    player.keep_route_cards([0])

    game_state = GameState.new(
      [player],
      [],
      [route_card],
      [link],
      [wellington, auckland],
    )

    calculator = ScoreCalculationService.new(game_state, player)

    expect(calculator.score).to eq -route_card.points

    link.set_owner(player)

    link_score = ScoreCalculationService::LINK_COST_TO_SCORE[link.cost]

    expect(calculator.score).to eq route_card.points + link_score
  end
end
