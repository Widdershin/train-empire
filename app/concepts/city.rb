class City
  attr_reader :id, :name, :x, :y

  def initialize(id:, name:, x:, y:)
    @id = id
    @name = name
    @x = x.to_i
    @y = y.to_i
  end

  def to_s
    "#{name}"
  end
end
