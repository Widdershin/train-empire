require 'rails_helper'

RSpec.describe PlayersController, :type => :controller do
  describe "POST create" do
    let (:user) { create :user }
    let (:game) { Game.create }

    before { sign_in user }

    it 'should join the user to the game' do
      post :create, game_id: game.id

      expect(game.users).to include user
    end

    it 'should redirect to the game page' do
      post :create, game_id: game.id

      expect(response).to redirect_to game_path game
    end
  end

end
