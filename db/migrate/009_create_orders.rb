class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.date :slot_start_time
      t.string :status
      t.date :actual_start_time
      t.date :actual_end_time
      t.integer :total_price
      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
