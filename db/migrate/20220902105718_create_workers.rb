class CreateWorkers < ActiveRecord::Migration[7.0]
  def change
    create_table :workers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address

      t.timestamps
    end
  end
end
