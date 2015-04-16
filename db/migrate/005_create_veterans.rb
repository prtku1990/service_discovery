class CreateVeterans < ActiveRecord::Migration
  def change
    create_table :veterans do |t|
      t.integer :service_id
      t.string :name
      t.integer :contact_number
      t.integer :pan
      t.text :address
      t.text :languages_known
      t.string :agency
      t.integer :expected_service_minutes #varies according to speed of veterans
      t.integer :expected_travel_minutes_before #varies according to speed of veterans
      t.timestamps
    end
  end
end
