class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :actions, dependent: :destroy

  # TODO - before validate
  before_create :set_color

  def name
    user.username
  end

  def can_perform?(action)
    options.include? action.to_modifier.class
  end

  # TODO - maybe move to game
  def options
    # TODO - game.last_turn
    turn = game.turns.last

    if turn.nil? || turn.complete?
      turn = Turn.new
    end

    turn.options
  end

  private

  def set_color
    self.color = SecureRandom.hex(3)
  end
end
