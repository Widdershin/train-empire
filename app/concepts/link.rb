class Link
  attr_reader :id, :owner, :cost, :color, :city_a, :city_b

  def initialize(id:, city_a_id:, city_b_id:, cost:, color:)
    @id = id.to_i
    @owner = nil
    @city_a_id = city_a_id
    @city_b_id = city_b_id
    @cost = cost.to_i
    @color = color.to_sym
  end

  def set_owner(owner)
    @owner = owner
  end

  def take_cities(cities)
    @city_a = cities.find { |city| city.id == @city_a_id }
    @city_b = cities.find { |city| city.id == @city_b_id }
    self
  end
end
