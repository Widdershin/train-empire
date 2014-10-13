class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :players
  has_many :games, through: :players

  validates :username, presence: true, uniqueness: true

  def host_game
    games.create
  end

  def join_game(game)
    return if in_game? game

    games << game
    save
    # TODO - save!?
  end

  def in_game?(game)
    # TODO - vanquish
    games.include? game
  end
end
