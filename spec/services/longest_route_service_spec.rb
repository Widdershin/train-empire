require 'rails_helper'

describe LongestRouteService do
  it 'calculates the longest route' do
    player = PlayerState.new('Foo', 5)

    wellington = City.new(id: 1, name: 'Wellington', x: 0, y: 0)
    auckland = City.new(id: 2, name: 'Auckland', x: 0, y: 0)
    christchurch = City.new(id: 3, name: 'Christchurch', x:0, y: 0)

    link = Link.new(
      id: 1,
      city_a_id: wellington.id,
      city_b_id: auckland.id,
      cost: 2,
      color: :gray,
    )

    link2 = Link.new(
      id: 2,
      city_a_id: wellington.id,
      city_b_id: christchurch.id,
      cost: 3,
      color: :gray,
    )

    link.take_cities([wellington, auckland])
    link2.take_cities([christchurch, wellington])

    [wellington, auckland, christchurch].each {|city| city.take_links([link, link2])}

    game_state = GameState.new(
      [player],
      [],
      [],
      [link, link2],
      [wellington, auckland, christchurch],
    )

    calculator = LongestRouteService.new(game_state, player)

    expect(calculator.longest_route).to eq 0

    link.set_owner(player)

    expect(calculator.longest_route).to eq link.cost

    link2.set_owner(player)

    expect(calculator.longest_route).to eq (link.cost + link2.cost)
  end
end
