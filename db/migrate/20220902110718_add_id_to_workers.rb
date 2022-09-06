class AddIdToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :owner_id, :bigint
  end
end
