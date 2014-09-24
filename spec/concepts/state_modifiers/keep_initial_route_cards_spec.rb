require 'rails_helper'
require_relative 'shared_state_modifier_specs'

describe StateModifiers::KeepInitialRouteCards do
  it_should_behave_like 'a state modifier'

  let (:cards_to_keep) { [0, 2, 3] }
  let (:modifier) { StateModifiers::KeepInitialRouteCards.new(player_id, cards_to_keep)}
  let (:player_id) { 1 }


  describe '#valid?' do
    let(:game_state) { double :game_state }
    let(:player) { PlayerState.new('foo', 1) }

    before do
      player.set_potential_route_cards([double(:card)] * 3)
    end

    it 'is true if the player has drawn two valid cards' do
      good_modifier = StateModifiers::KeepInitialRouteCards.new(1, [1, 2])
      expect(good_modifier.valid?(player, game_state)).to eq true
    end

    it 'is false if the player has kept less than two cards' do
      bad_modifier = StateModifiers::KeepInitialRouteCards.new(1, [1])
      expect(bad_modifier.valid?(player, game_state)).to eq false
    end
  end

end
