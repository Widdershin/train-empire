require 'rails_helper'

describe GameComputerService do
  let(:game_computer) { GameComputerService.new game_state, actions }
  let(:action) { instance_double('Actions::DrawRouteCards', process: game_state, end_of_turn?: true) }
  let(:actions) { [action, action] }
  let(:game_state) { instance_double('GameState', current_player: current_player).as_null_object}
  let(:current_player) { double(:player_state) }


end
