class CreateUsersRes < ActiveRecord::Migration[7.0]
  def change
    create_table :users_res do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address

      t.timestamps
    end
  end
end
