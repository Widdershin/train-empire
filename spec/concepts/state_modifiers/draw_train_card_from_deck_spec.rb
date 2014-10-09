require 'rails_helper'
require_relative 'shared_state_modifier_specs'

describe StateModifiers::DrawTrainCardFromDeck do
  it_should_behave_like "a state modifier"

  let(:modifier) { StateModifiers::DrawTrainCardFromDeck.new(player_id) }
  let(:player_id) { 1 }

  describe '#process' do
    it 'takes a random card from the deck and adds it to the players hand' do
    game = double(:game, players: [], seed: 1)
    game_state = GameStateCreationService.new(game).make
    current_player = PlayerState.new('foo', 1)
    allow(game_state).to receive(:current_player).and_return(current_player)

    expect(game_state.train_deck)
      .to receive(:draw_random)

    expect(current_player)
      .to receive(:add_to_hand)

    modifier.process current_player, game_state
    end
  end
end
