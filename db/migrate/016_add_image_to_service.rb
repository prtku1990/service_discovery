class AddImageToService < ActiveRecord::Migration
  def change
    add_column :services, :image, :text
  end
end
