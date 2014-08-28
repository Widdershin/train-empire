class Action < ActiveRecord::Base
  belongs_to :player

  scope :by_creation, -> { order :id }

  validates :action, presence: true

  def self.defrost_all
    by_creation.map(&:defrost)
  end

  def defrost
    Actions::DrawTrainCard.new(player.id, card_index)
  end
end
