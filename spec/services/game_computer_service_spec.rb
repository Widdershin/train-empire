require 'rails_helper'

describe GameComputerService do
  let(:game_computer) { GameComputerService.new game_state, actions }
  let(:action) { double(:action, process: game_state, end_of_turn?: true) }
  let(:actions) { [action, action] }
  let(:game_state) { instance_double('GameState', current_player: current_player) .as_null_object}
  let(:current_player) { double(:player_state) }

  describe 'process' do
    it 'iterates over the actions, applying them to the gamestate' do
      actions.each do |action|

        expect(game_state)
          .to receive(:replenish_available_cards)

        expect(action)
          .to receive(:process)
          .with(game_state, game_state.current_player)
      end

      game_computer.process
    end
  end
end
