class AddSeedToGame < ActiveRecord::Migration
  def change
    add_column :games, :seed, :string
  end
end
