require 'rails_helper'

RSpec.describe PlayerState, :type => :model do
  let (:test_name) { 'baz' }
  let (:test_id) { 1 }
  let (:player) { double(:player, name: test_name, id: test_id) }
  let (:player_state) { PlayerState.new test_name, test_id }

  before do
  end

  describe 'creation' do
    it 'takes a name and an id' do
      expect { PlayerState.new test_name, test_id }.to_not raise_error
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

    it 'has an empty list of potential routes' do
      expect(player_state.potential_routes).to eq []
    end
  end

  describe 'creating from_player' do
    let(:state_from_player) { PlayerState.from_player player }

    it "has the player's name" do
      expect(state_from_player.name).to eq player.name
    end

    it "has the player's id" do
      expect(state_from_player.id).to eq player.id
    end
  end

  describe 'add_to_hand' do
    it 'adds the card to the hand' do
      card = double :card

      player_state.add_to_hand card

      expect(player_state.hand).to include card
    end
  end

  describe 'set_potential_route_cards' do
    it 'sets the potential_routes' do
      cards = [:card, :card, :card]

      player_state.set_potential_route_cards cards

      expect(player_state.potential_routes).to eq cards
    end
  end

  describe 'keep_route_cards' do
    let(:cards) { [:carda, :cardb, :cardc] }
    it 'keeps the route cards with the given index' do
      player_state.set_potential_route_cards cards

      player_state.keep_route_cards [1, 2]

      expect(player_state.routes).to eq [:cardb, :cardc]
    end

    it 'returns the unkept cards' do
      player_state.set_potential_route_cards cards

      expect(player_state.keep_route_cards([1, 2])).to eq [:carda]
    end

    it 'clears the potential_routes list' do
      player_state.set_potential_route_cards cards

      player_state.keep_route_cards [2]

      expect(player_state.potential_routes).to be_empty
    end
  end
end
