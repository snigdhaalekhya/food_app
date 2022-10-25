class RemoveCountFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :sign_in_count, :integer
  end
end
