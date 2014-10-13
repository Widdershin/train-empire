class ActionCreationService
  include Wisper::Publisher

  attr_reader :player, :args

  def initialize(player, args)
    @player = player
    @args = args
  end

  def game
    player.game
  end

  def call
    action = player.actions.new(@args)

    if game.initial_round? && args[:name] != 'keep_initial_route_cards'
      return broadcast(:must_draw_route_cards)
    end

    unless player.can_perform? action
      return broadcast(:wrong_action, player.options)
    end

    modifier = action.to_modifier

    if modifier.valid? game.state.current_player, game.state
      action.save!
      broadcast(:success, action)
    else
      broadcast(:invalid_action, modifier.errors)
    end
  end
end
