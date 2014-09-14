class Link
  attr_reader :id, :owner, :cost, :color

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
end
