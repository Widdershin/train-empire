class City
  attr_reader :id, :name, :x, :y, :links

  def initialize(id:, name:, x:, y:)
    @id = id
    @name = name
    @x = x.to_i
    @y = y.to_i
  end

  def to_s
    "#{name}"
  end

  def take_links(links)
    @links = links.select { |link| [link.city_a, link.city_b].include? self }
    self
  end

  def neighbours_connected_by(player)
    @links.select { |link| link.owner == player }
      .map { |link| link.other(self) }
  end
end
