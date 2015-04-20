class UpdateDateToDatetimeInOrder < ActiveRecord::Migration
  def change
    change_column :orders, :slot_start_time, :datetime, null: false
    change_column :orders, :actual_start_time, :datetime
    change_column :orders, :actual_end_time, :datetime
  end
end
