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
    modifiers.reduce(game_state) do |game_state, modifier|
      apply_modifier(game_state, modifier)
      game_state.after_action
      game_state
    end
  end

  def valid?
    valid_modifier_pattern? or (current? and start_of_pattern?)
  end

  def current?
    @current
  end

  def complete?
    valid_modifier_pattern?
  end

  def options
    matched_patterns.map { |pattern| pattern.at(modifiers.size) }.uniq
  end

  def mark_as_current
    @current = true
  end

  private

  def matched_patterns
    PATTERNS.select { |pattern| pattern.first(modifiers.size) == modifier_classes }
  end

  def valid_modifier_pattern?
    PATTERNS.include? modifier_classes
  end

  def start_of_pattern?
    matched_patterns.any?
  end

  def modifier_classes
    modifiers.map(&:class)
  end

  def apply_modifier(game_state, modifier)
    raise error_message(modifier) unless modifier.valid? game_state.current_player, game_state
    modifier.process(game_state.current_player, game_state)
  end

  def error_message(modifier)
    "Invalid Modifier: #{modifier.inspect}"
  end

end
