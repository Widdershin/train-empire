require 'rails_helper'

describe CityConnectionCheckerService do
  it 'checks if cities are connected' do
    player = PlayerState.new(1, 'Foo')
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

    link.take_cities([wellington, auckland])
    route_card.take_cities!([wellington, auckland])

    wellington.take_links([link])
    auckland.take_links([link])

    checker = CityConnectionCheckerService.new(wellington, auckland)

    expect(checker.connected_by?(player)).to eq false

    link.set_owner(player)

    expect(checker.connected_by?(player)).to eq true
  end

  it 'can check deep connections' do
    player = PlayerState.new(1, 'Foo')
    christchurch = City.new(id: 0, name: 'Chch', x: 0, y: 0)
    wellington = City.new(id: 1, name: 'Wellington', x: 0, y: 0)
    auckland = City.new(id: 2, name: 'Auckland', x: 0, y: 0)

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
      cost: 0,
      color: :gray,
    )

    link.set_owner(player)
    link2.set_owner(player)

    link.take_cities([wellington, auckland])
    link2.take_cities([wellington, christchurch])

    [wellington, auckland, christchurch].each { |city| city.take_links([link, link2]) }
    checker = CityConnectionCheckerService.new(auckland, christchurch)

    expect(checker.connected_by?(player)).to eq true

  end
end
