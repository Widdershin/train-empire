class Route
  attr_reader :id, :owner

  def initialize(id:, city_a_id:, city_b_id:, cost:)
    @id = id.to_i
    @owner = nil
  end

  def set_owner(owner)
    @owner = owner
  end
end
