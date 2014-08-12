class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_games
  has_many :games, through: :user_games, source: :game

  validates :username, presence: true, uniqueness: true

  def host_game
    games.create
  end

  def join_game(game)
    games << game
    save!
  end
end
