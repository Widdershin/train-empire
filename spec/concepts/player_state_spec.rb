require 'rails_helper'

RSpec.describe PlayerState, :type => :model do
  let (:test_name) { 'baz' }
  let (:player) { double(:player, name: test_name) }
  let (:player_state) { PlayerState.new player }

  before do
  end

  describe 'creation' do
    it 'takes a player' do
      expect { PlayerState.new player }.to_not raise_error
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
end