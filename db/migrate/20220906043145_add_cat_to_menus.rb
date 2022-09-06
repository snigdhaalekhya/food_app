class AddCatToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :menu_category, :string
  end
end
