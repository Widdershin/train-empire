require 'rails_helper'

describe GameSerializerService do
  let(:serializer) { GameSerializerService.new }

  describe 'serialize' do
    it 'returns a yaml string of the game' do
      game = Game.new

      expect(serializer.serialize(game)).to be_a String
    end
  end

  describe 'deserialize' do
    it 'can turn a yaml string into a game' do
      game = Game.new(seed: 1)

      expect(serializer.deserialize(serializer.serialize(game))).to be_a Game
    end

    it 'can handle relations' do
      game = Game.create
      old_seed = game.seed

      3.times {game.users << create(:user)}
      player = game.players.first

      player.actions.create!(
        name: 'keep_route_cards',
        route_cards_to_keep: [0, 1],
      )

      game.players.last.actions.create!(
        name: 'keep_route_cards',
        route_cards_to_keep: [1, 0],
      )

      player.actions.create!(
        name: 'draw_train_card',
        card_index: 0
      )

      old_actions = game.actions.to_a

      serialized_game = serializer.serialize(game)

      game.destroy!
      User.destroy_all
      Player.destroy_all
      Action.destroy_all

      remade_game  = serializer.deserialize(serialized_game)

      expect(remade_game.users.count).to eq 3
      expect(remade_game.players.count).to eq 3
      expect(remade_game.actions.count).to eq old_actions.count
      expect(remade_game.actions).to eq old_actions
      expect(remade_game.seed).to eq old_seed
    end
  end
end
