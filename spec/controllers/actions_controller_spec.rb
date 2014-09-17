require 'rails_helper'

RSpec.describe ActionsController, :type => :controller do
  describe 'POST create' do
    let(:card_index) { 1 }
    let(:second_user) { create(:user) }
    let(:user) { create(:user) }
    let(:game) { Game.create }

    before do
      game.users << user
      game.save!
    end

    it 'should create a draw_train_card action' do
      sign_in user

      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index

      new_modifier = game.turns.last.modifiers.last
      expect(new_modifier).to be_a StateModifiers::DrawTrainCard
      expect(new_modifier.card_index).to eq card_index
      expect(response).to redirect_to game
      expect(request.flash[:error]).to be_nil
    end

    it "should fail if it's not my turn" do
      game.users << second_user
      game.save!

      sign_in second_user

      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index

      expect(request.flash[:error]).to_not be_nil
    end

    it "should fail if the action is invalid" do
      sign_in user

      card_index = 7
      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index
      expect(request.flash[:error]).to include 'Invalid card'
    end

    it "should fail if the action is against the rules" do
      sign_in user

      player = game.players.first

      player.actions.create!(action: 'draw_route_cards')

      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index
      expect(request.flash[:error]).to include "Action can't be performed"
    end
  end
end
