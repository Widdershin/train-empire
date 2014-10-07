require 'rails_helper'

RSpec.describe ActionsController, :type => :controller do
  describe 'POST create' do
    let(:card_index) { 2 }
    let(:second_user) { create(:user) }
    let(:user) { create(:user) }
    let(:game) { Game.create }

    before do
      game.users << user
      game.users << second_user
      game.save!

      sign_in user

      post :create, {
        action_type: 'keep_initial_route_cards',
        id: game.id,
        route_cards_to_keep: [0, 1],
      }

      sign_out user
      sign_in second_user

      post :create, {
        action_type: 'keep_initial_route_cards',
        id: game.id,
        route_cards_to_keep: [0, 1],
      }

      sign_out second_user
    end

    context 'successful' do

      after do
        raise "Errors: #{request.flash[:error]}" if request.flash[:error]
        expect(response).to redirect_to game
      end

      before do

      end

      it 'creates draw_wild_card actions' do
        sign_in user

        game.update_attributes!(seed: 1)

        train_cards = game.state.available_train_cards
        expect(train_cards.map(&:color)).to include :wild

        expect do
          post :create, {
            action_type: 'draw_wild_card',
            id: game.id,
            card_index: train_cards.find_index { |c| c.color == :wild}
          }
        end.to change { Action.count }.by(1)

      end

      it 'creates draw_route_card actions' do
        sign_in user

        expect { post :create, action_type: 'draw_route_cards', id: game.id }
          .to change { Action.count }.by(1)
      end

      it 'creates keep_route_cards actions' do
        sign_in user

        post :create, action_type: 'draw_route_cards', id: game.id

        expect { post :create, action_type: 'keep_route_cards', id: game.id, route_cards_to_keep: [1, 2]  }
          .to change { Action.count }.by(1)

      end

      it 'creates a draw_train_card action' do
        sign_in user

        game.update_attributes!(seed: 1)

        post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index

        new_modifier = game.turns.last.modifiers.last
        expect(new_modifier).to be_a StateModifiers::DrawTrainCard
        expect(new_modifier.card_index).to eq card_index
      end

    end

    it "fails if it's not my turn" do
      game.users << second_user
      game.save!

      sign_in second_user

      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index

      expect(request.flash[:error]).to_not be_nil
    end

    it "fails if the action is invalid" do
      sign_in user

      card_index = 7
      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index
      expect(request.flash[:error]).to include 'Invalid Action'
    end

    it "fails if the action is against the rules" do
      sign_in user

      player = game.players.first

      player.actions.create!(action: 'draw_route_cards')

      post :create, action_type: 'draw_train_card', id: game.id, card_index: card_index
      expect(request.flash[:error]).to include "Action can't be performed"
    end

  end
end
