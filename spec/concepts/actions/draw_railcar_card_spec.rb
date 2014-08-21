require 'rails_helper'

describe Actions::DrawRailcarCard do
  let(:card_index) { 2 }
  let(:game_state) { double :game_state }
  let(:player) { double :player }
  let(:action) { Actions::DrawRailcarCard.new player, game_state, card_index }

  describe 'process' do
    it 'takes the card from the available_train_cards' do
      expect(game_state)
        .to receive(:take_available_train_card)
        .with(card_index)
    end

    after { action.process }
  end
end
