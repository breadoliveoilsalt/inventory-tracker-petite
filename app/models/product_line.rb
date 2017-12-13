class ProductLine < ActiveRecord::Base

  has_many :sellers, through: :seller_product_lines
  has_many :product_items

end
