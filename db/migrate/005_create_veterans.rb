class CreateVeterans < ActiveRecord::Migration
  def self.up
    create_table :veterans do |t|
      t.string :name
      t.string :phone_number
      t.string :pan_number
      t.text :address
      t.string :languages_known
      t.string :agency
      t.integer :expected_service_time
      t.timestamps
    end
  end

  def self.down
    drop_table :veterans
  end
end
