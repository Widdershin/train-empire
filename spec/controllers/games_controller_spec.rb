require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  let (:user) { create :user }
  before { sign_in user }

  describe "GET show" do
    it "returns http success" do
      game = Game.create

      get :show, id: game.id
      expect(response).to be_success
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end
  end

  describe "POST create" do
    before { post :create }

    it "creates a game" do
      expect(user.games.first).to be_a Game
    end

    it { should redirect_to game_path(user.games.first) }
  end

end
