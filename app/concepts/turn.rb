class Turn
  attr_reader :modifiers

  def initialize(state_modifiers)
    @modifiers = state_modifiers
  end
end
