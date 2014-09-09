require 'rails_helper'

describe Actions::DrawTrainCard do
  let(:card_index) { 2 }
  let(:action) { Actions::DrawTrainCard.new card_index }
  let(:player) { double :player_state }

  describe 'process' do
    it 'moves the card from the available_train_cards to the players hand' do
      game = double(:game, players: [], seed: 1)
      game_state = GameStateCreationService.new(game).make
      allow(game_state).to receive(:current_player).and_return(player)

      fake_card = double (:card)

      expect(game_state.available_train_cards)
        .to receive(:take)
        .with(card_index)
        .and_return(fake_card)

      expect(player)
        .to receive(:add_to_hand)
        .with(fake_card)

      action.process player, game_state
    end
  end
end
