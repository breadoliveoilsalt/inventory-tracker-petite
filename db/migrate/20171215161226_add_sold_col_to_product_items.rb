class AddSoldColToProductItems < ActiveRecord::Migration
  def change
    add_column :product_items, :sold, :boolean, null: false, default: false
  end
end
