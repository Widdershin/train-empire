class User < ActiveRecord::Base
  has_many :user_games
  has_many :games, through: :user_games, source: :game

  def host_game
    games.create
  end

  def join_game(game)
    games << game
    save!
  end
end
