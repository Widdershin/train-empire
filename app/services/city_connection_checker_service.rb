class CityConnectionCheckerService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def connected_by?(player)
    visited_cities = [@origin]

    cities_to_visit = @origin.neighbours_connected_by(player)

    while cities_to_visit.any? do
      current_city = cities_to_visit.pop
      return true if current_city == @destination

      visited_cities << current_city

      cities_to_visit +=
        current_city.neighbours_connected_by(player) - visited_cities
    end

    false
  end
end
