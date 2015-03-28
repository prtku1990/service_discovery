class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :name
      t.text :line1
      t.text :line2
      t.string :city
      t.string :state
      t.string :pincode
      t.string :phone_number
      t.integer :is_primary, :limit=>1
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
