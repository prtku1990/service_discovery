class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.decimal :price_per_hour, precision: 12, scale: 2
      t.timestamps
    end
  end
end
