class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def new
  end

  def index
  end

  def create
    current_user.host_game
  end
end
