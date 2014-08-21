require 'rails_helper'

RSpec.describe PlayerState, :type => :model do
  let (:test_name) { 'baz' }
  let (:player) { double(:player, name: test_name) }
  let (:player_state) { PlayerState.new test_name }

  before do
  end

  describe 'creation' do
    it 'takes a name' do
      expect { PlayerState.new test_name }.to_not raise_error
    end

    it 'has a name' do
      expect(player_state.name).to eq test_name
    end

    it 'has an empty hand' do
      expect(player_state.hand).to eq []
    end

    it 'has a train count that starts at 45' do
      expect(player_state.trains).to eq INITIAL_TRAIN_COUNT
    end

    it 'has an empty list of routes' do
      expect(player_state.routes).to eq []
    end
  end

  describe 'from_name' do
    it 'can be created from a player' do
      state_from_player = PlayerState.from_player player
      expect(state_from_player.name).to eq player.name
    end
  end

  describe 'add_to_hand' do
    it 'adds the card to the hand' do
      card = double :card

      player_state.add_to_hand card

      expect(player_state.hand).to include card
    end
  end
end
