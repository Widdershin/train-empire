class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :actions

  def name
    user.username
  end
end
