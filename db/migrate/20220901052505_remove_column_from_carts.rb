class RemoveColumnFromCarts < ActiveRecord::Migration[7.0]
  def change
    remove_column :carts, :order_id
  end
end
