class AddRouteIdToAction < ActiveRecord::Migration
  def change
    add_column :actions, :route_id, :integer
  end
end
