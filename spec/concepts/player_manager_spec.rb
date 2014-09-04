require 'rails_helper'

describe PlayerManager do
  let (:player_1) { double(:player_1) }
  let (:player_2) { double(:player_2) }
  let (:states) { [player_1, player_2] }
  let (:manager) { PlayerManager.new states }

  it 'has a current_player' do
    expect(manager.current_player).to eq player_1
  end

  describe 'advance_current_player' do
    it 'can advance the current player' do
      manager.advance_current_player

      expect(manager.current_player).to eq player_2
    end

    it 'loops back to the first player after the last' do
      until manager.current_player == states.last
        manager.advance_current_player
      end

      manager.advance_current_player

      expect(manager.current_player).to eq player_1
    end
  end

  it 'has a size' do
    expect(manager.size).to eq states.size
  end
end
