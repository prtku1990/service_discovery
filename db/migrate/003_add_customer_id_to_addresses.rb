class AddCustomerIdToAddresses < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.integer :customer_id
    end
  end

  def self.down
    change_table :addresses do |t|
      t.remove :customer_id
    end
  end
end
  