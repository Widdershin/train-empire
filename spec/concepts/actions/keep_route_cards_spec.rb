require 'rails_helper'

describe Actions::KeepRouteCards do
  let (:cards_to_keep) { [0, 2, 3] }
  let (:action) { Actions::KeepRouteCards.new cards_to_keep }

  it 'has a list of card indexes to keep' do
    expect(action.cards_to_keep).to eq cards_to_keep
  end

  describe 'process' do
    it 'adds the cards_to_keep to the players routes' do
      route_deck = double(:route_deck)
      current_player = double(:player_state)

      expect(current_player)
        .to receive(:keep_route_cards)
        .with(cards_to_keep)

      returned_cards = [:card, :card, :card]

      expect(current_player)
        .to receive(:return_unkept_route_cards)
        .and_return(returned_cards)

      expect(route_deck)
        .to receive(:place_on_bottom)
        .with(:card)
        .exactly(3).times

      action.process current_player, route_deck
    end
  end
end
