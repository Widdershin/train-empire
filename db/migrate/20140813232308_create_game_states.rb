class CreateGameStates < ActiveRecord::Migration
  def change
    create_table :game_states do |t|

      t.belongs_to :game

      t.timestamps
    end
  end
end
