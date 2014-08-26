require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { should belong_to :user }
  it { should belong_to :game }
  it { should have_many :actions }

  it 'has a name' do
    user = create :user
    player = user.players.create

    expect(player.name).to eq user.username
  end
end
