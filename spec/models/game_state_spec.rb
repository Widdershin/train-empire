require 'rails_helper'

RSpec.describe GameState, :type => :model do
  it { should belong_to :game }
  it { should have_one :current_turn_player }
  it { should have_many :players }

  let (:game_state) { create :game_state }
  let (:player) { create :player }

  it 'adds a player' do
    game_state.add_player player

    expect(game_state.players).to include player
  end

  describe 'current_turn_player' do
    it 'can be set' do
      game_state.set_current_player player

      expect(game_state.current_turn_player).to eq player
    end
  end
end
