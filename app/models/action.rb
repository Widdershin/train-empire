class Action < ActiveRecord::Base
  belongs_to :player
  serialize :route_cards_to_keep, Array

  scope :by_creation, -> { order :id }

  validates :action, presence: true

  def self.as_modifiers
    by_creation.map(&:to_modifier)
  end

  def modifier_class
    "StateModifiers::#{action.camelize}".constantize
  end

  def to_modifier
    modifier_class.from_action(self)
  end
end
