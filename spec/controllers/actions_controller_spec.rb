require 'rails_helper'

RSpec.describe ActionsController, :type => :controller do
  describe 'POST draw_train_card' do
    let(:game) { Game.create }

    it 'should create a draw_train_card action' do
      user = create(:user)
      sign_in user
      game.users << user
      game.save

      card_index = 1
      post :draw_train_card, id: game.id, card_index: card_index

      new_modifier = game.turns.last.modifiers.last
      expect(new_modifier).to be_a StateModifiers::DrawTrainCard
      expect(new_modifier.card_index).to eq card_index
      expect(response).to redirect_to game
    end
  end

end
