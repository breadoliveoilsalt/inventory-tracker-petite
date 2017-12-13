class CreateProductLines < ActiveRecord::Migration
  def change
    create_table :product_lines do |t|
      t.string :product_name
      t.string :type
      t.float :cost_to_make
      t.float :sale_price
      t.string :description
    end
  end
end
