class AddRouteCardsToKeepToAction < ActiveRecord::Migration
  def change
    add_column :actions, :route_cards_to_keep, :string
  end
end
