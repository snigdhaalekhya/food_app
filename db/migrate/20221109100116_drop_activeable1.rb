class DropActiveable1 < ActiveRecord::Migration[7.0]
  def change
    drop_table :active_storage_blobs
  end
end
