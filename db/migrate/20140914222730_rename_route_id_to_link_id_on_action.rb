class RenameRouteIdToLinkIdOnAction < ActiveRecord::Migration
  def change
    rename_column :actions, :route_id, :link_id
  end
end
