class RouteCard
  attr_accessor :origin, :destination, :points

  def initialize(origin:, destination:, points:)
    @origin = origin
    @destination = destination
    @points = points
  end

  def ==(other)
    origin == other.origin &&
      destination == other.destination &&
      points == other.points
  end
end
