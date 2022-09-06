class RemoveIdFromWorkers < ActiveRecord::Migration[7.0]
  def change
    remove_column :workers, :owner_id, :string
  end
end
