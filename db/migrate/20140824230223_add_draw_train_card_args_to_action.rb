class AddDrawTrainCardArgsToAction < ActiveRecord::Migration
  def change
    change_table :actions do |t|
      t.string :action
      t.integer :card_index
    end
  end
end
