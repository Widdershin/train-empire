module PlayersHelper
  def playing_game? game
    current_user.in_game? game
  end
end
