class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.bigint :restaurant_id
      t.string :menu_name
      t.string :menu_description
      t.bigint :menu_cost

      t.timestamps
    end
  end
end
