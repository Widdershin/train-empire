class TrainCard
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def to_s
    "#{color.to_s.titlecase} Train Card"
  end
end