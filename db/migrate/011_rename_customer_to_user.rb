class RenameCustomerToUser < ActiveRecord::Migration
  def change
    rename_table :customers, :users
    rename_column :addresses, :customer_id, :user_id
  end
end
