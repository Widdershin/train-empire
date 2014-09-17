class ActionsController < ApplicationController
  def create
    game = Game.find params[:id]

    player = game.players.find_by(user_id: current_user.id)

    unless player.id == game.state.current_player.id
      flash[:error] = 'Wait your turn.'
      return redirect_to game
    end

    extra_params = {action: params[:action_type]}

    action = player.actions.new(
      params_for(params[:action_type]).merge(extra_params)
    )

    unless player.can_perform? action
      flash[:error] = "Action can't be performed"
      return redirect_to game
    end

    if action.to_modifier.valid? game.state.current_player, game.state
      action.save!
    else
      flash[:error] = 'Invalid card'
    end

    redirect_to game
  end

  private

  def params_for(action)
    case action
    when 'draw_train_card'
      params.permit(:card_index)
    end
  end
end
