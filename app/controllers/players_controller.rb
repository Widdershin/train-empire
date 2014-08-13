class PlayersController < ApplicationController
  before_filter :find_game

  def create
    current_user.join_game @game

    redirect_to @game
  end

  private

  def find_game
    @game = Game.find params[:game_id]
  end
end
