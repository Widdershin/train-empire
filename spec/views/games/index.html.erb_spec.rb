require 'rails_helper'

RSpec.describe "games/index.html.erb", :type => :view do
  let (:game1) { Game.create }
  let (:game2) { Game.create }

  before do
    assign :active_games, [game1]
    assign :joinable_games, [game2]
    render
  end

  it "displays the games you are currently in" do
    expect(rendered).to include "Game: #{game1.id}"
  end

  it "displays the games you can join" do
    expect(rendered).to include "Game: #{game2.id}"
  end
end
