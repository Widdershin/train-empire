require 'rails_helper'

describe Actions::KeepRouteCards do
  let (:cards_to_keep) { [0, 2, 3] }
  let (:action) { Actions::KeepRouteCards.new cards_to_keep }

  it 'has a list of card indexes to keep' do
    expect(action.cards_to_keep).to eq cards_to_keep
  end

  describe 'process' do
    it 'adds the cards_to_keep to the players routes' do
      game_state = double(:game_state)
      current_player = double(:player_state)

      expect(current_player)
        .to receive(:keep_route_cards)
        .with(cards_to_keep)

      expect(current_player)
        .to receive(:return_unkept_route_cards)
        .and_return(:returned_cards)

      expect(game_state)
        .to receive(:return_route_cards)
        .with(:returned_cards)

      action.process game_state, current_player
    end
  end
end
