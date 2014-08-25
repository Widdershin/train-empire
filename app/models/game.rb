class Game < ActiveRecord::Base
  has_many :players

  has_many :users, through: :players, source: :user

  validates :seed, presence: true

  before_validation :set_seed, on: :create

  def set_seed
    self.seed = Random.new_seed
  end

  def state
    initial_state = GameState.make self
    GameComputerService.new(initial_state, ordered_actions(initial_state)).process
  end

  def ordered_actions(game_state)
    players.flat_map(&:actions).sort_by(&:id).map { |action| action.defrost game_state }
  end
end
