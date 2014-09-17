class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :game
  has_many :actions

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
end
