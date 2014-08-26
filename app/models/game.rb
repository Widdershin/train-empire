class Game < ActiveRecord::Base
  has_many :players
  has_many :actions, through: :players, source: :actions
  has_many :users, through: :players, source: :user

  validates :seed, presence: true

  before_validation :set_seed, on: :create

  def set_seed
    self.seed = Random.new_seed
  end

  def state
    GameComputerService.new(GameState.make(self), ordered_actions).process
  end

  def ordered_actions
    actions.order('id ASC')
  end
end
