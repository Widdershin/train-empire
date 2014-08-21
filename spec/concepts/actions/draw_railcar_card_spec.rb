require 'rails_helper'

describe Actions::DrawRailcarCard do
  let(:card_index) { 2 }
  let(:game_state) { double :game_state }
  let(:player) { double :player }
  let(:action) { Actions::DrawRailcarCard.new player, game_state, card_index }

  describe 'process' do
    let(:fake_card) { double :card }

    before do
      allow(game_state)
        .to receive(:take_available_train_card)
        .and_return(fake_card)

      allow(player)
        .to receive(:add_to_hand)
        .and_return(fake_card)
    end

    it 'takes the card from the available_train_cards' do
      expect(game_state)
        .to receive(:take_available_train_card)
        .with(card_index)
    end

    it "adds the card to the player's hand" do
      expect(player)
        .to receive(:add_to_hand)
        .with(fake_card)
    end
    after { action.process }
  end
end
