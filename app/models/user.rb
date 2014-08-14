class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players
  has_many :games, through: :players, source: :game

  validates :username, presence: true, uniqueness: true

  def host_game
    games.create
  end

  def join_game(game)
    if !in_game? game
      games << game
      save
    end
  end

  def in_game?(game)
    games.include? game
  end
end
