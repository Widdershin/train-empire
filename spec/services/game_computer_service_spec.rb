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
        expect(action)
          .to receive(:process)
          .with(game_state)
      end

      game_computer.process
    end

    it 'returns the calculated gamestate' do
      final_game_state = double :final_game_state

      allow(actions.last)
        .to receive(:process)
        .and_return(final_game_state)

      expect(game_computer.process).to eq final_game_state
    end
  end
end
