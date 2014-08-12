class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def new
  end

  def index
    @active_games = current_user.games
  end

  def create
    new_game = current_user.host_game

    redirect_to new_game
  end
end
