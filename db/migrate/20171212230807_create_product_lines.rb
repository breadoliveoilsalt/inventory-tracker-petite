class CreateProductLines < ActiveRecord::Migration
  def change
    create_table :product_lines do |t|
      t.string :product_name
      t.string :description
      t.integer :user_id
      t.timestamps null: true
    end
  end
end
