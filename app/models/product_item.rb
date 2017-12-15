class ProductItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :seller
  belongs_to :product_line

  def self.create_inventory(product_line, num)
    num.to_i.times do
      self.create(product_line_id: product_line.id, user_id: product_line.user_id)
    end
  end
end
