class ChangeCostToBeIntegerInMenus < ActiveRecord::Migration[7.0]
  def change
    change_column :menus, :menu_cost, :integer
  end
end
