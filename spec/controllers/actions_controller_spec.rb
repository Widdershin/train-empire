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
      expect(request.flash[:error]).to be_nil
    end

    it "should fail if it's not my turn" do
      user = create(:user)
      second_user = create(:user)

      game.users += [user, second_user]
      game.save!

      sign_in second_user

      card_index = 1
      post :draw_train_card, id: game.id, card_index: card_index

      expect(request.flash[:error]).to_not be_nil
    end

    it "should fail if the action is invalid" do
      user = create(:user)
      sign_in user
      game.users << user
      game.save

      card_index = 7
      post :draw_train_card, id: game.id, card_index: card_index

      expect(request.flash[:error]).to include 'Invalid card'
    end
  end

end
