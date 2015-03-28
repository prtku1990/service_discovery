class AddVeteranIdToVeteranSlot < ActiveRecord::Migration
  def self.up
    change_table :veteran_slots do |t|
      t.integer :veteran_id
    end
  end

  def self.down
    change_table :veteran_slots do |t|
      t.remove :veteran_id
    end
  end
end
