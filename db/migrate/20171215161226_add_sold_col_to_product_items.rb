class AddSoldColToInventoryItems < ActiveRecord::Migration
  def change
    add_column :inventory_items, :sold, :boolean, null: false, default: false
  end
end
