class GamesController < ApplicationController
  before_action :authenticate_user!

  def show
    @game = Game.find_by_id params[:id]
    @users = @game.users
    @state = @game.state
    if @game.users.include? current_user
      player_id = current_user.players.find_by(game: @game).id
      @player = @game.state.players.find { |p_state| p_state.id == player_id }
    end
  end

  def action_count
    render text: Game.find(params[:id]).turns.flat_map(&:modifiers).size
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
