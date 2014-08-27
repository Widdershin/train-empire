require 'rails_helper'

RSpec.describe GameState do

  it 'has a nice string representation' do
    game_state = GameState.new(
      [double(:player), double(:player)],
      double(:deck, count: 105)
    )

    expect(game_state.to_s)
      .to eq 'GameState - 2 players, 105 cards in deck, 0 cards available'
  end

  describe "#player" do
    it 'returns the player state for the player with the given id' do
      player = double :player, name: 'Tim', id: 5

      game_state = GameState.new([player], double(:deck))

      expect(game_state.player player.id).to eq player
    end
  end
end
