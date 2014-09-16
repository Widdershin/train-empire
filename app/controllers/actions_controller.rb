class ActionsController < ApplicationController
  def draw_train_card
    game = Game.find params[:id]

    player = game.players.find_by(user_id: current_user.id)

    action = player.actions.create!(
      action: 'draw_train_card',
      card_index: params[:card_index]
    )

    redirect_to game
  end
end
