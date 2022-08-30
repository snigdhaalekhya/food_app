class ChangeUsersResToOwners < ActiveRecord::Migration[7.0]
  def change
    rename_table :users_res, :owners
  end
end
