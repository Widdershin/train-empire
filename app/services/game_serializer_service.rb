class GameSerializerService
  def serialize(game)
    game.to_json(include: {
      users: {only: [:id, :username, :email]},
      players: {include: :actions},
    })
  end

  # TODO - transactionize
  def deserialize(string)
    Game.transaction do
      game_data = JSON.parse(string).symbolize_keys
      game = Game.create!(seed: game_data[:seed])

      old_user_ids_to_new = {}
      game_data[:users].each do |user|
        old_id = user.delete("id")
        new_user = game.users.create!(user.merge({password: 'swordfish'}))
        old_user_ids_to_new[old_id] = new_user.id
      end

      game_data[:players].each do |player|
        actions = player.delete("actions")
        new_player = game.players.find_by(user_id: old_user_ids_to_new[player["user_id"]])

        actions.each do |action|
          new_player.actions.create!(action)
        end
      end

      game.save!
      game
    end
  end
end
