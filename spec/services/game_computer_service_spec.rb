require 'rails_helper'

RSpec.describe GameComputerService do
  describe "computing game state" do
    it 'applies each action to the game state' do
      game_state = double :game_state
      action = double :action, apply: game_state

      game_computer = GameComputerService.new([action])
      allow(game_computer).to receive(:new_game_state).and_return game_state

      expect(action).to receive(:apply).with(game_state)

      game_computer.compute
    end
  end


end