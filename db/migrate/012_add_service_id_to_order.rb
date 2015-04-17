class AddServiceIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :service_id, :integer, null: false
  end
end
