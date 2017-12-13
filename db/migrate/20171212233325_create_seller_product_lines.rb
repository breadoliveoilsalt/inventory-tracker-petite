class CreateSellerProductLines < ActiveRecord::Migration
  def change
    create_table :seller_product_lines do |t|
      t.integer :user_id
      t.integer :seller_id
      t.integer :product_line_id
      t.timestamps null: true
    end
  end
end
