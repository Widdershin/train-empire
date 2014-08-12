class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find_by_id params[:id]
    @users = @game.users
  end

  def new
  end

  def index
    @active_games = current_user.games
    @joinable_games = Game.all - @active_games
  end

  def create
    new_game = current_user.host_game

    redirect_to new_game
  end
end
