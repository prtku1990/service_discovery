class CreateVeteranSlots < ActiveRecord::Migration
  def change
    create_table :veteran_slots do |t|
      t.integer :veteran_id
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :is_reserved
      t.timestamps
    end
  end
end
