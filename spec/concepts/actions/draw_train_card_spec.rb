require 'rails_helper'

describe Actions::DrawTrainCard do
  let(:card_index) { 2 }
  let(:game_state) { double :game_state }
  let(:player_id) { 3 }
  let(:action) { Actions::DrawTrainCard.new player_id, card_index }
  let(:player) { double :player_state }

  describe 'process' do
    let(:fake_card) { double :card }

    before do
      allow(game_state)
        .to receive(:take_available_train_card)
        .and_return(fake_card)

      allow(game_state)
        .to receive(:player)
        .with(player_id)
        .and_return(player)

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

    it "should return the modified game_state" do
      expect(action.process game_state)
        .to eq game_state
    end

    after { action.process game_state }
  end
end
