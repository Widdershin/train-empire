require 'rails_helper'

RSpec.describe "games/show.html.erb", :type => :view do
  let(:game) { Game.create }
  let(:user) { create :user }

  before do
    allow(view).to receive(:playing_game?).and_return false

    assign :users, [user]
    assign :game, game
    render
  end

  it 'displays a list of users in the game' do
    expect(rendered).to include user.username
  end
end
