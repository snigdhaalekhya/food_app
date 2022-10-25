class RemoveCountFromWorkers < ActiveRecord::Migration[7.0]
  def change
    remove_column :workers, :sign_in_count, :integer
  end
end
