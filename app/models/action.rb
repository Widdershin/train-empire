class Action < ActiveRecord::Base
  belongs_to :player

  validates :action, presence: true

  def defrost
    Actions::DrawTrainCard.new(player.id, card_index)
  end
end
