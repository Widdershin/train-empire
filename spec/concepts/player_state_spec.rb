require 'rails_helper'
require_relative 'player_state_helper'

RSpec.describe PlayerState, :type => :model do
  include PlayerStateHelper
  let (:test_name) { 'baz' }
  let (:test_id) { 1 }
  let (:player) { double(:player, name: test_name, id: test_id, color: 'FFF') }
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
      card = double :card, color: :red

      player_state.add_to_hand card

      expect(player_state.hand).to include card
    end

    it 'sorts the hand by color' do
      card = double :card, color: :red

      player_state.add_to_hand card
      expect(player_state.hand).to eq player_state.hand.sort_by(&:color)
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

  describe 'claim' do
    let (:route) { double(:route, cost: 5, color: :blue, set_owner: nil) }

    let (:card) { TrainCard.new(:blue) }

    let (:cards_to_spend) { [*0..route.cost] }

    before do
      route.cost.times do
        player_state.add_to_hand card
      end
    end

    it 'claims a route' do
      expect(route).to receive(:set_owner).with(player_state)
      player_state.claim route, cards_to_spend
    end

    it 'subtracts the route cost from the trains' do
      expect{ player_state.claim(route, cards_to_spend) }
        .to change { player_state.trains }
        .by(-route.cost)
    end

    it 'spends the needed cards' do
      expect { player_state.claim(route, cards_to_spend) }
        .to change { player_state.hand.size }
        .by(-route.cost)
    end

    it 'claims grey routes with any card color' do
      gray_route = double(:route, cost: 1, color: :gray, set_owner: nil)

      expect { player_state.claim(gray_route, [0]) }
        .to change { player_state.hand.size }
        .by(-gray_route.cost)
    end
  end

  describe '#spend_cards' do
    it 'removes the cards with the indices from the players hand' do
      [:red, :green, :blue, :yellow].each do |color|
        player_state.add_to_hand(TrainCard.new(color))
      end

      player_state.spend_cards([0, 2])

      expect(player_state.hand.map(&:color)).to match_array [:green, :yellow]
    end
  end

  describe '#can_claim' do
    context 'cards of one color' do
      it 'returns true' do
        set_hand [:red, :red]

        link = double :link, color: :red, cost: 2

        expect(player_state.can_claim?(link, [0, 1])).to eq true
      end

      it 'must be the right color' do
        set_hand [:green, :green]

        link = double :link, color: :red, cost: 2

        expect(player_state.can_claim?(link, [0, 1])).to eq false
      end
    end

    context 'wild cards' do
      it 'uses wilcards happily' do
        set_hand [:wild, :red]

        link = double :link, color: :red, cost: 2

        expect(player_state.can_claim?(link, [0, 1])).to eq true
      end
    end

    context 'gray links' do
      it 'uses any color' do
        set_hand [:green, :green]

        link = double :link, color: :gray, cost: 2

        expect(player_state.can_claim?(link, [0, 1])).to eq true
      end

      it 'must use one color' do
        set_hand [:green, :red]

        link = double :link, color: :gray, cost: 2

        expect(player_state.can_claim?(link, [0, 1])).to eq false
      end
    end

    it 'must spend cards' do
      set_hand [:green, :green]

      link = double :link, color: :gray, cost: 2

      expect(player_state.can_claim?(link, [])).to eq false
    end
  end

end
