class DropProductsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :active_storage_attachments
  end
end
