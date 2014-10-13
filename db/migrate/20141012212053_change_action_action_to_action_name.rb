class ChangeActionActionToActionName < ActiveRecord::Migration
  def change
    rename_column :actions, :action, :name
  end
end
