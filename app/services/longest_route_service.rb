class LongestRouteService
  def initialize(game_state, player)
    @game_state = game_state
    @player = player
  end

  def longest_route
    player_starting_cities.map { |city| calc_longest_route(city) }.max.to_i
  end

  private

  def player_starting_cities
    @game_state.links.select { |link| link.owner == @player }
      .flat_map {|link| [link.city_a, link.city_b] }.uniq
  end

  def calc_longest_route(start_city, visited_cities = [])
    cities_to_visit =
      start_city.neighbours_connected_by(@player) - visited_cities

    if cities_to_visit.empty?
      return 0
    end

    deepest_route_city = cities_to_visit.max_by do |city|
      calc_longest_route(city, visited_cities + [start_city])
    end

    start_city.cost_of_link(deepest_route_city) +
      calc_longest_route(deepest_route_city, visited_cities + [start_city])
  end
end
