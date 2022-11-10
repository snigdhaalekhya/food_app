class RemoveCountFromOwners < ActiveRecord::Migration[7.0]
  def change
    remove_column :owners, :sign_in_count, :integer
  end
end
