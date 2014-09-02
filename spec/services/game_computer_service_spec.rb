require 'rails_helper'

describe GameComputerService do
  let(:game_computer) { GameComputerService.new game_state, actions }
  let(:action) { double(:action, process: game_state) }
  let(:actions) { [action, action] }
  let(:game_state) { double(:game_state, current_player: current_player) }
  let(:current_player) { double(:player_state) }

  it 'takes a gamestate and a collection of actions' do
    expect { game_computer }
      .to_not raise_error
  end

  describe 'process' do
    it 'iterates over the actions, applying them to the gamestate' do
      actions.each do |action|
        # TODO - this should probably be a separate test or method
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
