require 'rails_helper'

describe GameComputerService do
  let(:actions) { [action] }
  let(:game_state) { double :game_state }
  let(:action) { double :action }

  it 'takes a gamestate and a collection of actions' do
    expect { GameComputerService.new game_state, actions }
      .to_not raise_error
  end
end
