require 'rails_helper'

RSpec.describe "games/show.html.erb", :type => :view do
  let(:player) { double(:player, color: '#fff', potential_routes: [route], name: 'test', id: 1, hand: []) }
  let(:players) { [player] }
  let(:route) { RouteCard.new(origin: 'foo', destination: 'bar', points: 5) }

  let(:train_deck) { double(:train_deck) }
  let(:route_deck) { double(:route_deck) }
  let(:links) { [] }
  let(:cities) { [] }
  let(:game) { Game.create }

  let(:state) do
    GameState.new(players, train_deck, route_deck, links, cities)
  end

  before do
    allow(view)
      .to receive(:current_user)
      .and_return(double(:user, in_game?: true))
    assign(:state, state)
    assign(:player, player)
    assign(:game, game)
  end

  it 'renders potential_routes' do
    render

    expect(rendered).to include route.origin
    expect(rendered).to include route.destination
    expect(rendered).to include route.points
  end
end
