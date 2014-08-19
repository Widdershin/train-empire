class AddSeedToGame < ActiveRecord::Migration
  def change
    add_column :games, :seed, :integer
  end
end
