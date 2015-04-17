class AddAddressIdToOrder < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.integer :address_id, null: false
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :address_id
    end
  end
end
