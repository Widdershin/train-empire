require 'rails_helper'
require_relative 'shared_state_modifier_spec'

describe StateModifiers::KeepRouteCards do
  it_should_behave_like 'a state modifier'

  let (:cards_to_keep) { [0, 2, 3] }
  let (:modifier) { StateModifiers::KeepRouteCards.new(player_id, cards_to_keep)}
  let (:player_id) { 1 }

  it 'has a list of card indexes to keep' do
    expect(modifier.cards_to_keep).to eq cards_to_keep
  end

  describe 'process' do
    it 'adds the cards_to_keep to the players routes' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make
      current_player = double(:player_state)
      allow(game_state).to receive(:current_player).and_return(current_player)

      returned_cards = [:card, :card, :card]

      expect(current_player)
        .to receive(:keep_route_cards)
        .with(cards_to_keep)
        .and_return(returned_cards)

      expect(game_state.route_deck)
        .to receive(:add_to_bottom)
        .with(:card)
        .exactly(3).times

      modifier.process current_player, game_state
    end
  end
end
