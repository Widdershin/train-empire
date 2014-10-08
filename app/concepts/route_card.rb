class RouteCard
  attr_accessor :origin, :destination, :points

  def initialize(origin:, destination:, points:)
    @origin_id = origin
    @destination_id = destination
    @points = points.to_i
  end

  def ==(other)
    origin == other.origin &&
      destination == other.destination &&
      points == other.points
  end

  def to_s
    "Connect #{origin} to #{destination} for #{points} points."
  end

  def inspect
    to_s
  end

  def take_cities!(cities)
    @origin = cities.find { |city| city.id == @origin_id }
    @destination = cities.find { |city| city.id == @destination_id }
  end
end
