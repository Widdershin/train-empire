require 'rails_helper'
require_relative 'shared_state_modifier_specs'

describe StateModifiers::DrawWildCard do
  let (:modifier) { StateModifiers::DrawWildCard.new(player_id, card_index) }
  let (:player_id) { 1 }
  let (:card_index) { 3 }
  let(:player) { PlayerState.new(player_id, 'test') }

  it_should_behave_like 'a state modifier'

  describe '#process' do
    it 'moves the wildcard from the available cards to the players hand' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make
      allow(game_state).to receive(:current_player).and_return(player)

      fake_card = double(:card, color: :fake, cost: 1)

      expect(game_state.available_train_cards)
        .to receive(:take)
        .with(card_index)
        .and_return(fake_card)

      expect(player)
        .to receive(:add_to_hand)
        .with(fake_card)

      modifier.process player, game_state
    end
  end
end
