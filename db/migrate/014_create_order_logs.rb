class CreateOrderLogs < ActiveRecord::Migration
  def change
    create_table :order_logs do |t|
      t.integer :order_id
      t.string :event
      t.string :from
      t.string :to
      t.timestamps
    end
  end
end
