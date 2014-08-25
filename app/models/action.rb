class Action < ActiveRecord::Base
  belongs_to :player

  validates :action, presence: true

  def defrost(game_state)
    Actions::DrawTrainCard.new(game_state.player(player.id), card_index)
  end
end
