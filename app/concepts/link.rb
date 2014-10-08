class Link
  attr_reader :id, :owner, :cost, :color, :city_a, :city_b, :curve_offset_x, :curve_offset_y

  DEFAULT_CURVE_OFFSET = 0

  def initialize(id:, city_a_id:, city_b_id:, cost:, color:, curve_offset_x: 0, curve_offset_y: 0)
    @id = id.to_i
    @owner = nil
    @city_a_id = city_a_id
    @city_b_id = city_b_id
    @cost = cost.to_i
    @color = color.to_sym
    @curve_offset_x = curve_offset_x.to_f
    @curve_offset_y = curve_offset_y.to_f
  end

  def inspect
    "Link from #{city_a} to #{city_b}"
  end

  def set_owner(owner)
    @owner = owner
  end

  def take_cities(cities)
    @city_a = cities.find { |city| city.id == @city_a_id }
    @city_b = cities.find { |city| city.id == @city_b_id }
    self
  end

  def other(city)
    if city == city_a
      city_b
    elsif city == city_b
      city_a
    end
  end
end
