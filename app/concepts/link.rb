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

  def center_x
    city_a.x + (city_b.x - city_a.x) / 2
  end


  def center_y
    city_a.y + (city_b.y - city_a.y) / 2
  end

  def owner_name
    owner ? "Owned by #{owner.name}" : "Unowned"
  end

  def to_s
    owner_name
  end

  def distance_coord
    [(city_b.x - city_a.x), (city_b.y - city_a.y)]
  end

  def line_length
    w, h = distance_coord

    Math.sqrt((w ** 2) + (h ** 2))
  end

  def dasharray
    segment_length = (line_length / cost) * 0.80
    "#{segment_length}, 7"
  end
end
