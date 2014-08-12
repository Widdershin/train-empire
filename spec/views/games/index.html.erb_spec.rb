require 'rails_helper'

RSpec.describe "games/index.html.erb", :type => :view do
  it "displays the games you are currently in" do
    game = Game.create
    assign :active_games, [game]

    render

    expect(rendered).to include "Game: #{game.id}"
  end
end
