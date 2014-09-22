class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :actions

  before_create :set_color

  def name
    user.username
  end

  def can_perform?(action)
    turn = game.turns.last

    if turn.nil? || turn.complete?
      turn = Turn.new []
    end

    turn.options.include? action.to_modifier.class
  end

  private

  def set_color
    self.color = SecureRandom.hex(3)
  end
end
