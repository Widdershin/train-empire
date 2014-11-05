class Turn
  attr_reader :modifiers

  PATTERNS = [
    [StateModifiers::ClaimLink],
    [StateModifiers::DrawWildCard],
    [StateModifiers::DrawTrainCardFromDeck, StateModifiers::DrawTrainCardFromDeck],
    [StateModifiers::DrawTrainCardFromDeck, StateModifiers::DrawTrainCard],
    [StateModifiers::DrawTrainCard, StateModifiers::DrawTrainCardFromDeck],
    [StateModifiers::DrawTrainCard, StateModifiers::DrawTrainCard],
    [StateModifiers::DrawRouteCards, StateModifiers::KeepRouteCards],
    [StateModifiers::KeepInitialRouteCards],
  ]

  def initialize(state_modifiers = [])
    @modifiers = state_modifiers
    @current = false
  end

  def process(game_state)
    modifiers.each do |modifier|
      apply_modifier(game_state, modifier)
      game_state.after_action
    end

    game_state
  end

  def valid?
    valid_modifier_pattern? || (current? && start_of_pattern?)
  end

  def current?
    @current
  end

  # TODO - vanquish (unneeded)
  def complete?
    valid_modifier_pattern?
  end

  def options
    matched_patterns.map { |pattern| pattern[modifiers.size] }.uniq
  end

  def mark_as_current
    @current = true
  end

  private

  def matched_patterns
    PATTERNS.select { |pattern| pattern.first(modifiers.size) == modifier_classes }
  end

  # TODO - reconsider name
  def valid_modifier_pattern?
    PATTERNS.include? modifier_classes
  end

  # TODO - more descriptive name
  def start_of_pattern?
    matched_patterns.any?
  end

  def modifier_classes
    modifiers.map(&:class)
  end

  def apply_modifier(game_state, modifier)
    modifier.process(game_state.current_player, game_state)
  end
end
