class Turn
  attr_reader :modifiers

  def initialize(state_modifiers)
    @modifiers = state_modifiers
  end

  def valid?
    valid_modifier_pattern?
  end

  private

  def valid_modifier_pattern?
    [
      [StateModifiers::ClaimLink],
      [StateModifiers::DrawTrainCard, StateModifiers::DrawTrainCard],
      [StateModifiers::DrawRouteCards, StateModifiers::KeepRouteCards],
    ].include?(modifiers.map(&:class))
  end
end
