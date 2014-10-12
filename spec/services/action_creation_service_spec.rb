require 'rails_helper'

describe ActionCreationService do
  describe '#call' do
    it 'creates an action' do
      game = Game.create!
      game.users << create(:user)
      game.users << create(:user)
      game.save!

      player = game.players.first

      args = {
        name: 'draw_route_cards'
      }

      creation_service = ActionCreationService.new(player, args)

      allow(game).to receive(:initial_round?).and_return(false)

      expect{ creation_service.call }.to broadcast(:success)

    end
  end

  # TODO - test edge cases
end
