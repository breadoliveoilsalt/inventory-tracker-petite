class ProductLine < ActiveRecord::Base

  belongs_to :user
  has_many :seller_product_lines
  has_many :sellers, through: :seller_product_lines
  has_many :product_items

end
