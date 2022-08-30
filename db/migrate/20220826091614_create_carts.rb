class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.bigint :user_id
      t.bigint :menu_id
      t.bigint :count
      t.bigint :owner_id

      t.timestamps
    end
  end
end
