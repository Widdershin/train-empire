require 'rails_helper'

RSpec.describe GameState, :type => :model do
  it { should belong_to :game }
  it { should have_one :current_turn_player }
  it { should have_many :players }
end
