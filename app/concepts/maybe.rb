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
end
