require 'rails_helper'

describe Actions::DrawTrainCard do
  let(:card_index) { 2 }
  let(:train_deck) { double :train_deck }
  let(:action) { Actions::DrawTrainCard.new card_index }
  let(:player) { double :player_state }

  describe 'process' do
    let(:fake_card) { double :card }

    before do
      allow(train_deck)
        .to receive(:take)
        .and_return(fake_card)

      allow(player)
        .to receive(:add_to_hand)
        .and_return(fake_card)
    end

    it 'takes the card from the available_train_cards' do
      expect(train_deck)
        .to receive(:take)
        .with(card_index)
    end

    it "adds the card to the player's hand" do
      expect(player)
        .to receive(:add_to_hand)
        .with(fake_card)
    end

    after { action.process player, train_deck }
  end
end
