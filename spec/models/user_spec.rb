require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_many :games }

  it 'hosts a new game' do
    user = User.create

    user.host_game

    expect(user.games).to_not be_empty
  end`
end
