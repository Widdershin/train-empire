require 'rails_helper'

RSpec.describe GameState do
  let (:player_state) { double :player_state }
  let (:player_state2) { double :player_state2 }

  let (:player_states) { [player_state, player_state2] }
  let (:train_deck) { double :train_deck, count: 105 }
  let (:route_deck) { double :route_deck, draw: :route_card }
  let (:link) { double :link, id: 1, owner: nil }
  let (:link2) { double :link2, id: 2, owner: nil }
  let (:links) { [link, link2] }

  let (:game_state) do
    GameState.new player_states, train_deck, route_deck, links
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
end
