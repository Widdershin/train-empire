class Action < ActiveRecord::Base
  belongs_to :player

  scope :by_creation, -> { order :id }

  validates :action, presence: true

  def self.defrost_all
    by_creation.map(&:defrost)
  end

  def defrost
    case action
    when 'draw_train_card'
      Actions::DrawTrainCard.new(card_index)
    when 'draw_route_cards'
      Actions::DrawRouteCards.new
    end
  end
end
