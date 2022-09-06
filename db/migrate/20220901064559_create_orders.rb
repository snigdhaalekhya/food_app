class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.bigint :user_id
      t.string :menu
      t.string :status
      t.bigint :owner_id

      t.timestamps
    end
  end
end
