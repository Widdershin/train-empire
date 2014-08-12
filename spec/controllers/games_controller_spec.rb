require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

  let (:user) { create :user }
  before { sign_in user }

  describe "GET show" do
    it "returns http success" do
      get :show, id: 1
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
    it "creates a game" do
      post :create

      expect(user.games.first).to be_a Game
    end
  end

end
