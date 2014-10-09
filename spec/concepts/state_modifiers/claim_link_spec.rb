require 'rails_helper'
require_relative 'shared_state_modifier_specs'

describe StateModifiers::ClaimLink do
  it_should_behave_like 'a state modifier'

  let(:modifier) do
    StateModifiers::ClaimLink.new(player_id, link_id, cards_to_spend)
  end

  let(:cards_to_spend) { [0, 1, 2] }
  let(:player_id) { 1 }
  let(:link_id) { 2 }

  describe 'process' do
    it 'claims the link with the given id' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make

      player = double(:player_state)

      expect(player)
        .to receive(:claim)
        .with(kind_of(Link), cards_to_spend)
        .and_return([:card])

      expect(game_state)
        .to receive(:discarded_train_cards=)

      modifier.process(player, game_state)
    end
  end
end
