class Maybe
  def self.wrap(value)
    value.nil? ? new : value
  end

  def method_missing(method, *args)
    self
  end

  def nil?
    true
  end

  def to_s
    nil.to_s
  end
end
