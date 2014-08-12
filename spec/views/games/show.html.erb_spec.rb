require 'rails_helper'

RSpec.describe "games/show.html.erb", :type => :view do
  let(:user) { create :user }

  before do
    assign :users, [user]
    render
  end

  it 'displays a list of users in the game' do
    expect(rendered).to include user.username
  end
end
