require 'rails_helper'

RSpec.describe Player, :type => :model do
  it { should belong_to :user }
  it { should belong_to :game_state }
end
