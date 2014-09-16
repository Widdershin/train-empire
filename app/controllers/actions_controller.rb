class ActionsController < ApplicationController
  def draw_train_card
    game = Game.find params[:id]

    player = game.players.find_by(user_id: current_user.id)

    unless player.id == game.state.current_player.id
      flash[:error] = 'Wait your turn.'
      return redirect_to game
    end

    action = player.actions.new(
      action: 'draw_train_card',
      card_index: params[:card_index]
    )

    if action.to_modifier.valid? game.state.current_player, game.state
      action.save
    else
      flash[:error] = 'Invalid card'
    end

    redirect_to game
  end
end
