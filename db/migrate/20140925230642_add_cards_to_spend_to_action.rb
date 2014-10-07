class AddCardsToSpendToAction < ActiveRecord::Migration
  def change
    add_column :actions, :cards_to_spend, :string
  end
end
