class TrainCard
  COST = 1
  WILD_COST = 2

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    "#{color.to_s.titlecase} Train Card"
  end

  def cost
    wild? ? WILD_COST : COST
  end

  def wild?
    color == :wild
  end

  def can_buy?(link_color)
    link_color == color or link_color == :gray
  end
end
