module PlayerStateHelper
  def set_hand(colors)
    colors.each do |color|
      player_state.add_to_hand(TrainCard.new(color))
    end
  end
end

