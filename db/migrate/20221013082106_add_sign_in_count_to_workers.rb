class AddSignInCountToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :sign_in_count, :integer
  end
end
