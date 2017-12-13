class CreateProductItems < ActiveRecord::Migration
  def change
    create_table :product_items do |t|
      t.string :seller
      t.date :date_created
      t.date :date_sold
      t.integer :user_id
      t.integer :seller_id
      t.integer :product_line_id
      t.timestamps null: true
    end
  end
end
