class ChangeId < ActiveRecord::Migration[7.0]
  def change
    rename_column :menus, :restaurant_id, :owner_id
  end
end
