class AddServiceIdToVeteran < ActiveRecord::Migration
  def self.up
    change_table :veterans do |t|
      t.integer :service_id
    end
  end

  def self.down
    change_table :veterans do |t|
      t.remove :service_id
    end
  end
end
