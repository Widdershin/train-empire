require 'rails_helper'
require_relative 'shared_state_modifier_spec'

describe StateModifiers::ClaimLink do
  it_should_behave_like 'a state modifier'

  let(:modifier) { StateModifiers::ClaimLink.new(player_id, link_id) }
  let(:player_id) { 1 }
  let(:link_id) { 2 }

  describe 'process' do
    it 'claims the link with the given id' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make

      player = double(:player_state)

      expect(player)
        .to receive(:claim)
        .with(kind_of(Link))

      modifier.process(player, game_state)
    end
  end
end
