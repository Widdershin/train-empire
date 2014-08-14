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
  end
end