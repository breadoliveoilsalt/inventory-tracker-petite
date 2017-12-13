class Seller < ActiveRecord::Base

  has_many :seller_product_lines
  has_many :product_lines, through: :seller_product_lines
  has_many :product_items


end
