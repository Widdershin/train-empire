require 'rails_helper'

RSpec.describe GamesController, :type => :controller do

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
    it ""
  end

end
