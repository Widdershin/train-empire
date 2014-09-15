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
    GameComputerService.new(initial_state, turns).process
  end

  def initial_state
    GameStateCreationService.new(self).make
  end

  def state_modifiers
    actions.as_modifiers
  end

  def turns
    state_modifiers
      .chunk(&:player_id)
      .map { |_, chunk| Turn.new(chunk) }
  end
end
