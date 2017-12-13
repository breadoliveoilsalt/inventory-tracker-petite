class CreateSellerProductLines < ActiveRecord::Migration
  def change
    create_table :seller_product_lines do |t|
      t.integer :seller_id
      t.integer :product_line_id
    end
  end
end
