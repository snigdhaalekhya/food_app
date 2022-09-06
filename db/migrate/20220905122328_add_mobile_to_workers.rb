class AddMobileToWorkers < ActiveRecord::Migration[7.0]
  def change
    add_column :workers, :mobile_no, :bigint
  end
end
