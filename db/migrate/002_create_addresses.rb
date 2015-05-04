class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :name
      t.text :line1
      t.text :line2
      t.string :city
      t.string :state
      t.string :pincode
      t.string :land_mark
      t.string :phone_number
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
