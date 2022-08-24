class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.bigint :mobile_no
      t.string :password
      t.string :address
      t.timestamps
    end
  end
end