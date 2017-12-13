class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.string :seller_name
      t.date :start_date
      t.integer :user_id
      t.timestamps null: true
    end
  end
end
