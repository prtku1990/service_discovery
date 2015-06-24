class AddActiveToAddress < ActiveRecord::Migration
  def self.up
    add_column :addresses, :active, :boolean, :default => 1
  end
end