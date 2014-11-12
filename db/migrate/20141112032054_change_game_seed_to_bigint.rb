class ChangeGameSeedToBigint < ActiveRecord::Migration
  def change
    change_column :games, :seed, :bigint
  end
end
