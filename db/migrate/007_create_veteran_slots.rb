class CreateVeteranSlots < ActiveRecord::Migration
  def self.up
    create_table :veteran_slots do |t|
      t.date :start_time
      t.date :end_time
      t.integer :is_reserved
      t.timestamps
    end
  end

  def self.down
    drop_table :veteran_slots
  end
end
