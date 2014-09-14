class Action < ActiveRecord::Base
  belongs_to :player
  serialize :route_cards_to_keep, Array

  scope :by_creation, -> { order :id }

  validates :action, presence: true

  def self.defrost_all
    by_creation.map(&:defrost)
  end

  def defrosted_class
    "StateModifiers::#{action.camelize}".constantize
  end

  def defrost
    defrosted_class.from_action(self)
  end
end
