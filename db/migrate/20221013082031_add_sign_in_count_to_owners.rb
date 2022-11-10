class AddSignInCountToOwners < ActiveRecord::Migration[7.0]
  def change
    add_column :owners, :sign_in_count, :integer
  end
end
