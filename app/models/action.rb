class Action < ActiveRecord::Base
  belongs_to :player
  serialize :route_cards_to_keep, Array

  scope :by_creation, -> { order :id }

  validates :action, presence: true

  def self.defrost_all
    by_creation.map(&:defrost)
  end

  def defrosted_class
    "Actions::#{action.camelize}".constantize
  end

  def defrost
    case action
    when 'draw_train_card'
      Actions::DrawTrainCard.new card_index
    when 'draw_route_cards'
      Actions::DrawRouteCards.new
    when 'keep_route_cards'
      Actions::KeepRouteCards.new route_cards_to_keep
    when 'claim_route'
      Actions::ClaimRoute.new route_id
    end
  end
end
