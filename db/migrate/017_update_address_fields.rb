class UpdateAddressFields < ActiveRecord::Migration
  def change
    add_column :addresses, :country, :string
    add_column :addresses, :area, :string
    rename_column :addresses, :land_mark, :landmark
    change_column :addresses, :landmark, :text
  end
end
