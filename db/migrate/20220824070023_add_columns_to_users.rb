class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :mobile_no, :bigint
    add_column :users, :password, :string
    add_column :users, :address, :string
  end
end
