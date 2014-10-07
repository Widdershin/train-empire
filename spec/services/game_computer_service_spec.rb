require 'rails_helper'

describe GameComputerService do

  describe 'process' do
    it 'calculates a GameState' do
      game = Game.create!

      game.users.create!(
        email: 'a@b.c',
        username: 'foo',
        password: 'like8chars',
      )

      player = game.players.first

      player.actions.create!(
        action: 'draw_route_cards'
      )

      computer = GameComputerService.new(
        game.initial_state,
        game.turns,
      )

      expect(computer.process).to be_a GameState
    end
  end

end
