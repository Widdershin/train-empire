class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :user
      t.belongs_to :game_state
      t.timestamps
    end
  end
end
