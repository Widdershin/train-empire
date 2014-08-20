class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game

  def name
    user.username
  end
end
