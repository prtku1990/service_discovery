class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.string :email_id
      t.string :password
      t.string :gender
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
