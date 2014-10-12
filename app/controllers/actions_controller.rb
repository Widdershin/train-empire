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

    action_creation_service = ActionCreationService.new(
      player,
      params_for(params[:action_type]),
    )

    action_creation_service.on(:must_draw_route_cards) do
      flash[:error] = "You must draw route cards to start"
    end

    action_creation_service.on(:invalid_action) do |errors|
      flash[:error] = "Invalid Action - #{errors.join(', ')}"
    end

    action_creation_service.on(:wrong_action) do |options|
      flash[:error] = "Action can't be performed - You must do one of #{options.join(',')}"
    end

    action_creation_service.call

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
    end.merge({name: params[:action_type]})
  end
end
