require 'rails_helper'

RSpec.describe GameState do
  let (:player_state) { PlayerState.new 'foo', 1 }
  let (:player_state2) { PlayerState.new 'bar', 2 }

  let (:player_states) { [player_state, player_state2] }
  let (:train_deck) { CardDeck.new([:card] * 105, random: Random.new(1)) }
  let (:route_deck) { double :route_deck, draw: :route_card }
  let (:link) { double :link, id: 1, owner: nil }
  let (:link2) { double :link2, id: 2, owner: nil }
  let (:links) { [link, link2] }
  let (:cities) { double :cities }

  let (:game_state) do
    GameState.new player_states, train_deck, route_deck, links, cities
  end

  it 'has a nice string representation' do
    expect(game_state.to_s)
      .to eq 'GameState - 2 players, 105 cards in deck, 0 cards available'
  end

  it 'has a route_deck accessible' do
    expect(game_state.route_deck)
      .to eq route_deck
  end

  describe 'links' do
    describe 'claim_link' do
      it 'claims the link for the player' do
        player = double :player_state

        expect(link)
          .to receive(:set_owner)
          .with(player)

        game_state.claim_link(link.id, player)
      end
    end
  end

  describe '#any_player_train_count_below_threshold?' do
    subject { game_state.any_player_train_count_below_threshold? }

    it {should eq false}

    context 'when a player has less than three trains remaining' do
      before do
        allow(player_state).to receive(:trains) { 2 }
      end

      it {should eq true}
    end
  end

  describe '#game_over?' do
    subject { game_state.game_over? }

    it {should eq false}

    context 'no players' do
      before do
        allow(game_state).to receive(:players) { PlayerManager.new [] }
      end

      it {should eq false}
    end

    context 'when all players have played their final turn' do
      before do
        allow(player_state).to receive(:played_final_turn?).and_return(true)
        allow(player_state2).to receive(:played_final_turn?).and_return(true)
      end

      it {should eq true}
    end
  end

  describe 'refill_train_deck_from_discards!' do
    it 'replaces the train deck with the shuffled discards' do
      cards = [:red, :blue, :green]

      game_state.discarded_train_cards += cards
      until game_state.train_deck.empty?
        game_state.train_deck.draw
      end

      expect(game_state.train_deck.count).to eq 0

      game_state.refill_train_deck_from_discards!

      expect(game_state.train_deck.count).to eq cards.size
    end
  end
end
