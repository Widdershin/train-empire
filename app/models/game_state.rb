class GameState < ActiveRecord::Base
  belongs_to :game

  has_many :players
  has_one :current_turn_player, class: Player

  def add_player(player)
    players << player
  end
end
