class Action < ActiveRecord::Base
  belongs_to :player
  serialize :route_cards_to_keep, Array
  serialize :cards_to_spend, Array

  scope :by_creation, -> { order :id }

  validates :name, presence: true

  def self.as_modifiers
    by_creation.map(&:to_modifier)
  end

  def self.to_turns
    turns = as_modifiers
      .chunk(&:player_id)
      .map { |_, chunk| Turn.new(chunk) }

    turns.last.mark_as_current if turns.any?

    turns
  end

  def to_modifier
    modifier_class.from_action(self)
  end

  private

  def modifier_class
    "StateModifiers::#{name.camelize}".constantize
  end
end
