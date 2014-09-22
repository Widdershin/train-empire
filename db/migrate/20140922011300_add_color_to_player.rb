class AddColorToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :color, :string
  end
end
