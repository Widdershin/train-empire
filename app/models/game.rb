class Game < ActiveRecord::Base
  # TODO - why was source here in the first place
  has_many :players, dependent: :destroy
  has_many :actions, through: :players, source: :actions
  has_many :users, through: :players, dependent: :destroy

  before_validation :set_seed, on: :create

  validates :seed, presence: true

  MAX_SEED = 100000000

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
    self.seed ||= rand(MAX_SEED)
  end
end
