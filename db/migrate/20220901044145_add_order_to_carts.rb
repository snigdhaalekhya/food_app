class AddOrderToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :order_id, :bigint
  end
end
