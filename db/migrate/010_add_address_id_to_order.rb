class AddAddressIdToOrder < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.integer :order_id
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :order_id
    end
  end
end
