class Game < ActiveRecord::Base
  has_many :players, dependent: :destroy
  has_many :actions, through: :players, source: :actions
  has_many :users, through: :players, source: :user, dependent: :destroy

  before_validation :set_seed, on: :create

  validates :seed, presence: true


  def state
    GameComputerService.new(initial_state, turns).process
  end

  def initial_state
    GameStateCreationService.new(self).make
  end

  def turns
    actions.to_turns
  end

  def initial_round?
    actions.count < players.count
  end

  private

  def set_seed
    self.seed ||= Random.new_seed
  end
end
