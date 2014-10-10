class ActionsController < ApplicationController
  protect_from_forgery except: :create

  # TODO - action creation service
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
      flash[:error] = "Action can't be performed. Must perform one of these: #{player.options.join(', ')}"
      return redirect_to game
    end

    if game.initial_round? && params[:action_type] != 'keep_initial_route_cards'
      flash[:error] = "You must draw route cards to start."
      return redirect_to game
    end

    modifier = action.to_modifier

    if modifier.valid? game.state.current_player, game.state
      action.save!
    else
      flash[:error] = "Invalid Action: #{modifier.errors.join ','}"
    end

    redirect_to game
  end

  private

  def params_for(action)
    case action
    when 'draw_train_card_from_deck'
      {}
    when 'draw_train_card'
      params.permit(:card_index)
    when 'draw_route_cards'
      {}
    when 'keep_route_cards'
      params.permit(route_cards_to_keep: [])
    when 'keep_initial_route_cards'
      params.permit(route_cards_to_keep: [])
    when 'claim_link'
      params.permit(:link_id, cards_to_spend: [])
    when 'draw_wild_card'
      params.permit(:card_index)
    end
  end
end
